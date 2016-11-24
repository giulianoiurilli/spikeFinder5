function [meanAccuracy, stdevAccuracy, meanInfo, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat] = findClassificationAccuracy(esp, nOdors, folder, option)

% esp = coaNM.esp;
% nOdors = 13;
% folder = fullfile(pwd, 'binnedSUA13odorsCoa');
% option.classifierType = 3;
% option.shuffle = 0;
% option.splits = 9;
% option.onlyexc = 0;
% option.single_cell = 0;



if option.single_cell == 1
    totalResponsiveSUA = 1;
else
    [totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, 1:nOdors, option.onlyexc);
end


%%
raster_file_directory_name = folder;
save_prefix_name = 'Binned_data';
binned_format_file_name = 'Binned_data_1000ms_bins_1000ms_sampled_4000start_time_5000end_time.mat';



bin_width = 1000;
step_size = 1000;
start_time = 4000;
end_time = 5000;


create_binned_data_from_raster_data(raster_file_directory_name, save_prefix_name, bin_width, step_size, start_time, end_time);
                       
%%
% the name of the file that has the data in binned-format
% will decode the identity of which object was shown (regardless of its position)
specific_label_name_to_use = 'stimulusID';

if option.shuffle == 1
    ds.randomly_shuffle_labels_before_running = 1;
else
    ds.randomly_shuffle_labels_before_running = 0;
end

num_cv_splits = option.splits;
idxSite = 0;
for j = 1:totalResponsiveSUA
    idxSite = idxSite + 1;
    
    
    if option.classifierType == 1
        load_data_as_spike_counts = 1;
        ds = basic_DS(binned_format_file_name, specific_label_name_to_use, num_cv_splits, load_data_as_spike_counts);
    else
        ds = basic_DS(binned_format_file_name, specific_label_name_to_use, num_cv_splits);
    end
    
    ds.num_resample_sites = j;
    
    if option.shuffle == 1
        ds.randomly_shuffle_labels_before_running = 1;
    else
        ds.randomly_shuffle_labels_before_running = 0;
    end
    
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
            the_classifier = libsvm_CL;
            the_classifier.C = 10;
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
    %the_cross_validator.num_resample_runs = 10;
    
    % run the decoding analysis
    DECODING_RESULTS = [];
    DECODING_RESULTS = the_cross_validator.run_cv_decoding;
    meanAccuracy(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results;
    stdevAccuracy(idxSite) = mean(DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.stdev.all_single_CV_vals(:));
    meanInfo(idxSite) = DECODING_RESULTS.MUTUAL_INFORMATION.from_separate_confusion_matrix_for_each_resample.mean_decoding_results;
    stdevInfo(idxSite) = DECODING_RESULTS.MUTUAL_INFORMATION.from_separate_confusion_matrix_for_each_resample.stdev.over_resamples;
end

%%
app = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.confusion_matrix_results.confusion_matrix;
confMat = app ./ repmat(sum(app,1), size(app,1), 1);
app = mean(DECODING_RESULTS.ROC_AUC_RESULTS.combined_CV_ROC_results.decoding_results);
auROCsClasses_mean = app;
app = std(DECODING_RESULTS.ROC_AUC_RESULTS.combined_CV_ROC_results.decoding_results)./...
    sqrt(size(DECODING_RESULTS.ROC_AUC_RESULTS.combined_CV_ROC_results.decoding_results,1)-1);
auROCsClasses_sem = app;
