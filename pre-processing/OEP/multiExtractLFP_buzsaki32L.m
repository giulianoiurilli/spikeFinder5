shank_lfp = [0 6 28 30];

for i = shank_lfp
    string = sprintf('CSC%d.mat', i);
    extractLFP(string);
end