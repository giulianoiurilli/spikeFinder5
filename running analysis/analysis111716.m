
folder = fullfile(pwd, 'binnedNMtime');
mkdir(folder)
odors = 1:6;
prepareDataForClassification(esp, odors, folder);

raster_labels = [];
nOdors = length(odors);
idxCell = 0;
for idxExp = 1:length(esp)
    cd(fullfile((esp(idxExp).filename), 'ephys'))
    load('units.mat')
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 %&& esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    app1000 = zeros(1,15);
                    app300 = zeros(1,15);
                    for idxOdor = 1:15              
                        app1000(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;  
                        app300(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1; 
                    end
                    if sum(app1000) > 0 || sum(app300) > 0
                        idxCell = idxCell + 1;
                        raster_data = [];
                        idxT = 0;
                        idxO = 0;
                        for idxOdor = odors
                            idxO = idxO + 1;
                            app = double(shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor));
                            raster_data = [raster_data; app];
                            if idxO < 4
                                cla = 1;
                            end
                            if idxO > 3 && idxO < 7
                                cla = 2;
                            end
                            if idxO > 6
                                cla = 3;
                            end

                            for idxTrial = 1:10
                                idxT = idxT + 1;
%                                 raster_labels.stimulusID{idxT} = num2str(cla);
                                raster_labels.stimulusID{idxT} = num2str(idxO);
                            end
                        end
                        raster_site_info = [];
                        filename = sprintf('rasters_cell_%d.mat', idxCell);
                        cd(folder)
                        save(filename, 'raster_data', 'raster_labels', 'raster_site_info');
                    end
                end
            end
        end
    end
end

cd ..





%%
folder = 'binnedNMtime';
raster_file_directory_name = folder;
save_prefix_name = 'Binned_data';
binned_format_file_name = 'Binned_data_100ms_bins_50ms_sampled_3000start_time_8000end_time.mat';




bin_width = 100;
step_size = 50;
start_time = 3000;
end_time = 8000;


create_binned_data_from_raster_data(raster_file_directory_name, save_prefix_name, bin_width, step_size, start_time, end_time);
                       
%%
% the name of the file that has the data in binned-format
% will decode the identity of which object was shown (regardless of its position)
option.classifierType = 3;
specific_label_name_to_use = 'stimulusID';
num_cv_splits = 9;
idxSite = 0;
for j = 210
    idxSite = idxSite + 1;
    
    
    if option.classifierType == 1
        load_data_as_spike_counts = 1;
        ds = basic_DS(binned_format_file_name, specific_label_name_to_use, num_cv_splits, load_data_as_spike_counts);
    else
        ds = basic_DS(binned_format_file_name, specific_label_name_to_use, num_cv_splits);
    end
    ds.num_resample_sites = j;
    
    
    % create a feature preprocessor that z-score normalizes each neuron
    % note that the FP objects are stored in a cell array
    % which allows multiple FP objects to be used in one analysis
    the_feature_preprocessors{1} = zscore_normalize_FP;
    
    
    % create the CL object
    the_classifier = [];
    
    switch option.classifierType
        case   2
            the_classifier = max_correlation_coefficient_CL;
        case  3
            
            the_classifier = libsvm_CL;
            the_classifier.C = 10;
            %the_classifier.multiclass_classification_scheme = 'one_vs_all';
        case  4
            the_classifier.kernel = 'gaussian';
            the_classifier.gaussian_gamma = 1;
        case  1
            the_classifier = poisson_naive_bayes_CL;
    end
    
    % create the CV object
    the_cross_validator = [];
    if option.classifierType == 1
        the_cross_validator = standard_resample_CV(ds, the_classifier);
    else
        the_cross_validator = standard_resample_CV(ds, the_classifier, the_feature_preprocessors);
    end
    
    % set how many times the outer 'resample' loop is run
    % generally we use more than 2 resample runs which will give more accurate results
    % but to save time in this tutorial we are using a small number.
    the_cross_validator.num_resample_runs = 10;
    the_cross_validator.test_only_at_training_times = 0;
    
    % run the decoding analysis
    DECODING_RESULTS = [];
    DECODING_RESULTS = the_cross_validator.run_cv_decoding;
%     meanAccuracy(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results;
%     stdevAccuracy(idxSite) = mean(DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.stdev.all_single_CV_vals(:));
end

%%
app = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.confusion_matrix_results.confusion_matrix;
confMat = app ./ repmat(sum(app,1), size(app,1), 1);

%%
save_file_name = 'results1';
save(save_file_name, 'DECODING_RESULTS');


result_names{1} = save_file_name;  
 
% create the plot results object          
figure
plot_obj = plot_standard_results_object(result_names);
 
% put a line at the time when the stimulus was shown
plot_obj.significant_event_times = 4000;
 
% display the results
plot_obj.plot_results;

%%
figure
% create the plot results object
% note that this object takes a string in its constructor not a cell array
plot_obj = plot_standard_results_TCT_object(save_file_name);
 
% put a line at the time when the stimulus was shown
plot_obj.significant_event_times = 4000;
 
% display the results
plot_obj.plot_results;


 
