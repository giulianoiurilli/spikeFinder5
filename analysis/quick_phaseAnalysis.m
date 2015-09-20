parameters
unit = 1;
for ii = 1 : length(List)
    cartella = List{ii};
    %     folder1 = cartella(end-11:end-6)
    %     folder2 = cartella(end-4:end)
    %     cartella = [];
    %     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/%s/%s', folder1, folder2);
    cd(cartella)
    load('units.mat');
    for sha=1:4
        for s=1:length(shank(sha).timeOnset)
            for k=1:odors
                if sum(~isnan(shank(sha).cell(s).spike_resp_phase_bsl{k})) > 0 & sum(~isnan(shank(sha).cell(s).spike_resp_phase_rsp{k})) > 0
                    
                    app = shank(sha).cell(s).spike_resp_phase_bsl{k};
                    app1 = app(~isnan(app));
                    mean_phase_bsl(unit,k) = circ_mean(app1, [], 2);
                    var_bsl = circ_var(app1, [], [], 2);
                    app = []; app1 = [];
                    
                    app = shank(sha).cell(s).spike_resp_phase_rsp{k};
                    app1 = app(~isnan(app));
                    mean_phase_rsp(unit,k) = circ_mean(app1, [], 2);
                    var_rsp = circ_var(app1, [], [], 2);
                    app = []; app1 = [];
                    
                    reco_shift(unit,k) =  mean_phase_bsl(unit,k)-mean_phase_rsp(unit,k);
                    reco_shank(unit,k) = sha;
                    reco_unit(unit,k) = s;
                    reco_exp(unit,k) = ii;
                    reco_bsl(unit,k) = shank(sha).baseline_cell_odor_pair{s}(k);
                    reco_rsp(unit,k) = mean(shank(sha).response_cell_odor_pair{s}(:,k));
                    reco_var(unit,k) = var_rsp;
                    reco_peak(unit,k) = shank(sha).timePeak{s}(k);
                    
                    
                else
                    mean_phase_bsl(unit,k) = nan;
                    mean_phase_rsp(unit,k) = nan;
                    var_bsl = nan;
                    var_rsp = nan;
                    app = []; app1 = [];
                    reco_shift(unit,k) =  mean_phase_bsl(unit,k)-mean_phase_rsp(unit,k);
                    reco_shank(unit,k) = sha;
                    reco_unit(unit,k) = s;
                    reco_exp(unit,k) = ii;
                    reco_bsl(unit,k) = shank(sha).baseline_cell_odor_pair{s}(k);
                    reco_rsp(unit,k) = mean(shank(sha).response_cell_odor_pair{s}(:,k));
                    reco_var(unit,k) = var_rsp;
                    reco_peak(unit,k) = shank(sha).timePeak{s}(k);
                    reco_odor(unit,k) = k;
                    
                end
            end
        end
        unit = unit + 1;
    end
end

app1 = mean_phase_bsl(:);
app2 = mean_phase_rsp(:);
app = [app1 app2];
app(isnan(app1), :) =[];
app2(isnan(app1), :) =[];
app(isnan(app2), :) =[];
% app1=[];
% app2=[];
% app1 = circ_rad2ang(app(:,1));
% app2 = circ_rad2ang(app(:,2));


labelWithin = repmat('air', length(app2), 1);
labelBetween = repmat('odor', length(app2), 1);
labels = strvcat(labelWithin, labelBetween);
figure
my_ttest2_boxplot(app(:,1), app(:,2), labels)


% figure
% subplot(1,2,1)
% rose(app(:,1))
% subplot(1,2,2)
% rose(app(:,2))


app=[];
app = mean_phase_bsl(:);
app1 = [];
app1 = reco_shift(:);
app1 = app1(app<0);
app2 = [];
app2 = reco_exp(:);
app2 = app2(app<0);
app3 = [];
app3= reco_shank(:);
app3 = app3(app<0);
app4 = [];
app4= reco_unit(:);
app4 = app4(app<0);
app5 = [];
app5= reco_odor(:);
app5 = app5(app<0);
app6 = [];
app6 = mean_phase_rsp(:);
app6 = app6(app<0);
app1 = app1(app6>0);
app2 = app2(app6>0);
app3 = app3(app6>0);
app4 = app4(app6>0);
app5 = app5(app6>0);


for ii = 1:length(app2)
    cartella = List{app2(ii)};
    try
    spike_breathing_phase(cartella, app2(ii), app3(ii), app4(ii), app5(ii))
    catch
        disp('failed')
    end
end

    

