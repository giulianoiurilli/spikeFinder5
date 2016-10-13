clc
clear

%list for intan
folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
X = [];
for ifolder = 1 : length(folderlist)
    folderKlust = folderlist(ifolder).name;
    disp(folderKlust)
    cd(folderKlust)
    load('pupilSize.mat')
    for idxOdor = 1:15
        x = mean(pupil.size(:, :, idxOdor));
        x = x - mean(x(1:50));
        X(idxOdor,:, ifolder) = x;
    end
end


x = [];
close all
figure
for idxOdor = 1:15
    subplot(3,5,idxOdor)
    x = mean(squeeze(X(idxOdor, :, :)),2);
    plot(x)
    ylim([-5 20])
    xlim([0 241])
end


    
    