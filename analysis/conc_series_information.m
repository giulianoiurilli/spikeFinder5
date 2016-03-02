fileToSave = 'pcx_Mix_2_2.mat';
load('parameters.mat')

%%
% % odor identity prediction (regardless the concentratrion) 
% cSeries = [1:5; 6:10; 11:15];
% for idxExp = 1:length(esp) 
%     for idxShank = 1:4
%         for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
%             if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
%                 odor1S = nan*ones(50, 3);
%                 for idxOdor = 1:3
%                     idxSeries = cSeries(idxOdor,:);
%                     A1s = nan*ones(n_trials, 5);
%                     j = 0;
%                     for idxConc = idxSeries(1):idxSeries(5)
%                         j = j+1;
%                         A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxConc).AnalogicResponse1000ms';
%                     end
%                     odor1S(:,idxOdor) = A1s(:);
%                 end
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1sOdorIdentity = poissonInformation(odor1S);
%             end
%         end
%     end
% end
% 
% %%
% % odor identity prediction at each concentration
% cSeries = [1,6,11; 2,7,12; 3,8,13; 4,9,14; 5,10,15];
% for idxExp = 1:length(esp) 
%     for idxShank = 1:4
%         for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
%             if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
%                 for idxConc = 1:5
%                     idxSeries = cSeries(idxConc,:);
%                     A1s = nan*ones(n_trials,3);
%                     j = 0;
%                     for idxOdor = idxSeries(1):idxSeries(3)
%                         j = j+1;
%                         A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
%                     end
%                     esp(idxExp).shankNowarp(idxShank).cell(idxUnit).concentration(idxConc).I1sOdor = poissonInformation(A1s);
%                 end
%             end
%         end
%     end
% end

%%
% odor concentration prediction for each odor
cSeries = [1:5; 6:10; 11:15];
for idxExp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = 1:3
                    idxSeries = cSeries(idxOdor,:);
                    A1s = nan*ones(n_trials,5);
                    j = 0;
                    for idxConc = idxSeries(1):idxSeries(5)
                        j = j+1;
                        A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxConc).AnalogicResponse1000ms';
                    end
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odorClass(idxOdor).I1sConc = poissonInformation(A1s);
                end
            end
        end
    end
end

%%
clearvars -except List esp fileToSave
save(fileToSave, 'esp', '-append')
     
                    