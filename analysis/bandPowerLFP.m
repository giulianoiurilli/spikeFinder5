odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
% odorsRearranged = 1:10;
% odorsRearranged = 1:15;

Fs = 20000;
lfp_fs = 1000;


odors = length(odorsRearranged);


response_window = 4;



[b,a] = butter(4,[0.1,300]*2/lfp_fs);

params.Fs=lfp_fs;
params.fpass=[0 100];
params.pad=0;
params.tapers=[10 19];

movingwin=[0.5 0.05];
params.tapers=[5 9];
params.trialave = 1;
params.err = 0;



nExp = length(List);
thetaR = nan(nExp, odors);
betaR = nan(nExp, odors);
gammaR = nan(nExp, odors);



startingFolder = pwd;
for idxExp = 1 : length(List)%-1
    cartella = List{idxExp};
    cd(cartella)
    

    load('CSC0.mat', 'RawSamples')
    load('breathing.mat', 'breath', 'sec_on_rsp', 'sec_on_bsl');
    
    
    lfp = downsample(RawSamples,Fs/lfp_fs);
    
    lfpBslTrials = zeros(10, (response_window-1)*lfp_fs, odors);
    lfpRspTrials = zeros(10, (response_window-1)*lfp_fs, odors);
    for idxOdor = odorsRearranged   %cycles through odors
        for idxTrial = 1:10     %cycles through trials
            bsl_lfp = [];
            bsl_lfp = lfp(floor((sec_on_bsl(idxTrial,idxOdor) - response_window)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor))*lfp_fs));
            bsl_lfp = filtfilt(b,a,bsl_lfp);
            bsl_lfp = rmlinesc(bsl_lfp, params);
            lfpBslTrials(idxTrial,:,idxOdor) = bsl_lfp(lfp_fs:response_window*lfp_fs - 1);
            rsp_lfp = [];
            rsp_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor)-1)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + response_window)*lfp_fs));
            rsp_lfp = filtfilt(b,a,rsp_lfp);
            rsp_lfp = rmlinesc(rsp_lfp, params);
            lfpRspTrials(idxTrial,:,idxOdor) = rsp_lfp(lfp_fs:response_window*lfp_fs-1);
        end
        
        [SBsl,fBsl]=mtspectrumc(squeeze(lfpBslTrials(:,:,idxOdor))', params);
        thetaPowerBsl = sum(SBsl(find(fBsl>0.9,1):find(fBsl>6,1)));
        [SRsp,fRsp]=mtspectrumc(squeeze(lfpRspTrials(:,:,idxOdor))', params);
        thetaPowerRsp = sum(SRsp(find(fRsp>0.9,1):find(fRsp>6,1)));
        thetaR(idxExp,idxOdor) = (thetaPowerRsp - thetaPowerBsl)./thetaPowerBsl;
        
        [SBsl,fBsl]=mtspectrumc(squeeze(lfpBslTrials(:,:,idxOdor))', params);
        betaPowerBsl = sum(SBsl(find(fBsl>10,1):find(fBsl>30,1)));
        [SRsp,fRsp]=mtspectrumc(squeeze(lfpRspTrials(:,:,idxOdor))', params);
        betaPowerRsp = sum(SRsp(find(fRsp>10,1):find(fRsp>30,1)));
        betaR(idxExp,idxOdor) = (betaPowerRsp - betaPowerBsl)./betaPowerBsl;
        
        [SBsl,fBsl]=mtspectrumc(squeeze(lfpBslTrials(:,:,idxOdor))', params);
        gammaPowerBsl = sum(SBsl(find(fBsl>65,1):find(fBsl>95,1)));
        [SRsp,fRsp]=mtspectrumc(squeeze(lfpRspTrials(:,:,idxOdor))', params);
        gammaPowerRsp = sum(SRsp(find(fRsp>65,1):find(fRsp>95,1)));
        gammaR(idxExp,idxOdor) = (gammaPowerRsp - gammaPowerBsl)./gammaPowerBsl;
    end
end

cd(startingFolder)
clearvars -except thetaR betaR gammaR

save('pcx_CS_bandPowers.mat', 'thetaR', 'betaR', 'gammaR')
