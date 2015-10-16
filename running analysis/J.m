%% pca-score responses in a cycle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                    responseProfiles(idxResponse:idxResponse+4,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth(:,4*cycleLengthDeg:5*cycleLengthDeg);
                    idxResponse =idxResponse + 5;
                end
            end
        end
    end
end
    responseProfiles1 = [];
for i = 1:size(responseProfiles,1)
    responseProfiles1(i,:) = responseProfiles(i,:);%smooth(responseProfiles(i,:), 0.005, 'rloess');
end
[coeff, score, latent,~,explained] = pca(zscore(responseProfiles1));

%% plot

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
for i = 1:2
    plot(coeff(:,i), 'linewidth', 2)
end
axis tight
xlabel('phase in deg')
ylabel('Firing rate (Hz)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
p(1,2).title('The first 3 PCs during the first sniff')

c = [102,194,165;252,141,98;141,160,203];


p(2,1).select()
k = 1;
hold on
for i = 1:6:size(score,1)-5
    scatter(score(i:i+4,2),score(i:i+4,4), [],c(k,:)/255,  'filled') %c(k,:)/255,
    k = k+1;
    if k == 4
        k = 1;
    end
end
axis tight
xlabel('PC 2 score')
ylabel('PC 4 score')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
p(2,1).title('Scores of all responses on the first 2 PCs (grouped by odor/cell pair)')


p(2,2).select()
hold on
idx= score(:,1);
appRespProf = responseProfiles1(idx>20,:);
% for i = 1:size(appRespProf,1)
plot(mean(appRespProf),  'linewidth', 2)
% end
idx= score(:,2);
appRespProf = responseProfiles1(idx>20,:);
%for i = 1:size(appRespProf,1)
plot(mean(appRespProf),  'linewidth', 2)
%end
idx= score(:,2);
appRespProf = responseProfiles1(idx<-20,:);
plot(mean(appRespProf), 'linewidth', 2)

axis tight
xlabel('phase in deg')
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