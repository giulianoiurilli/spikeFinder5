% produces a blank figure with everything turned off
% hf = blankFigure(axLim)
% where axLim = [left right bottom top]
function hf = blankFigure(axLim)
% axLen = 10;
% axLim = axLen * [-1 2 -0.7 2.3];

hf = figure; hold on; 
set(gca,'visible', 'off');
set(hf, 'color', [1 1 1]);
axis(axLim); axis square;