listOdors = [12 2 7; 13 3 8; 14 4 9; 15 5 10; 1 6 11];
    
for idxExp = 1: length(exp) %- 1
    %initialize:
    idxCell4 = 0;
    idxCell300 = 0;
    cells = 0;
    %count total number of cells across shanks per experiment:
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
        end
    end
    excP300ms = zeros(cells,5,3);
    inhP300ms = zeros(cells,5,3);
    excP4Cycles = zeros(cells,5,3);
    inhP4Cycles = zeros(cells,5,3);
    
 
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            idxCell4 = idxCell4 + 1;
            idxCell300 = idxCell300 + 1;
            
            
            for idxConc = 1:5
                odorsToUse = listOdors(idxConc,:);
                
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
    atLeastOneE4_temp = mean(excP4Cycles,3);
    atLeastOneI4_temp = mean(inhP4Cycles,3);
    atLeastOneE300_temp = mean(excP300ms,3);
    atLeastOneI300_temp = mean(inhP300ms,3);
    
    atLeastOneE4 = atLeastOneE4_temp > 0;
    pRespondingCells(idxExp).atLeastOneE4 = mean(atLeastOneE4, 1)*100;
    atLeastOneI4 = atLeastOneI4_temp > 0;
    pRespondingCells(idxExp).atLeastOneI4 = mean(atLeastOneI4)*100;
    atLeastOneE300 = atLeastOneE300_temp > 0;
    pRespondingCells(idxExp).atLeastOneE300 = mean(atLeastOneE300)*100;
    atLeastOneI300 = atLeastOneI300_temp > 0;
    pRespondingCells(idxExp).atLeastOneI300 = mean(atLeastOneI300)*100;
end
 
 
 
%%
xConc = 1:5;
 
figure;
subplot(2,2,1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
Exp_E4 = cat(1,pRespondingCells.atLeastOneE4);
errorbar(xConc, mean(Exp_E4,1), std(Exp_E4)/sqrt(size(Exp_E4,1)), '-r')
title({'Exc 4 cycles';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 25])
ylabel('mean (SEM)')
xlabel('concentrations')


subplot(2,2,2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
Exp_I4 = cat(1,pRespondingCells.atLeastOneI4);
errorbar(xConc, mean(Exp_I4,1), std(Exp_I4)/sqrt(size(Exp_I4,1)), '-r')
title({'Inh 4 cycles';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 25])
ylabel('mean (SEM)')
xlabel('concentrations')


subplot(2,2,3)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
Exp_E300 = cat(1,pRespondingCells.atLeastOneE300);
errorbar(xConc, mean(Exp_E300,1), std(Exp_E300)/sqrt(size(Exp_E300,1)), '-r')
title({'Exc 300 ms';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 25]) 
ylabel('mean (SEM)')
xlabel('concentrations')

 
subplot(2,2,4)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
Exp_I300 = cat(1,pRespondingCells.atLeastOneI300);
errorbar(xConc, mean(Exp_I300,1), std(Exp_I300)/sqrt(size(Exp_I300,1)), '-r')
title({'Inh 300 ms';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 25])
ylabel('mean (SEM)')
xlabel('concentrations')

