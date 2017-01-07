folderlist = {esp(:).filename};
odorsRearranged = 1:15;

Fs = 20000;
lfp_fs = 1000;


odors = length(odorsRearranged);


response_window = 3;



[b,a] = butter(4,[0.1,300]*2/lfp_fs);

params.Fs=lfp_fs;
params.fpass=[0 100];
params.pad=0;
params.tapers=[10 19];

movingwin=[0.5 0.05];
params.tapers=[5 9];
params.trialave = 1;
params.err = 0;



nExp = length(folderlist);
thetaR = nan(nExp, odors);
betaR = nan(nExp, odors);
gammaR = nan(nExp, odors);



startingFolder = pwd;
for idxExp = 1 : length(folderlist)
    folderExp = folderlist{idxExp};
    cd(folderExp)
%     cd(fullfile(folderExp, 'ephys'))
    

    load('CSC0.mat', 'Samples')
    load('breathing.mat', 'breath', 'sec_on_rsp', 'sec_on_bsl');
    
    
    lfp = downsample(Samples,Fs/lfp_fs);
    
    lfpBslTrials = zeros(10, response_window*lfp_fs, odors);
    lfpRspTrials = zeros(10, response_window*lfp_fs, odors);
    for idxOdor = odorsRearranged   %cycles through odors
        for idxTrial = 1:10     %cycles through trials
            bsl_lfp = [];
            bsl_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor) - response_window - 1)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) - 1)*lfp_fs));
            bsl_lfp = filtfilt(b,a,bsl_lfp);
            bsl_lfp = rmlinesc(bsl_lfp, params);
            lfpBslTrials(idxTrial,:,idxOdor) = bsl_lfp(1:response_window*lfp_fs);
            rsp_lfp = [];
            rsp_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor))*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + response_window)*lfp_fs));
            rsp_lfp = filtfilt(b,a,rsp_lfp);
            rsp_lfp = rmlinesc(rsp_lfp, params);
            lfpRspTrials(idxTrial,:,idxOdor) = rsp_lfp(1:response_window*lfp_fs);
        end
        
        [SBsl,fBsl]=mtspectrumc(squeeze(lfpBslTrials(:,:,idxOdor))', params);
        thetaPowerBsl = 10*log10(sum(SBsl(find(fBsl>0.9,1):find(fBsl>6,1))));
        [SRsp,fRsp]=mtspectrumc(squeeze(lfpRspTrials(:,:,idxOdor))', params);
        thetaPowerRsp = 10*log10(sum(SRsp(find(fRsp>0.9,1):find(fRsp>6,1))));
        thetaR(idxExp,idxOdor) = (thetaPowerRsp - thetaPowerBsl)./thetaPowerBsl;
        pBsl = mean(bandpower(squeeze(lfpBslTrials(:,:,idxOdor))', lfp_fs, [0.9 6]));
        pRsp = mean(bandpower(squeeze(lfpRspTrials(:,:,idxOdor))', lfp_fs, [0.9 6]));
        thetaR1(idxExp,idxOdor) = (pRsp - pBsl)./ pBsl;
        
        [SBsl,fBsl]=mtspectrumc(squeeze(lfpBslTrials(:,:,idxOdor))', params);
        betaPowerBsl = 10*log10(sum(SBsl(find(fBsl>10,1):find(fBsl>30,1))));
        [SRsp,fRsp]=mtspectrumc(squeeze(lfpRspTrials(:,:,idxOdor))', params);
        betaPowerRsp = 10*log10(sum(SRsp(find(fRsp>10,1):find(fRsp>30,1))));
        betaR(idxExp,idxOdor) = (betaPowerRsp - betaPowerBsl)./betaPowerBsl;
        pBsl = mean(bandpower(squeeze(lfpBslTrials(:,:,idxOdor))', lfp_fs, [10 30]));
        pRsp = mean(bandpower(squeeze(lfpRspTrials(:,:,idxOdor))', lfp_fs, [10 30]));
        betaR1(idxExp,idxOdor) = (pRsp - pBsl)./ pBsl;
        
        
        [SBsl,fBsl]=mtspectrumc(squeeze(lfpBslTrials(:,:,idxOdor))', params);
        gammaPowerBsl = 10*log10(sum(SBsl(find(fBsl>70,1):find(fBsl>99,1))));
        [SRsp,fRsp]=mtspectrumc(squeeze(lfpRspTrials(:,:,idxOdor))', params);
        gammaPowerRsp = 10*log10(sum(SRsp(find(fRsp>70,1):find(fRsp>99,1))));
        gammaR(idxExp,idxOdor) = (gammaPowerRsp - gammaPowerBsl)./gammaPowerBsl;
        pBsl = mean(bandpower(squeeze(lfpBslTrials(:,:,idxOdor))', lfp_fs, [70 99]));
        pRsp = mean(bandpower(squeeze(lfpRspTrials(:,:,idxOdor))', lfp_fs, [70 99]));
        gammaR1(idxExp,idxOdor) = (pRsp - pBsl)./ pBsl;
    end
end

cd(startingFolder)
clearvars -except thetaR betaR gammaR thetaR1 betaR1 gammaR1

save('pcx_15_bandPowers.mat', 'thetaR1', 'betaR1', 'gammaR1')
