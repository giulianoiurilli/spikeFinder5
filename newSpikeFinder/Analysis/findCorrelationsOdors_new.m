function  odorCorrelations = findCorrelationsOdors_new(esp, odors)

% esp = pcxCS.esp;
% odors = 1:15;

odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell = idxCell + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            responseCell1Mean(idxCell, idxO) = mean(app);
                        end
                    end
                end
            end
        end
    end
end

responseCell1Mean = responseCell1Mean';
responseCell1Mean = zscore(responseCell1Mean);
responseCell1Mean = responseCell1Mean';


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-1 1];
A = corr(responseCell1Mean);
imagesc(A, clims)
axis square
colormap(brewermap([],'*RdYlBu'))
colorbar

odorCorrelations = 1 - pdist(responseCell1Mean', 'correlation');










