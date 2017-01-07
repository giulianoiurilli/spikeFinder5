function [auRocV significant] = findAurocValence(esp, odors, lratio)
% between class prediction
n_trials = 10;
cSeries = [1:5; 6:10];
auRocV = [];
significant = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    resp = [];
                    for idxOdor = odors
                        resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        %                         resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        odor1S = nan*ones(50, 2);
                        for idxClass = 1:2
                            idxSeries = cSeries(idxClass,:);
                            A1s = nan*ones(n_trials, 5);
                            j = 0;
                            for idxOdor = idxSeries(1):idxSeries(5)
                                j = j+1;
                                A1s(:, j) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms'-...
                                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                            end
                            odor1S(:,idxClass) = A1s(:);
                        end
                        [x, y] = findAuROC(odor1S(:,1)', odor1S(:,2)', 1);
                        auRocV = [auRocV x];
                        significant = [significant y];
                    end
                end
            end
        end
    end
end