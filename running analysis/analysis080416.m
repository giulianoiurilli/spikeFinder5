add_ndt_paths_and_init_rand_generator

% %%
% espe = pcxCS1.espe;
% esp = pcxCS.esp;
% %%
% nTrials = 10;
% nOdors = 15;
% nTimepoints = 30000;
% 
% idxCell = 0;
% for idxEsp = 1:length(espe)
%     for idxShank = 1:4
%         for idxUnit = 1:length(esp(idxEsp).shankNowarp(idxShank).cell)
%             if esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).good == 1
%                 idxCell = idxCell + 1;
%                 raster_data = [];
%                 idxT = 0;
%                 idxConc = 0;
%                 for idxOdor = 1:5
%                     idxConc = idxConc + 1;
%                     raster_data = [raster_data; double(espe(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix)];
%                     for idxTrial = 1:nTrials
%                         idxT = idxT + 1;
%                         raster_labels.stimulusID{idxT} = 'pen';
%                         raster_labels.stimulusConc{idxT} = num2str(idxConc);
%                         raster_labels.combined_ID_Conc{idxT} = [raster_labels.stimulusID{idxT} '_' raster_labels.stimulusConc{idxT}];
%                     end
%                 end
%                 idxConc = 0;
%                 for idxOdor = 6:10
%                     idxConc = idxConc + 1;
%                     raster_data = [raster_data; double(espe(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix)];
%                     for idxTrial = 1:nTrials
%                         idxT = idxT + 1;
%                         raster_labels.stimulusID{idxT} = 'tig';
%                         raster_labels.stimulusConc{idxT} = num2str(idxConc);
%                         raster_labels.combined_ID_Conc{idxT} = [raster_labels.stimulusID{idxT} '_' raster_labels.stimulusConc{idxT}];
%                     end
%                 end
%                 idxConc = 0;
%                 for idxOdor = 11:15
%                     idxConc = idxConc + 1;
%                     raster_data = [raster_data; double(espe(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix)];
%                     for idxTrial = 1:nTrials
%                         idxT = idxT + 1;
%                         raster_labels.stimulusID{idxT} = 'iaa';
%                         raster_labels.stimulusConc{idxT} = num2str(idxConc);
%                         raster_labels.combined_ID_Conc{idxT} = [raster_labels.stimulusID{idxT} '_' raster_labels.stimulusConc{idxT}];
%                     end
%                 end
%                 raster_site_info = [];
%                 filename = sprintf('rasters_cell_%d.mat', idxCell);
%                 save(filename, 'raster_data', 'raster_labels', 'raster_site_info');
%             end
%         end
%     end
% end
%%
% mkdir concentration_invariance_results_Coa;
raster_file_directory_name = 'COA/';
save_prefix_name = 'Binned_COA_data';
binned_format_file_name = 'Binned_COA_data_1000ms_bins_1000ms_sampled_14000start_time_16000end_time.mat';
specific_labels_names_to_use = 'combined_ID_Conc'; 

% mkdir concentration_invariance_results_Pcx;
% raster_file_directory_name = 'PCX/';
% save_prefix_name = 'Binned_PCX_data';
% binned_format_file_name = 'Binned_PCX_data_1000ms_bins_1000ms_sampled_14000start_time_16000end_time.mat';
% specific_labels_names_to_use = 'combined_ID_Conc'; 




bin_width = 1000;
step_size = 1000;
start_time = 4000;
end_time = 5000;
Bayes = 1;

create_binned_data_from_raster_data(raster_file_directory_name, save_prefix_name, bin_width, step_size, start_time, end_time);



%%
% the name of the file that has the data in binned-format





the_feature_preprocessors{1} = zscore_normalize_FP;
num_cv_splits = 10;
id_odor_labels = {'pen', 'tig', 'iaa'};
concentration_labels = {'1', '2', '3', '4', '5'};


the_classifier = [];
% the_classifier = max_correlation_coefficient_CL;

the_classifier = libsvm_CL;
the_classifier.C = 10;
the_classifier.multiclass_classification_scheme = 'one_vs_all';


%%
for iTrainConcentration = 1:5
    
   for iTestConcentration = 1:5
       
      for iID = 1:3
            the_training_label_names{iID} = {[id_odor_labels{iID} '_' concentration_labels{iTrainConcentration}]};
            the_test_label_names{iID} =  {[id_odor_labels{iID} '_' concentration_labels{iTestConcentration}]};
      end
 
      if Bayes == 1
          load_data_as_spike_counts = 1;
          ds = generalization_DS(binned_format_file_name, specific_labels_names_to_use, num_cv_splits, the_training_label_names, the_test_label_names, load_data_as_spike_counts);
      else
          ds = load_data_as_spike_counts;
      end
      
      
%       ds = generalization_DS(binned_format_file_name, specific_labels_names_to_use, num_cv_splits, the_training_label_names, the_test_label_names);
      ds.num_resample_sites = 200;
      
      
      if Bayes == 1
          the_cross_validator = standard_resample_CV(ds, the_classifier);
      else
          the_cross_validator = standard_resample_CV(ds, the_classifier, the_feature_preprocessors);
      end
%       the_cross_validator = standard_resample_CV(ds, the_classifier, the_feature_preprocessors);
      the_cross_validator.num_resample_runs = 100;
      DECODING_RESULTS = the_cross_validator.run_cv_decoding;
 
      save_file_name = ['concentration_invariance_results_Coa/train_conc' num2str(iTrainConcentration) 'test_conc' num2str(iTestConcentration)];
%       save_file_name = ['concentration_invariance_results_Pcx/train_conc' num2str(iTrainConcentration) 'test_conc' num2str(iTestConcentration)];
 
      save(save_file_name, 'DECODING_RESULTS')
 
   end
   
end

%%
% figure
% position_names = {'-5', '-4', '-3', '-2', '-1'};
%  
% for iTrainConcentration = 1:5
%    
%    for iTestConcentration = 1:5
% %        load(['concentration_invariance_results_Coa/train_conc' num2str(iTrainConcentration) 'test_conc' num2str(iTestConcentration)]);
%        load(['concentration_invariance_results_Pcx/train_conc' num2str(iTrainConcentration) 'test_conc' num2str(iTestConcentration)]);
%  
%         all_results(iTrainConcentration, iTestConcentration) = DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2);
%    end
%  
%    subplot(1, 5, iTrainConcentration)
%    bar(all_results(iTrainConcentration, :) .* 100);
%  
%    title(['Train ' position_names{iTrainConcentration}])
%    ylabel('Classification Accuracy');
%    set(gca, 'XTickLabel', position_names);
%    xlabel('Test concentration')
%    ylim([0 100]);
%    xlim([0 6])
%    xLims = get(gca, 'XLim');
%    
%    line([xLims], [1/3 1/3]*100, 'color', [0 0 0]);  % put line at chance decoding accuracy
%    set(gca,  'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 12, 'box', 'off')
%  
% end
%  
% 
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[92 630 1542 420]);


%%
figure
position_names = {'-5', '-4', '-3', '-2', '-1'};
 
for iTrainConcentration = 1:5
   
   for iTestConcentration = 1:5
       aCoa = load(['concentration_invariance_results_Coa/train_conc' num2str(iTrainConcentration) 'test_conc' num2str(iTestConcentration)]);
       aPcx = load(['concentration_invariance_results_Pcx/train_conc' num2str(iTrainConcentration) 'test_conc' num2str(iTestConcentration)]);
 
        all_results_mean_Coa(iTrainConcentration, iTestConcentration) = aCoa.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2)*100;
        all_results_std_Coa(iTrainConcentration, iTestConcentration) = aCoa.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.stdev.over_resamples(2,2)*100;
        all_bsl_mean_Coa(iTrainConcentration, iTestConcentration) = aCoa.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,1)*100;
        all_bsl_std_Coa(iTrainConcentration, iTestConcentration) = aCoa.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.stdev.over_resamples(2,1)*100;
        
        all_results_mean_Pcx(iTrainConcentration, iTestConcentration) = aPcx.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,2)*100;
        all_results_std_Pcx(iTrainConcentration, iTestConcentration) = aPcx.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.stdev.over_resamples(2,2)*100;
        all_bsl_mean_Pcx(iTrainConcentration, iTestConcentration) = aPcx.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.mean_decoding_results(2,1)*100;
        all_bsl_std_Pcx(iTrainConcentration, iTestConcentration) = aPcx.DECODING_RESULTS.ZERO_ONE_LOSS_RESULTS.stdev.over_resamples(2,1)*100;
   end
 
   subplot(1, 5, iTrainConcentration)
   errorbar(1:5, all_results_mean_Coa(iTrainConcentration, :), all_results_std_Coa(iTrainConcentration, :), '-o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 5, 'color', coaC);
   hold on
   errorbar(1.2:5.2, all_results_mean_Pcx(iTrainConcentration, :), all_results_std_Pcx(iTrainConcentration, :), '-o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 5, 'color', pcxC);
%    hold on
%    shadedErrorBar(1:5, all_bsl_mean_Coa(iTrainConcentration, :), all_bsl_std_Coa(iTrainConcentration, :), 'r');
%    hold on
%    shadedErrorBar(1.2:5.2, all_bsl_mean_Pcx(iTrainConcentration, :), all_bsl_std_Pcx(iTrainConcentration, :), 'k');
   hold on
   plot(1:5, all_bsl_mean_Coa(iTrainConcentration, :), ':', 'color', coaC);
   hold on
   plot(1.2:5.2, all_bsl_mean_Pcx(iTrainConcentration, :), ':', 'color', pcxC);
 
   title(['Train ' position_names{iTrainConcentration}])
   ylabel('Classification Accuracy');
   set(gca, 'XTickLabel', position_names);
   xlabel('Test concentration')
   ylim([0 100]);
   xlim([0 6])
   xLims = get(gca, 'XLim');
   
   %line([xLims], [1/3 1/3]*100, 'color', [0 0 0]);  % put line at chance decoding accuracy
   set(gca,  'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 12, 'box', 'off')
 
end
 

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[92 630 1542 420]);








