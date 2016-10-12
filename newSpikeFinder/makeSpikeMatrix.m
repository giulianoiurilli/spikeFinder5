function makeSpikeMatrix

load('paramsExperiment.mat')
load('breathing.mat');
load('units.mat');

n_trials = size(sec_on_rsp,1);
n_odors = size(sec_on_rsp,2);
n_shanks = size(shank,2);



for idxShank = 1:n_shanks
    for idxUnit = 1:size(shank(idxShank).SUA.spiketimesUnit,2)
        sua = shank(idxShank).SUA.spiketimesUnit{idxUnit};
        sua=sua';
        r = 0;
        shank(idxShank).SUA.spike_matrix{idxUnit} = zeros(n_trials,(preOnset+postOnset)*1000, n_odors); %consider the idea of sparsifying here
        kk=1;
        for idxOdor = 1:n_odors   %cycles through odors
            for idxTrial = 1:n_trials     %cycles through trials
                sua_trial{idxTrial} = sua(find((sua > sec_on_rsp(idxTrial,idxOdor) - preOnset) & (sua < sec_on_rsp(idxTrial,idxOdor) + postOnset))) - sec_on_rsp(idxTrial,idxOdor);
                app_bsl_cycle_on = sec_on_rsp(idxTrial,idxOdor) - sec_on_bsl(idxTrial,idxOdor);
                if app_bsl_cycle_on < preOnset & app_bsl_cycle_on > responseWindow
                    shank(idxShank).SUA.bsl_cycle_on{idxUnit}(idxTrial,idxOdor) = app_bsl_cycle_on;
                else shank(idxShank).SUA.bsl_cycle_on{idxUnit}(idxTrial,idxOdor) = preOnset;
                end
                indexes = round((sua_trial{idxTrial} + preOnset)*1000);
                indexes(indexes==0) = 1;
                shank(idxShank).SUA.spike_matrix{idxUnit}(idxTrial,indexes,idxOdor) = 1; %consider the idea of sparsifying here
                shank(idxShank).SUA.sdf_trial{idxUnit}(idxTrial,:,idxOdor) = spikeDensity(shank(idxShank).SUA.spike_matrix{idxUnit}(idxTrial,:,idxOdor), sigmaSDF);
            end          
            clear sua_trial
        end
    end
    clear sua
    
end
    
save('units.mat', 'shank', '-append');
save('paramsExperiment.mat', 'n_trials', 'n_odors', '-append')

