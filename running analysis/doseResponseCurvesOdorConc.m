%%
cells = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
        end
    end
end

%%
excP300ms = zeros(cells,5,3);
inhP300ms = zeros(cells,5,3);
excP4Cycles = zeros(cells,5,3);
inhP4Cycles = zeros(cells,5,3);

listOdors = [12 2 7; 13 3 8; 14 4 9; 15 5 10; 1 6 11];
for idxConc = 1:5
    odorsToUse = listOdors(idxConc,:);
    idxCell4 = 0;
    idxCell300 = 0;
    for idxExp = 1: length(exp) %- 1
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
                idxCell4 = idxCell4 + 1;
                idxCell300 = idxCell300 + 1;
                
                idxO = 0;
                for idxOdor = odorsToUse
                    idxO = idxO + 1;
                    if (exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1) && (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                        excP4Cycles(idxCell4, idxConc, idxO) = 1;
                    else
                        excP4Cycles(idxCell4, idxConc, idxO) = 0;
                    end
                    if (exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1) && (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                        inhP4Cycles(idxCell4, idxConc, idxO) = 1;
                    else
                        inhP4Cycles(idxCell4, idxConc, idxO) = 0;
                    end
                    if (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1) && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        excP300ms(idxCell300, idxConc, idxO) = 1;
                    else
                        excP300ms(idxCell300, idxConc, idxO) = 0;
                    end
                    if (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1) && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        inhP300ms(idxCell300, idxConc, idxO) = 1;
                    else
                        inhP300ms(idxCell300, idxConc, idxO) = 0;
                    end
                end
            end
        end
    end
end

%%
n_rep = 1000;
E4All = zeros(n_rep,5);
I4All = zeros(n_rep,5);
E300All = zeros(n_rep,5);
I300All = zeros(n_rep,5);
for idxRep = 1:n_rep
    idx = randperm(size(excP4Cycles,1));
    idx = idx(1:ceil(0.7 .* size(excP4Cycles,1)));
    E4 = excP4Cycles(idx,:,:);
    I4 = inhP4Cycles(idx,:,:);
    E300 = excP300ms(idx,:,:);
    I300 = inhP300ms(idx,:,:);
    atLeastOneE4_temp = squeeze(sum(E4,3)./3);
    atLeastOneI4_temp = squeeze(sum(I4,3)./3);
    atLeastOneE300_temp = squeeze(sum(E300,3)./3);
    atLeastOneI300_temp = squeeze(sum(I300,3)./3);
    
    atLeastOneE4 = atLeastOneE4_temp > 0;
    atLeastOneE4 = mean(atLeastOneE4, 1)*100;
    atLeastOneI4 = atLeastOneI4_temp > 0;
    atLeastOneI4 = mean(atLeastOneI4)*100;
    atLeastOneE300 = atLeastOneE300_temp > 0;
    atLeastOneE300 = mean(atLeastOneE300)*100;
    atLeastOneI300 = atLeastOneI300_temp > 0;
    atLeastOneI300 = mean(atLeastOneI300)*100;
    
    
    E4All(idxRep,:) = atLeastOneE4;
    I4All(idxRep,:) = atLeastOneI4;
    E300All(idxRep,:) = atLeastOneE300;
    I300All(idxRep,:) = atLeastOneI300;
end

%%
xConc = 1:5;
E4Allprct75 = prctile(E4All,75);
I4Allprct75 = prctile(I4All,75);
E300Allprct75 = prctile(E300All,75);
I300Allprct75 = prctile(I300All,75);
E4Allprct25 = prctile(E4All,25);
I4Allprct25 = prctile(I4All,25);
E300Allprct25 = prctile(E300All,25);
I300Allprct25 = prctile(I300All,25);
E4Allmean = mean(E4All);
I4Allmean = mean(I4All);
E300Allmean = mean(E300All);
I300Allmean = mean(I300All);

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
errorbar(xConc, E4Allmean, E4Allmean - E4Allprct25, E4Allprct75 - E4Allmean, 'r-');
axis tight
%set(gca, 'ylim', [0 0.20])
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('Exc 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
errorbar(xConc, I4Allmean, I4Allmean - I4Allprct25, I4Allprct75 - I4Allmean, 'r-');
axis tight
%set(gca, 'ylim', [0 0.20])
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('Inh 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
errorbar(xConc, E300Allmean, E300Allmean - E300Allprct25, E300Allprct75 - E300Allmean, 'r-');
axis tight
%set(gca, 'ylim', [0 0.20])
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('Exc 300 ms')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
errorbar(xConc, I300Allmean, I300Allmean - I300Allprct25, I300Allprct75 - I300Allmean, 'r-');
axis tight
%set(gca, 'ylim', [0 0.20])
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('Inh 300 ms')





         


