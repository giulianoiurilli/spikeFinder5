clear all


load('units.mat');
load('parameters.mat');

cycleLength = round(2*pi, 2) / radPerMs;

for sha = 1:4
    for s = 1:length(shank(sha).spiketimesUnit)
        bigMatrice = [];
        matrice = [];
        for k = 1:odors
            matrice = shank(sha).cell(s).odor(k).spikeMatrixRadMs;
            bigMatrice = [bigMatrice; matrice];
        end
        baselineBigMatrice = bigMatrice(:, 1 : preInhalations * round(2*pi, 2) / radPerMs);
        jj = 0;
        newBaselineBigMatrice = []; bslCycle = [];
        for ii = 1:preInhalations
            bslCycle = baselineBigMatrice(:,((ii-1) * cycleLength + 1 : cycleLength + (ii-1) * cycleLength));
            newBaselineBigMatrice = [newBaselineBigMatrice; bslCycle];
        end
        baseline = mean(newBaselineBigMatrice);
        matrice = [];
        averageMatrice = [];
        risposta = [];
        cumDistrBsl = []; cumDistrRsp = [];
        for k = 1:odors
            shank(sha).cell(s).odor(k).latency = [];
            shank(sha).cell(s).odor(k).excitation = [];
            shank(sha).cell(s).odor(k).inhibition = [];
            risposta = [];
            matrice = shank(sha).cell(s).odor(k).spikeMatrixRadMs;
            averageMatrice = mean(matrice);
            for ciclo = 1:4
                risposta = averageMatrice(((preInhalations + ciclo) * round(2*pi, 2)) / radPerMs :...
                    ((preInhalations + ciclo) * round(2*pi, 2)) / radPerMs + (1 * round(2*pi, 2) / radPerMs));
                risposta(end) = [];
                cumDistrBsl = cumsum(baseline);
                cumDistrRsp = cumsum(risposta);
                pvals = []; h = []; app = [];
                for i = 1:length(cumDistrBsl)
                    [hx, p] = kstest2(cumDistrBsl(1:i), cumDistrRsp(1:i), 'Alpha', 0.01);
                    pvals(i) = p;
                end
                [h, crit_p, adj_p]=fdr_bh(pvals,0.01,'dep','no');
                onset = find(h == 1,1);
                shank(sha).cell(s).odor(k).latency{ciclo} = onset;
                app = shank(sha).cell(s).odor(k).latency{ciclo};
                if ~isempty(app)
                    if cumDistrRsp(app) > cumDistrBsl(app) %& cumDistrRsp(end) > 1 % cumDistrRsp(end) > 1 dovrebbe prendere risposte con almen 5 spikes/ciclo ovvero ~15 Hz
                        %disp('e')
                        shank(sha).cell(s).odor(k).excitation(ciclo) = 1;
                        shank(sha).cell(s).odor(k).inhibition(ciclo) = 0;
                    else
                        %disp('i')
                        shank(sha).cell(s).odor(k).excitation(ciclo) = 0;
                        shank(sha).cell(s).odor(k).inhibition(ciclo) = 1;
                    end
                else
                    shank(sha).cell(s).odor(k).excitation(ciclo) = 0;
                    shank(sha).cell(s).odor(k).inhibition(ciclo) = 0;
                end
            end
        end
    end
end

save('units.mat', 'shank', '-append')