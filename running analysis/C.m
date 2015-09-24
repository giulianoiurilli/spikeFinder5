% population responses without breathing warping (only first sniff alignement)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

odorsRearranged = [1 8 2 9 3 10 4 11 5 12 6 13 7 14 15];

Xfig = 900;
Yfig = 800;
figure;
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = odorsRearranged
    idxNeuron = 1;
    responseProfiles{idxOdor} = [];
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
                responseProfiles{idxOdor}(idxNeuron,:) = mean(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp);
                idxNeuron = idxNeuron + 1;
            end
        end
    end
    subplot(8,2,idxPlot)
    A = responseProfiles{idxOdor};
    A = A(:,14000:16000);
    app1 = [];
    app1 = sum(A,2);
    A(app1==0,:) = [];
    A = mean(A);
    %A = smooth(A, 0.005, 'rloess');
    xAxis = 1:length(A);
    xticks = [1 1000 2000];
    xlab = {'-1', '0', '1'};
    area(A, 'FaceColor',[153,216,201]/255)
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabel', xlab);
    set(gca,'YColor','w')
    xlabel('sec')
    axis tight 
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot =idxPlot + 1;
end