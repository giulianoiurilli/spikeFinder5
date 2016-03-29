figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[744 209 977 841]);
p = panel();
p.pack('h', {1/2 1/2});
p(1).pack('v', {1/4 1/4 1/4 1/4});
p(2).pack('v', {1/4 1/4 1/4 1/4});




for idxShank = 1:4
    c = 0;
    shankCoaTMT = [];
    shankCoaRose = [];
    for idxExp =  1:length(coaAA.esp)
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c+1;
                shankCoaTMT(c) =  coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).auROC1000ms;
                shankCoaRose(c) =  coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).auROC1000ms;
            end
        end
    end
    p(1,idxShank).select()
    plot(shankCoaTMT, shankCoaRose, 'o', 'markersize', 3, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    xlim([0 1])
    ylim([0 1])
    xlabel('TMT auROC')
    ylabel('Phenylethanol auROC')
    axis square
end

for idxShank = 1:4
    c = 0;
    shankPcxTMT = [];
    shankPcxRose = [];
    for idxExp =  1:length(pcxAA.esp)
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c+1;
                shankPcxTMT(c) =  pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).auROC1000ms;
                shankPcxRose(c) =  pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).auROC1000ms;
            end
        end
    end
    p(2,idxShank).select()
    plot(shankPcxTMT, shankPcxRose, 'o', 'markersize', 3, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    xlim([0 1])
    ylim([0 1])
    xlabel('TMT auROC')
    ylabel('Phenylethanol auROC')
    axis square
end

p.select('all');
p.de.margin = 2;

p(1,1).marginbottom = 30;
p(1,2).marginbottom = 30;
p(1,3).marginbottom = 30;
p(2,1).marginbottom = 30;
p(2,2).marginbottom = 30;
p(2,3).marginbottom = 30;

p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';