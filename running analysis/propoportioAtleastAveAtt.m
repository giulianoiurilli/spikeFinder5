listOdors = [1 2 3 4; 6 7 8 9];
    
for idxExp = 1: length(exp) %- 1
    %initialize:
    idxCell4 = 0;
    idxCell300 = 0;
    idxCell1000 = 0;
    cells = 0;
    %count total number of cells across shanks per experiment:
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
        end
    end
    excP300ms = zeros(cells,2,4);
    excP1000ms = zeros(cells,2,4);
    inhP300ms = zeros(cells,2,4);
    excP4Cycles = zeros(cells,2,4);
    inhP4Cycles = zeros(cells,2,4);
    excP4CyclesResp = zeros(cells,2,4);
    excP300msResp = zeros(cells,2,4);
    auROC1s = zeros(cells,2,4);
    
 
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            idxCell4 = idxCell4 + 1;
            idxCell300 = idxCell300 + 1;
            idxCell1000 = idxCell1000 + 1;
            
            
            for idxValence = 1:2
                odorsToUse = listOdors(idxValence,:);
                
                idxO = 0;
                for idxOdor = odorsToUse
                    idxO = idxO + 1;
                    if (exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1) && (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                        excP4Cycles(idxCell4, idxValence, idxO) = 1;
                        excP4CyclesResp(idxCell4, idxValence, idxO) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) -...
                            mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                    else
                        excP4Cycles(idxCell4, idxValence, idxO) = 0;
                        excP4CyclesResp(idxCell4, idxValence, idxO) = 0;
                    end
                    if (exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1) && (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                        inhP4Cycles(idxCell4, idxValence, idxO) = 1;
                    else
                        inhP4Cycles(idxCell4, idxValence, idxO) = 0;
                    end
                    if (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1) && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        excP300ms(idxCell300, idxValence, idxO) = 1;
                        excP300msResp(idxCell4, idxValence, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) -...
                            mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    else
                        excP300ms(idxCell300, idxValence, idxO) = 0;
                        excP300msResp(idxCell4, idxValence, idxO) = 0;
                    end
                    if (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1) && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        inhP300ms(idxCell300, idxValence, idxO) = 1;
                    else
                        inhP300ms(idxCell300, idxValence, idxO) = 0;
                    end
                    if (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1) && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        excP1000ms(idxCell1000, idxValence, idxO) = 1;
                        excP1000msResp(idxCell4, idxValence, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) -...
                            mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    else
                        excP1000ms(idxCell1000, idxValence, idxO) = 0;
                        excP1000msResp(idxCell4, idxValence, idxO) = 0;
                    end
                end
            end
        end
    end
    atLeastOneE4_temp = mean(excP4Cycles,3);
    atLeastOneI4_temp = mean(inhP4Cycles,3);
    atLeastOneE300_temp = mean(excP300ms,3);
    atLeastOneI300_temp = mean(inhP300ms,3);
    atLeastOneE1000_temp = mean(excP1000ms,3);
    P4Resp = squeeze(sum(excP4CyclesResp, 3));
    P300Resp = squeeze(sum(excP300msResp,3));
    P1000Resp = squeeze(sum(excP1000msResp,3));
    
    atLeastOneE4 = atLeastOneE4_temp > 0;
    pRespondingCells(idxExp).atLeastOneE4 = mean(atLeastOneE4, 1)*100;
    pRespondingCells(idxExp).atLeastOneE4Resp = P4Resp;
    
    atLeastOneE1000 = atLeastOneE1000_temp > 0;
    pRespondingCells(idxExp).atLeastOneE1000 = mean(atLeastOneE1000, 1)*100;
    pRespondingCells(idxExp).atLeastOneE1000Resp = P1000Resp;
    
    atLeastOneI4 = atLeastOneI4_temp > 0;
    pRespondingCells(idxExp).atLeastOneI4 = mean(atLeastOneI4)*100;
    
    atLeastOneE300 = atLeastOneE300_temp > 0;
    pRespondingCells(idxExp).atLeastOneE300 = mean(atLeastOneE300)*100;
    pRespondingCells(idxExp).atLeastOneE300Resp = P300Resp;
    
    atLeastOneI300 = atLeastOneI300_temp > 0;
    pRespondingCells(idxExp).atLeastOneI300 = mean(atLeastOneI300)*100;
end

respondingCellsPplcoa = pRespondingCells;
save('respCellsPplcoaAveAtt.mat', 'respondingCellsPplcoa');

%%
x = cat(1,respondingCellsPapcx.atLeastOneE1000Resp);
xzeros = sum(x,2);
x(xzeros==0,:) = [];
dataX = x(:,1);
dataY = x(:,2);
% jitterAmount = 0.5;
% jitterValuesX = 2*(rand(size(dataX))-0.5)*jitterAmount;   % +/-jitterAmount max
% jitterValuesY = 2*(rand(size(dataY))-0.5)*jitterAmount;   % +/-jitterAmount max
% scatter(dataX+jitterValuesX, dataY+jitterValuesY);
%figure;
hold on
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
scatter(x(:,1),x(:,2), 50, 'k', 'filled')

axis square
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

 
 
 


