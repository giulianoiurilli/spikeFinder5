%% PCA scoring of un-warped responses

idxResponse = 1;
responseProfiles = [];
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
            for idxOdor = 1:odors
                app1 = [];
                app1 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax > 0.75);
                app2 = [];
                app2 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) > 0);
                app3 = [];
                app3 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) > 0);
                app4 = [];
                app4 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax < 0.4);
                if ~isempty(app1) && ~isempty(app2) || ~isempty(app1) && ~isempty(app3) 
                    responseProfiles(idxResponse:idxResponse+4,:) =  exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:,14000:14500);
                    app = [idxExp idxShank idxUnit idxOdor]; app = repmat(app,5,1);
                    cellLog(idxResponse:idxResponse+4,:) = app;
                    idxResponse =idxResponse + 5;
                end
            end
        end
    end
end
responseProfiles1 = [];

    responseProfiles1 = responseProfiles;

[coeff, score, latent,~,explained] = pca(responseProfiles1);



Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

p.pack({1/2 1/2}, {50 50})

p(1,1).select()
plot(explained(1:10), 'k', 'linewidth', 2)
axis tight
xlabel('PC')
ylabel('Variance explained %')
p(1,1).title('Scree plot')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(1,2).select()
hold on
for i = 1:3
    plot(coeff(:,i), 'linewidth', 2)
end
axis tight
xlabel('ms')
ylabel('Firing rate (Hz)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
p(1,2).title('The first 3 PCs during the first sniff')

c = [166,206,227;...
31,120,180;...
178,223,138;...
51,160,44;...
251,154,153;...
227,26,28;...
253,191,111;...
255,127,0;...
202,178,214;...
106,61,154;...
255,255,153;...
177,89,40;...
188,128,189;...
204,235,197;...
255,237,111];


p(2,1).select()
k = 1;
hold on
for i = 1:6:size(score,1)-5
    scatter(score(i:i+4,2),score(i:i+4,3), [],c(k,:)/255,  'filled') %c(k,:)/255,
    k = k+1;
    if k == 15
        k =1;
    end
end
axis tight
xlabel('PC 2 score')
ylabel('PC 3 score')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
p(2,1).title('Scores of all responses on the first 2 PCs (grouped by odor/cell pair)')


p(2,2).select()
hold on
idx= score(:,3);
appRespProf = responseProfiles1(idx>0.1,:);
% for i = 1:size(appRespProf,1)
plot(mean(appRespProf)*100,  'linewidth', 2)
% end
idx= score(:,2);
appRespProf = responseProfiles1(idx>0.1,:);
%for i = 1:size(appRespProf,1)
plot(mean(appRespProf)*100,  'linewidth', 2)
%end
idx= score(:,2);
appRespProf = responseProfiles1(idx<-0.1,:);
plot(mean(appRespProf)*100, 'linewidth', 2)

axis tight
xlabel('ms')
ylabel('Firing rate (Hz)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
p(2,2).title('Example of responses with high scores in one of the first 3 PC')




p.de.margin = 2;
p.margin = [8 15 4 10];
p(1).marginbottom = 20;
p(1,1).marginright = 10;
p(2).marginbottom = 20;
p(2,1).marginright = 10;
p.select('all');