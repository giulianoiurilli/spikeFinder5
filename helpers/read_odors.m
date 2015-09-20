
function [trial_odor] = readscan


fileID = fopen('*.asc');
trial_log = textscan(fileID, '%d,%d,%d,%f,%f,%d,%f,%f,%s');
fclose(fileID)

trial_odor(:,1) = 1:150;
trial_odor(:,2) = trial_log{3} - 1;
%trial_odor = sortrows(trial_odor,2);

%celldisp(a)

end