%odorsRearranged = [1 2 5 10 15 7 8];% pcxL
%odorsRearranged = [14 6 4 12 13 3 11 ];% pcxH
%odorsRearranged = [14 6 4 12 13 3 11 9];% pcxH8
%odorsRearranged = [6 1 3 13 12 7 5];% coaL
%odorsRearranged = [14 2 15 4 10 11 8];% coaH
%odorsRearranged = [14 2 15 4 10 11 8 9];% coaH8


odorsRearranged = 1:15;
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(pcx2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
info1Pcx = zeros(1,c);
c = 0;
for idxExp =  1:length(pcx2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                info1Pcx(c) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end



%%
odorsRearranged = 1:15;
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(coa2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
info1Coa = zeros(1,c);
c = 0;
for idxExp =  1:length(coa2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                info1Coa(c) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end


%%
odorsRearranged = [14 6 4 12 13 3 11];% pcxH
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
info1PcxH = zeros(1,c);
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                info1PcxH(c) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end



%%
odorsRearranged = [14 2 15 4 10 11 8];% coaH
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
info1CoaH = zeros(1,c);
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                info1CoaH(c) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end


%%
odorsRearranged = [1 2 5 10 15 7 8];% pcxL
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
info1PcxL = zeros(1,c);
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                info1PcxL(c) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end




%%
odorsRearranged = [6 1 3 13 12 7 5];% coaL
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
info1CoaL = zeros(1,c);
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                info1CoaL(c) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end


