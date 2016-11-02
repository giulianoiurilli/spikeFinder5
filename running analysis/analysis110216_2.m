esp = pcxCS.esp;

deltaR = [];
idxCellResp = zeros(length(esp),1);
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    for idxOdor = 1:15
                        app(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        if app(idxOdor) == 1
                            if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms > 0
                                deltaR = [deltaR (mean((esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)...
                                    - mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)) ./...
                                    mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)) * 100];
                            else
                                deltaR = [deltaR 100];
                            end
                        end
                    end
                    if sum(app)>0
                        idxCellResp(idxExp) =  idxCellResp(idxExp) + 1;
                    end
                end
            end
        end
    end
end

figure, bar(idxCellResp)
figure; histogram(deltaR,100)