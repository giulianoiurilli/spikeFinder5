function [sigAnova] = concSeriesAnalysis2_new(esp, odors)

%esp = pcxCS.esp;
odorsRearranged = odors;
odors = length(odorsRearranged);

c = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    c = c + 1;
                end
            end
        end
    end
end

sigAnova = nan(c,1);
c = 0;
sigOdorID = [];
sigOdorConc = [];
for idxExp =  1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    c = c + 1;
                    idxO = 0;
                    A = [];
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                        A = [A; app'];
                    end
                    A = reshape(A, 10*5, 3);
                    p = anova2(A, 10, 'off');
                    sigOdorID = p(1);
                    sigOdorConc = p(2);
                    if p(1) > 0.05 && p(2) > 0.05
                        sigAnova(c) = 0;
                    end
                    if p(1) < 0.05 && p(2) > 0.05
                        sigAnova(c) = 1;
                    end
                    if p(1) > 0.05 && p(2) < 0.05
                        sigAnova(c) = 2;
                    end
                    if p(1) < 0.05 && p(2) < 0.05
                        sigAnova(c) = 3;
                    end
                end
            end
        end
    end
end

