%% plot responses timecourses for concentration series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idxNeuronE = 1;
idxNeuronI = 1;
excRespUnitLog = [];
inhRespUnitLog = [];
granMatrixExc = [];
granMatrixInh = [];

        for idxUnit = 1:size(unitOdorResponseLog{1},1)
            excitation = [];
            inhibition = [];
            aurocs = [];
            inhResp = [];
            for idxConc = listOdorConc
                excitation = [excitation unitOdorResponseLog{idxConc}(idxUnit, 6)];
                aurocs = [aurocs unitOdorResponseLog{idxConc}(idxUnit, 4)];
                inhibition = [inhibition unitOdorResponseLog{idxConc}(idxUnit, 7)];
                inhResp = [inhResp unitOdorResponseLog{idxOdor}(idxConc, 5)];
            end
            if sum(excitation) > 0
                granMatrixExc = [granMatrixExc; aurocs];
                excRespUnitLog{idxOdor}(idxNeuronE,:) = unitOdorResponseLog{idxOdor}(idxUnit,1:3);
                idxNeuronE = idxNeuronE + 1;
            end
            if sum(inhibition) > 0
                granMatrixInh = [granMatrixInh; inhResp];
                inhRespUnitLog{idxOdor}(idxNeuronI,:) = unitOdorResponseLog{idxOdor}(idxUnit,1:3);
                idxNeuronI = idxNeuronI + 1;
            end
        end



Xfig = 900;
Yfig = 800;
figure;
% p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')


somma = sum(granMatrixExc,2);
granMatrixExc = [granMatrixExc somma];
granMatrixExc = sortrows(granMatrixExc,size(granMatrixExc,2));
granMatrixExc(:,end) = [];
granMatrixExc = flipud(sortrows(granMatrixExc,1));

% p(1).select()
imagesc(granMatrixExc,[0.5, 1]),colormap(brewermap([],'*PuOr')); axis tight; colorbar;
set(findobj(gcf, 'type','axes'), 'Visible','off')
stringa = sprintf('AuRoc of units to %s (series of increasing dilutions)', listOdors{idxOdor});
suptitle(stringa);

% p(2).select()
% imagesc(granMatrixInh); colormap(brewermap([],'*PuOr')); axis tight %colorbar
% set(findobj(gcf, 'type','axes'), 'Visible','off')

% p.de.margin = 2;
% p.margin = [8 15 4 10];
% p(1).marginright = 20;
% 
% p.select('all');