
startingFolder = pwd;
for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    load('unitsWarp.mat', 'shankWarp');
    load('parameters.mat');
    for idxShank = 1:4
        for idxUnit = 1:length(shankWarp(idxShank).cell)
            for idxOdor = 1:odors
                appBsl = [];
                appRsp = [];
                % I take a window of 4 cycles
                appBsl = sum(shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(:,5*360 + 1 : 9*360), 2);
                appRsp = sum(shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(:,10*360 + 1 : 14*360), 2);
                a = [];
                a = {appBsl' appRsp'};
                [t, df, pvals, surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = 0;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse = appRsp;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC = 0.5;
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) && (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = 1;
                        exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC = findAuROC(appBsl, appRsp);
                    else
                        if (mean(a{2}) < mean(a{1})) && (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = -1;
                            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC = findAuROC(appBsl, appRsp);
                        end
                    end
                end
            end
        end
    end
end

cd(startingFolder)
clearvars -except List exp 
save('aPCx_aveatt_Area.mat', 'exp', '-append')
                
                            
                            
                        
                