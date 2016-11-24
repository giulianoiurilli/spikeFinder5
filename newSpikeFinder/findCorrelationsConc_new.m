function [A, a, b, c, d, e, f1, f2, f3, g1, g2, g3, h1, h2, h3, i1, i2, i3, l1, l2, l3] = findCorrelationsConc_new(esp, odors)

% esp = pcxCS.esp;
% odors = 1:15;

odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell = idxCell + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            responseCell1Mean(idxCell, idxO) = mean(app);
                        end
                    end
                end
            end
        end
    end
end

responseCell1Mean = responseCell1Mean';
responseCell1Mean = zscore(responseCell1Mean);
responseCell1Mean = responseCell1Mean';


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-1 1];
A = corr(responseCell1Mean);
imagesc(A, clims)
axis square
colormap(brewermap([],'*RdBu'));


a = nan(3,4);

a(1,1) = corr(responseCell1Mean(:,1), responseCell1Mean(:,2));
a(1,2) = corr(responseCell1Mean(:,2), responseCell1Mean(:,3));
a(1,3) = corr(responseCell1Mean(:,3), responseCell1Mean(:,4));
a(1,4) = corr(responseCell1Mean(:,4), responseCell1Mean(:,5));

a(2,1) = corr(responseCell1Mean(:,6), responseCell1Mean(:,7));
a(2,2) = corr(responseCell1Mean(:,7), responseCell1Mean(:,8));
a(2,3) = corr(responseCell1Mean(:,8), responseCell1Mean(:,9));
a(2,4) = corr(responseCell1Mean(:,9), responseCell1Mean(:,10));

a(3,1) = corr(responseCell1Mean(:,11), responseCell1Mean(:,12));
a(3,2) = corr(responseCell1Mean(:,12), responseCell1Mean(:,13));
a(3,3) = corr(responseCell1Mean(:,13), responseCell1Mean(:,14));
a(3,4) = corr(responseCell1Mean(:,14), responseCell1Mean(:,15));

b = nan(5,5,3);

b(:,:,1) = corr(responseCell1Mean(:,1:5));
b(:,:,2) = corr(responseCell1Mean(:,6:10));
b(:,:,3) = corr(responseCell1Mean(:,11:15));


c = [];
c = corr(responseCell1Mean(:,1:5), responseCell1Mean(:,6:10));
d = [];
d = corr(responseCell1Mean(:,1:5), responseCell1Mean(:,11:15));
e = [];
e = corr(responseCell1Mean(:,6:10), responseCell1Mean(:,11:15));

f1 = corr(responseCell1Mean(:,1), responseCell1Mean(:,6));
f2 = corr(responseCell1Mean(:,1), responseCell1Mean(:,11));
f3 = corr(responseCell1Mean(:,11), responseCell1Mean(:,6));
g1 = corr(responseCell1Mean(:,2), responseCell1Mean(:,7));
g2 = corr(responseCell1Mean(:,2), responseCell1Mean(:,12));
g3 = corr(responseCell1Mean(:,12), responseCell1Mean(:,7));
h1 = corr(responseCell1Mean(:,3), responseCell1Mean(:,8));
h2 = corr(responseCell1Mean(:,3), responseCell1Mean(:,13));
h3 = corr(responseCell1Mean(:,13), responseCell1Mean(:,8));
i1 = corr(responseCell1Mean(:,4), responseCell1Mean(:,9));
i2 = corr(responseCell1Mean(:,4), responseCell1Mean(:,14));
i3 = corr(responseCell1Mean(:,14), responseCell1Mean(:,9));
l1 = corr(responseCell1Mean(:,5), responseCell1Mean(:,10));
l2 = corr(responseCell1Mean(:,5), responseCell1Mean(:,15));
l3 = corr(responseCell1Mean(:,15), responseCell1Mean(:,10));









