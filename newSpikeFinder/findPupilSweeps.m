function findPupilSweeps(nOdors, nTrials)

s = dir('*.mat');
filename = s.name;
load(filename)



rawSignal = pupil.diameter;


rawSignal = reshape(rawSignal, round(length(rawSignal)/(nOdors*nTrials)), (nOdors*nTrials));

medFilteredSignal = medfilt1(rawSignal, 5);
pupil.smoothed_medFilteredSignal = [];
for idxC = 1:size(medFilteredSignal,2)
    y = medFilteredSignal(:,idxC);
    smoothed_medFilteredSignal(:,idxC) = smooth(y, 0.1, 'rloess');
end



%% re-sort the odor onsets according to odors and trials
s = dir('*.asc'); 
filename = char({s.name});
fileID = fopen(filename);
trial_log = textscan(fileID, '%d,%d,%d,%f,%f,%d,%f,%f,%s');
fclose(fileID);
trial_odor = trial_log{3} - 1;

app = [smoothed_medFilteredSignal' double(trial_odor)];
app = sortrows(app, size(app,2));
app(:, size(app,2)) = [];

smoothed_medFilteredSignal = app;
pupil.size = [];

for idxOdor = 1:nOdors
    k = nTrials*(idxOdor-1);
    pupil.size(:, :, idxOdor) = smoothed_medFilteredSignal(1 + k:nTrials + k,:);
end

save('pupilSize.mat', 'pupil')


%%
% close all
% figure
% for idxOdor = 1:15
%     subplot(3,5,idxOdor)
%     x = mean(pupil.size(:, :, idxOdor));
%     plot(x - mean(x(1:45)))
%     ylim([-5 30])
%     xlim([0 241])
% end
% 
% figure
% clims = [80 130];
% for idxOdor = 1:15
%     subplot(3,5,idxOdor)
%     imagesc(pupil.size(:, :, idxOdor), clims)
% end




