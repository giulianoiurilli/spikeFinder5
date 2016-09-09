add_ndt_paths_and_init_rand_generator
%%
nTrials = 10;
nOdors = 15;
nTimepoints = 30000;

espe = coa151.espe;
esp = coa15.esp;
idxCell = 0;
for idxEsp = 1:length(espe)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxEsp).shankNowarp(idxShank).cell)
            if esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                raster_data = [];
                idxT = 0;
                for idxOdor = 1:nOdors
                    raster_data = [raster_data; double(espe(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix)];
                    for idxTrial = 1:nTrials
                        idxT = idxT + 1;
                        raster_labels.stimulusID{idxT} = num2str(idxOdor);
                    end
                end
                raster_site_info = [];
                filename = sprintf('rasters_cell_%d.mat', idxCell);
                save(filename, 'raster_data', 'raster_labels', 'raster_site_info');
            end
        end
    end
end


%%
raster_file_directory_name = 'COA/';
save_prefix_name = 'Binned_COA_data';
binned_format_file_name = 'Binned_COA_data_1000ms_bins_1000ms_sampled_14000start_time_16000end_time.mat';


% raster_file_directory_name = 'PCX/';
% save_prefix_name = 'Binned_PCX_data';
% binned_format_file_name = 'Binned_PCX_data_1000ms_bins_1000ms_sampled_14000start_time_16000end_time.mat';


bin_width = 1000;
step_size = 1000;
start_time = 14000;
end_time = 16000;
Bayes = 0;

create_binned_data_from_raster_data(raster_file_directory_name, save_prefix_name, bin_width, step_size, start_time, end_time);


%%
% the name of the file that has the data in binned-format


% will decode the identity of which object was shown (regardless of its position)
specific_label_name_to_use = 'stimulusID';

num_cv_splits = 9;
idxSite = 0;
for j = 10:10:150;
    idxSite = idxSite + 1;
    
    
    if Bayes == 1
        load_data_as_spike_counts = 1;
        ds = basic_DS(binned_format_file_name, specific_label_name_to_use, num_cv_splits, load_data_as_spike_counts);
    else
        ds = basic_DS(binned_format_file_name, specific_label_name_to_use, num_cv_splits);
    end
    ds.num_resample_sites = j;
    
    %%
    % create a feature preprocessor that z-score normalizes each neuron
    
    % note that the FP objects are stored in a cell array
    % which allows multiple FP objects to be used in one analysis
    
    the_feature_preprocessors{1} = zscore_normalize_FP;
    
    %%
    % create the CL object
    the_classifier = [];
%     the_classifier = max_correlation_coefficient_CL;
    
    the_classifier = libsvm_CL;
    the_classifier.C = 10;
    %the_classifier.multiclass_classification_scheme = 'one_vs_all';
%     the_classifier.kernel = 'gaussian';
%     the_classifier.gaussian_gamma = 1;
    
%     the_classifier = poisson_naive_bayes_CL;
    
    %%
    % create the CV object
    the_cross_validator = [];
    
    if Bayes == 1
        the_cross_validator = standard_resample_CV(ds, the_classifier);
    else
        the_cross_validator = standard_resample_CV(ds, the_classifier, the_feature_preprocessors);
    end
    
    
    % set how many times the outer 'resample' loop is run
    % generally we use more than 2 resample runs which will give more accurate results
    % but to save time in this tutorial we are using a small number.
    
    the_cross_validator.num_resample_runs = 10;
    
    %%
    % run the decoding analysis
    DECODING_RESULTS = [];
    DECODING_RESULTS = the_cross_validator.run_cv_decoding;
    
    meanAccuracyLinearSVMCoa(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyLinearSVMPcx(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyRBFSVMCoa(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyRBFSVMPcx(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyCorrelationCoa(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyCorrelationPcx(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyNBPCoa(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%     meanAccuracyNBPSVMPcx(idxSite) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
end





%%
figure
x = 10:10:150;
subplot(2,2,1)
plot(x, meanAccuracyLinearSVMCoa*100, '-s', 'color', coaC, 'MarkerEdgeColor', coaC, 'MarkerEdgeColor', coaC, 'MarkerSize', 10);
hold on
plot(x, meanAccuracyLinearSVMPcx*100, '-s', 'color', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerSize', 10);
title('Linear SVM')
ylabel('Accuracy %')
xlabel('Number Of Neurons')
ylim([0 100])
grid on
set(gca,  'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(2,2,2)
plot(x, meanAccuracyRBFSVMCoa*100, '-o', 'color', coaC, 'MarkerEdgeColor', coaC, 'MarkerEdgeColor', coaC, 'MarkerSize', 10);
hold on
plot(x, meanAccuracyRBFSVMPcx*100, '-o', 'color', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerSize', 10);
title('Gaussian Radial Basis Function SVM')
ylabel('Accuracy %')
xlabel('Number Of Neurons')
ylim([0 100])
grid on
set(gca,  'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(2,2,3)
plot(x, meanAccuracyCorrelationCoa*100, '-p', 'color', coaC, 'MarkerEdgeColor', coaC, 'MarkerEdgeColor', coaC, 'MarkerSize', 10);
hold on
plot(x, meanAccuracyCorrelationPcx*100, '-p', 'color', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerSize', 10);
title('Template Matching (Correlation)')
ylabel('Accuracy %')
xlabel('Number Of Neurons')
ylim([0 100])
grid on
set(gca,  'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(2,2,4)
plot(x, meanAccuracyNBPCoa*100, '-h', 'color', coaC, 'MarkerEdgeColor', coaC, 'MarkerEdgeColor', coaC, 'MarkerSize', 10);
hold on
plot(x, meanAccuracyNBPSVMPcx*100, '-h', 'color', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerEdgeColor', pcxC, 'MarkerSize', 10);
title('Poisson Naive Bayes')
ylabel('Accuracy %')
xlabel('Number Of Neurons')
ylim([0 100])
grid on
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
suptitle('Odor Identity - All Pairs Method')









