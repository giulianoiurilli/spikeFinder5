
%%
odorsRearranged = [1 2 3 4 6 7 8 9 10 11 12 13 14 15];
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 2:length(esp)
    for idxShank = 1:4
%         if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
%                 if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        %resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        resp(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = double(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            responseCell1Mean(idxCell1, idxO) = mean(app);
                            responseCell1All(idxCell1,:,idxO) = app2;
                            app = [];
                            app = double(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor (idxOdor).AnalogicBsl1000ms);
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            baselineCell1All(idxCell1,:,idxO) = app2;
                        end
                    end
                end
            end
        end

%%
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';
clims = [0 1];
rho = corr(dataAll);
figure
imagesc(rho,clims)
axis square

rho1 = corr(responseCell1Mean);

figure
imagesc(rho1, clims)
axis square

figure
histogram(rho1, 20, 'normalization', 'probability')
xlim([0 1])



