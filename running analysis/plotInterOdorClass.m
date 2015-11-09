xConc = 1:5;

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

hold on
errorbar(xConc, A4apcx(1,:), A4apcx(1,:) - A4apcx(2,:), A4apcx(3,:) - A4apcx(1,:), 'color', [26, 152, 80]/255);
errorbar(xConc, A4Sapcx(1,:), A4Sapcx(1,:) - A4Sapcx(2,:), A4Sapcx(3,:) - A4Sapcx(1,:), 'color', [217, 239, 139]/255);
errorbar(xConc, A4plcoa(1,:), A4plcoa(1,:) - A4plcoa(2,:), A4plcoa(3,:) - A4plcoa(1,:), 'color', [215, 48, 39]/255);
errorbar(xConc, A4Splcoa(1,:), A4Splcoa(1,:) - A4Splcoa(2,:), A4Splcoa(3,:) - A4Splcoa(1,:), 'color', [254, 224, 139]/255);
xlabel('increasing concentrations')
ylabel('average accuracy')
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('inter-odor classification - 4 cycles')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

hold on
errorbar(xConc, A300apcx(1,:), A300apcx(1,:) - A300apcx(2,:), A300apcx(3,:) - A300apcx(1,:), 'color', [26, 152, 80]/255);
errorbar(xConc, A300Sapcx(1,:), A300Sapcx(1,:) - A300Sapcx(2,:), A300Sapcx(3,:) - A300Sapcx(1,:), 'color', [217, 239, 139]/255);
errorbar(xConc, A300plcoa(1,:), A300plcoa(1,:) - A300plcoa(2,:), A300plcoa(3,:) - A300plcoa(1,:), 'color', [215, 48, 39]/255);
errorbar(xConc, A300Splcoa(1,:), A300Splcoa(1,:) - A300Splcoa(2,:), A300Splcoa(3,:) - A300Splcoa(1,:), 'color', [254, 224, 139]/255);
xlabel('increasing concentrations')
ylabel('average accuracy')
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('inter-odor classification - 300 ms')