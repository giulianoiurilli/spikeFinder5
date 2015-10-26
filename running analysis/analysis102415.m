windowLength = 200;
n_sniffs = 9;

unitsToKeep = 0;
for idxExp = 1 : length(List) - 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankNowarp(idxShank).cell)
            if exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1
                unitsToKeep = unitsToKeep + 1;
            end
        end
    end
end

X = zeros(unitsToKeep * odors, windowLength * n_sniffs);
Y = zeros(unitsToKeep * odors, windowLength * n_sniffs);

%%
idxResp = 1;
scarta = 0;
for idxExp = 1 : length(List) - 1
    cartella = List{idxExp};
    cd(cartella)
    disp(cartella)
    load('breathing.mat', 'sniffs');
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankNowarp(idxShank).cell)
            if exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1
                for idxOdor = 1:odors
                    responses = [];
                    responses = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
                    try
                    [restCumResp, odorCumResp] = buildCumResponse(responses, sniffs, windowLength, n_sniffs, idxOdor);
                    X(idxResp,:) = restCumResp;
                    Y(idxResp,:) = odorCumResp;
                    idxResp = idxResp + 1;
                    catch
                        scarta = scarta + 1;
                        disp('error in')
                        disp(cartella)
                    end
                end
            end
        end
    end
    clear sniffs
end

X(end-scarta:end,:) = [];
Y(end-scarta:end,:) = [];
Z = [X Y];
figure; imagesc(Z), axis tight, colorbar
