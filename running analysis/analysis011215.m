odors = 8;
n_trials = 10;
c = 0;
L= [];
for idxExp =  1:length(esp)
    lss = [];
    u = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            for idxOdor = 1:odors
                u = u + 1;
                lss(u) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
            end
        end
    end
    L = [L lss];
    figure;
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    h1 = cdfplot(coa.auROCTot1s);
    set(h1, 'linewidth', 2, 'color', 'k')
    hold on
    h2 = cdfplot(coaAA.auROCTot1s);
    set(h2, 'linewidth', 2, 'color', 'g') 
    hold on
    h3 = cdfplot(lss);
    set(h3, 'linewidth', 2, 'color', 'b') 
        hold on
    h4 = cdfplot(L);
    set(h4, 'linewidth', 2, 'color', 'r') 
end