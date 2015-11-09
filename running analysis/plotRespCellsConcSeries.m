%%
xConc = 1:5;
 
figure;
subplot(2,2,1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

hold on
Exp_E4aPCx = cat(1,respondingCellsPaPCx.atLeastOneE4);
errorbar(xConc, mean(Exp_E4aPCx,1), std(Exp_E4aPCx)/sqrt(size(Exp_E4aPCx,1)), 'color', [26, 152, 80]/255)
Exp_E4plCOA = cat(1,respondingCellsPplCOA .atLeastOneE4);
errorbar(xConc, mean(Exp_E4plCOA,1), std(Exp_E4plCOA)/sqrt(size(Exp_E4plCOA,1)), 'color', [215, 48, 39]/255)

title({'Exc 4 cycles';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 35])
ylabel('mean (SEM)')
xlabel('increasing concentrations')


subplot(2,2,2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

hold on
Exp_I4aPCx = cat(1,respondingCellsPaPCx.atLeastOneI4);
errorbar(xConc, mean(Exp_I4aPCx,1), std(Exp_I4aPCx)/sqrt(size(Exp_I4aPCx,1)), 'color', [26, 152, 80]/255)
Exp_I4plCOA = cat(1,respondingCellsPplCOA .atLeastOneI4);
errorbar(xConc, mean(Exp_I4plCOA,1), std(Exp_I4plCOA)/sqrt(size(Exp_I4plCOA,1)), 'color', [215, 48, 39]/255)

title({'Inh 4 cycles';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 35])
ylabel('mean (SEM)')
xlabel('increasing concentrations')


subplot(2,2,3)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

hold on
Exp_E300aPCx = cat(1,respondingCellsPaPCx.atLeastOneE300);
errorbar(xConc, mean(Exp_E300aPCx,1), std(Exp_E300aPCx)/sqrt(size(Exp_E300aPCx,1)), 'color', [26, 152, 80]/255)
Exp_E300plCOA = cat(1,respondingCellsPplCOA .atLeastOneE300);
errorbar(xConc, mean(Exp_E300plCOA,1), std(Exp_E300plCOA)/sqrt(size(Exp_E300plCOA,1)), 'color', [215, 48, 39]/255)

title({'Exc 300 ms';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 35]) 
ylabel('mean (SEM)')
xlabel('increasing concentrations')

 
subplot(2,2,4)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

hold on
Exp_I300aPCx = cat(1,respondingCellsPaPCx.atLeastOneI300);
errorbar(xConc, mean(Exp_I300aPCx,1), std(Exp_I300aPCx)/sqrt(size(Exp_I300aPCx,1)), 'color', [26, 152, 80]/255)
Exp_I300plCOA = cat(1,respondingCellsPplCOA .atLeastOneI300);
errorbar(xConc, mean(Exp_I300plCOA,1), std(Exp_I300plCOA)/sqrt(size(Exp_I300plCOA,1)), 'color', [215, 48, 39]/255)

title({'Inh 300 ms';'percentage of responding cells  for each experiment'})
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
ylim([0, 35])
ylabel('mean (SEM)')
xlabel('increasing concentrations')