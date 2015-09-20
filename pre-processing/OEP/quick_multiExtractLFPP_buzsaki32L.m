shank_lfp = [30 27 28 29 0 8 6 5];


extractDataFromIntan_multi1;



for i = shank_lfp
    string = sprintf('CSC%d.mat', i);
    extractOEP(string);
end

quickOEP;