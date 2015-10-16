% dfold = '\\research.files.med.harvard.edu\Neurobio\DattaLab\Giuliano\tetrodes_data\15 odors\plCoA\awake';
% dfold = pwd;
% List = uipickfiles('FilterSpec', dfold, ...
%     'Prompt',    'Pick all the folders you want to analyze');



for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    %     folder1 = cartella(end-11:end-6)
    %     folder2 = cartella(end-4:end)
    %     cartella = [];
    %     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/%s/%s', folder1, folder2);
    cd(cartella)
    disp(cartella)
    fatti = sprintf('%d out of %d done.', idxExperiment, length(List));
    disp(fatti)
    
    
    
    
    %Enter here the command lines
    
    
    %   parameters
    %
    %     valveOnsetTimestamp
    %
            try
                breathOnsetTimestamp
            catch
                disp('Error during breathOnsetTimestamp')
                disp(cartella)
            end
            clearvars -except List idxExperiment cartella
    
    %     try
    %         for i = 1:4
    %             filename = sprintf('CSC%d.mat', shank_lfp(i));
    %             extractLFP(filename);
    %             %         load(filename);
    %             %         exp = i;
    %             %         odor_spectrogram_Buszsaki32L;
    %         end
    %     catch
    %         disp(folder)
    %         disp(err.message)
    %     end
    
    
    try
        disp('running... makeRastersNoWarp')
        makeRastersNoWarp
        
    catch
        disp('Error during makeRastersNoWarp')
        disp(cartella)
    end
    clearvars -except List idxExperiment cartella
            try
                disp('running... makePhaseRaster1')
                makePhaseRaster1
    
            catch
                disp('Error during makePhaseRaster1')
                disp(cartella)
            end
    
            clearvars -except List idxExperiment cartella
    
            try
                disp('running... prepareBaseline')
                prepareBaseline
    
            catch
                disp('Error during prepareBaseline')
                disp(cartella)
            end
    
            clearvars -except List idxExperiment cartella
    %
    %
    %
            try
                disp('running... findPeakResponses')
                findPeakResponses
    
            catch
                disp('Error during findPeakResponses')
                disp(cartella)
            end
            clearvars -except List idxExperiment cartella
    
            try
                disp('running... findCycleSpikeRateResponse')
                findCycleSpikeRateResponse
    
            catch
                disp('Error during findCycleSpikeRateResponse')
                disp(cartella)
            end
            clearvars -except List idxExperiment cartella
    
            try
                findOptimalResponseWindow
                disp('running... findOptimalResponseWindow')
            catch
                disp('Error during findOptimalResponseWindow')
                disp(cartella)
            end
            clearvars -except List idxExperiment cartella
    
%     try
%         disp('running... partitionResponse')
%         partitionResponse
%         
%     catch
%         disp('Error during partitionResponse')
%         disp(cartella)
%     end
%     clearvars -except List idxExperiment cartella
%     
    
    %     try
    %         z_scoreResponses
    %         disp('running... z_scoreResponses')
    %     catch
    %         disp('Error during z_scoreResponses')
    %         disp(cartella)
    %     end
    %     clearvars -except List idxExperiment
    
    
    
%     try
%         preparePhaseRosePlot
%         disp('running... preparePhaseRosePlot')
%     catch
%         disp('Error during preparePhaseRosePlot')
%         disp(cartella)
%     end
%     clearvars -except List idxExperiment
    
%     try
%         makeAutocorrelogram
%         disp('running... makeAutocorrelogram')
%     catch
%         disp('Error during makeAutocorrelogram')
%         disp(cartella)
%     end
%     clearvars -except List idxExperiment
%     
    
%     try
%         tempor
%         disp('running... tempor')
%     catch
%         disp('Error during tempor')
%         disp(cartella)
%     end
%     clearvars -except List idxExperiment

%     try
%         granPlotSummaryUnit
%         disp('running... granPlotSummaryUnit')
%     catch
%         disp('Error during granPlotSummaryUnit')
%         disp(cartella)
%     end
%     clearvars -except List idxExperiment

    
    
    
    
    
    % load('units.mat');
    % provv = shank;
    % clear shank
    % for sha = 1:4
    %     shank(sha).spiketimesUnit = provv(sha).spiketimesUnit;
    % end
    % clear provv
    % save('units.mat', 'shank');
    % clearvars -except cartella List ii
    % % %
    %
    % % makeShanks
    % makeRasters
    % clearvars -except cartella List ii
    % analysis_step1
    % clearvars -except cartella List ii
    % analysis_step2
    % clearvars -except cartella List ii
    
end

    
    