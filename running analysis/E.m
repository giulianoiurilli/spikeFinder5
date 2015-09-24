% plot responses and demixed responses of odor A vs odor B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


odorA = [15 15];
odorB = [1 8];
figure
Xfig = 900;
Yfig = 500;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
p.pack({1/2 1/2},{25 25 25 25});

for idxShank = 1:4
    k = 1;
    odorY = [];
    rosa_demixed = [];
    odorX = [];
    odorX_demixed = [];
    for idxExp = 1:length(List)
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
%                         rosa(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(15).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%                         rosa_demixed(k) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(15).odorDriveAllCycles;
            app1 = []; app2 = [];
            app1 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).fullCycleAnalogicResponsePerCycle);
            app2 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).fullCycleAnalogicResponsePerCycle);
            if app1 >= app2
                odorX(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).fullCycleAnalogicResponsePerCycle)-...
                    exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
            else
                odorX(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).fullCycleAnalogicResponsePerCycle) -...
                    exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
            end
            app1 = []; app2 = [];
            if app1 >= app2
                odorX_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).odorDriveAllCycles);
            else
                odorX_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).odorDriveAllCycles);
            end
            
            
            app1 = []; app2 = [];
            app1 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).fullCycleAnalogicResponsePerCycle);
            app2 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).fullCycleAnalogicResponsePerCycle);
            if app1 >= app2
                odorY(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
            else
                odorY(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
            end
            app1 = []; app2 = [];
            if app1 >= app2
                rosa_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).odorDriveAllCycles);
            else
                rosa_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).odorDriveAllCycles);
            end
            k = k + 1;
        end
    end
    
    together = []; app = [];
    app = odorY + odorX;
    odorY(app==0) = []; odorX(app==0) = [];
    odorY(isnan(app)) = []; odorX(isnan(app)) = [];
    [maxvalue, idxmax] = max(odorX);
    odorY(idxmax) = []; odorX(idxmax) = [];
    together = [odorY; odorX];
    maxTogether = max(together);
    %together = together ./ repmat(maxTogether,2,1);
    together = together';
    p(1,idxShank).select()
    scatter(together(:,1), together(:,2), 7,'filled');
% %     m = sum(together(:,1) .* together(:,2))/sum(together(:,1).^2);
% %     y = m*together(:,1);
% %     hold on
% %     plot(together(:,1), y, 'r')
% %     A = together(:,1)\together(:,2);
% %     hold on;plot(together(:,1), A*together(:,1),'g');
    maxAx = max(together(:));
    minAx = abs(min(together(:)));
    limit = max([minAx maxAx]);
    xlim([-limit limit]); ylim([-limit limit]);
    line([0 0], [-limit limit], 'Color', 'k')
    line([-limit limit], [0 0], 'Color', 'k')
    axis square
    axis off

    
    
    together = []; app = [];
    app = rosa_demixed + odorX_demixed;
    rosa_demixed(app==0) = []; odorX_demixed(app==0) = [];
    rosa_demixed(isnan(app)) = []; odorX_demixed(isnan(app)) = [];
    [maxvalue, idxmax] = max(odorX_demixed);
    rosa_demixed(idxmax) = []; odorX_demixed(idxmax) = [];
    together = [rosa_demixed; odorX_demixed];
    maxTogether = max(together);
    %together = together ./ repmat(maxTogether,2,1);
    together = together';
    p(2,idxShank).select()
    scatter(together(:,1), together(:,2), 7,'filled');
%     m = sum(together(:,1) .* together(:,2))/sum(together(:,1).^2);
%     y = m*together(:,1);
%     hold on
%     plot(together(:,1), y, 'r')
%     A = together(:,1)\together(:,2);
%     hold on;plot(together(:,1), A*together(:,1),'g');
    maxAx = max(together(:));
    minAx = abs(min(together(:)));
    limit = max([minAx maxAx]);
    xlim([-limit limit]); ylim([-limit limit]);
    line([0 0], [-limit limit], 'Color', 'k')
    line([-limit limit], [0 0], 'Color', 'k')
    axis square
    axis off
    %set(gca,'XTick',[])
end

p.margin = [15 15 4 6];
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');