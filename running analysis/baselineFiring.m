parameters
odors = 15;
%% count cells to initialize variables
unit = 0;
for idxExp = 1 : length(pcx1.espe)% - 1
    for idxShank = 1:4
        for idxUnit = 1:length(pcx1.espe(idxExp).shankNowarp(idxShank).cell)
            unit = unit + 1;
        end
    end
end

%% measure average firing rate over 14 seconds of baseline for all cells
cellBslLog = zeros(unit,4);
cell = 0;
for idxExp = 1 : length(pcx1.espe)% - 1
    for idxShank = 1:4
        for idxUnit = 1:length(pcx1.espe(idxExp).shankNowarp(idxShank).cell)
            cell = cell + 1;
            cellBslLog(cell,1) = idxExp;
            cellBslLog(cell,2) = idxShank;
            cellBslLog(cell,3) = idxUnit;
            B = 0;
            bsl = zeros(n_trials,odors);
            for idxOdor = 1:odors
                A = [];
                A = pcx1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                bsl(:,idxOdor) = sum(A(:,1:14000),2)./14;
                A = sum(A(:));
                B = B + A;
            end
            if B > 0    %remove cells with no spikes at all            
                cellBslLog(cell,4) = mean(bsl(:));
            else
                cellBslLog(cell,4) = NaN;
            end
        end
    end
end
            
%%
bslFR = cellBslLog(:,4);
bslFR(isnan(bslFR)) = [];
bslFRpcx = bslFR;
% figure; histfit(log10(bslFRpcx),100);
% median(bslFRpcx)

%% count cells to initialize variables
unit = 0;
for idxExp = 1 : length(coa1.espe)% - 1
    for idxShank = 1:4
        for idxUnit = 1:length(coa1.espe(idxExp).shankNowarp(idxShank).cell)
            unit = unit + 1;
        end
    end
end

%% measure average firing rate over 14 seconds of baseline for all cells
cellBslLog = zeros(unit,4);
cell = 0;
for idxExp = 1 : length(coa1.espe)% - 1
    for idxShank = 1:4
        for idxUnit = 1:length(coa1.espe(idxExp).shankNowarp(idxShank).cell)
            cell = cell + 1;
            cellBslLog(cell,1) = idxExp;
            cellBslLog(cell,2) = idxShank;
            cellBslLog(cell,3) = idxUnit;
            B = 0;
            bsl = zeros(n_trials,odors);
            for idxOdor = 1:odors
                A = [];
                A = coa1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                bsl(:,idxOdor) = sum(A(:,1:14000),2)./14;
                A = sum(A(:));
                B = B + A;
            end
            if B > 0    %remove cells with no spikes at all            
                cellBslLog(cell,4) = mean(bsl(:));
            else
                cellBslLog(cell,4) = NaN;
            end
        end
    end
end
            
%%
bslFR = [];
bslFR = cellBslLog(:,4);
bslFR(isnan(bslFR)) = [];
bslFRcoa = bslFR;
% figure; histfit(log10(bslFRcoa),100);
% median(bslFRcoa)


