[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaCS.esp);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxCS.esp);

%%
fractionPerConcentrationCoa = [];
for idxOdor = 1:3
    for idxShank = 1:4
        app = squeeze(responsivityCoa{idxShank}(:,:,idxOdor));
        for idxExp = 1:size(nCellsExpCoa,1)
            app1 = app(1:nCellsExpCoa(idxExp,idxShank),:);
            app(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            fractionPerConcentrationCoa(idxShank,:,idxOdor, idxExp) = sum(app1)./size(app1,1);
        end
    end
end

fractionPerConcentrationPcx = [];
for idxOdor = 1:3
    for idxShank = 1:4
        app = squeeze(responsivityPcx{idxShank}(:,:,idxOdor));
        for idxExp = 1:size(nCellsExpPcx,1)
            app1 = app(1:nCellsExpPcx(idxExp,idxShank),:);
            app(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            fractionPerConcentrationPcx(idxShank,:,idxOdor, idxExp) = sum(app1)./size(app1,1);
        end
    end
end
 %%   
 figure
 set(gcf,'Position',[207 90 395 642]);

 for idxConc = 1:5
     subplot(5,1,idxConc)
     for idxOdor = 1:3
         app = (squeeze(fractionPerConcentrationCoa(:,idxConc,idxOdor,:)))';
         app(isnan(app)) = 0;
         plot(mean(app))
         hold on
     end
     ylim([0 0.25])
 end
 %%   
 figure
 set(gcf,'Position',[207 90 395 642]);

 for idxConc = 1:5
     subplot(5,1,idxConc)
     for idxOdor = 1:3
         app = (squeeze(fractionPerConcentrationPcx(:,idxConc,idxOdor,:)))';
         app(isnan(app)) = 0;
         plot(mean(app))
         hold on
     end
     ylim([0 0.25])
 end
 
 
 %%
 for idxShank = 1:4
     for idxConc = 1:5
         app1 = squeeze(responsivityCoa{idxShank}(:,idxConc,:));
         app2 = squeeze(auROCCoa{idxShank}(:,idxConc,:));
         app3 = [];
         for idxCell = 1:size(app1,1)
             if sum(app1(idxCell,:)) > 0
                 app3 = [app3; app2(idxCell,:)];
             end
         end
         meanAuRocCoa(idxConc,:,idxShank) = mean(app3);
         semAuRocCoa(idxConc,:,idxShank) = std(app3)/sqrt(size(app3,1)-1);
     end
 end
 
 figure
 set(gcf,'Position',[207 90 395 642]);

  for idxConc = 1:5
     subplot(5,1,idxConc)
     for idxOdor = 1:3
         plot(squeeze(meanAuRocCoa(idxConc,idxOdor,:)))
         hold on
     end
     ylim([0.5 1])
  end
 
   %%
 for idxShank = 1:4
     for idxConc = 1:5
         app1 = squeeze(responsivityPcx{idxShank}(:,idxConc,:));
         app2 = squeeze(auROCPcx{idxShank}(:,idxConc,:));
         app3 = [];
         for idxCell = 1:size(app1,1)
             if sum(app1(idxCell,:)) > 0
                 app3 = [app3; app2(idxCell,:)];
             end
         end
         meanAuRocPcx(idxConc,:,idxShank) = mean(app3);
         semAuRocPcx(idxConc,:,idxShank) = std(app3)/sqrt(size(app3,1)-1);
     end
 end
 
 figure
 set(gcf,'Position',[207 90 395 642]);

  for idxConc = 1:5
     subplot(5,1,idxConc)
     for idxOdor = 1:3
         plot(squeeze(meanAuRocPcx(idxConc,idxOdor,:)))
         hold on
     end
     ylim([0.5 1])
 end
         