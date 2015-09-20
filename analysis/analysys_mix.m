toFolder = pwd;
new_dir = 'Analysis figures - mix';
toFolder = fullfile(toFolder, new_dir);
mkdir(toFolder)
filename = sprintf('mix_plCoA.mat');
fileSave = fullfile(toFolder, filename);

curves = [];
unit = 1;

for ii = 1 : length(List)
    cartella = List{ii};
%     folder1 = cartella(end-11:end-6)
%     folder2 = cartella(end-4:end)
%     cartella = [];
%     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/%s/%s', folder1, folder2);
    cd(cartella)
    load('units.mat');
    load('parameters.mat');

 curves = [curves; signalVector];
     for sha=1:4
        for s=1:length(shank(sha).spike_matrix)
            for k=1:15 %odors
                spike_matrix_app = shank(sha).spike_matrix{s}(:,:,k);
                response(unit,k) = mean(sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000),2));
            end
            unit = unit + 1;
        end
     end
                
end

response(curves==0) = 0;

response(:,4:5) = [];
response(:,7:8) = [];
curves(:,4:5) = [];
curves(:,7:8) = [];
energy_curves = curves * curves';
respCells = find(~(diag(energy_curves)==0));



response = response(respCells,:);



btnd_ger_ratio = response(:,7) ./ (response(:,5) + response(:,6));
btnd_ger_ratio(isnan(btnd_ger_ratio)) = [];
btnd_ger_ii = (response(:,7) - max([response(:,5) response(:,6)], [], 2)) ./ (response(:,7) + max([response(:,5) response(:,6)], [], 2));
btnd_ger_ii(isnan(btnd_ger_ii)) = [];
new_btnd_ger = length(find(btnd_ger_ii == 1)); 
sup_btnd_ger = length(find(btnd_ger_ii == -1)); 

btnd_peth_ratio = response(:,8) ./ (response(:,5) + response(:,4));
btnd_peth_ratio(isnan(btnd_peth_ratio)) = [];
btnd_peth_ii = (response(:,8) - max([response(:,5) response(:,4)], [], 2)) ./ (response(:,8) + max([response(:,5) response(:,4)], [], 2));
btnd_peth_ii(isnan(btnd_peth_ii)) = [];
new_btnd_peth = length(find(btnd_peth_ii == 1)); 
sup_btnd_peth = length(find(btnd_peth_ii == -1)); 

btnd_tmt_ratio = response(:,9) ./ (response(:,5) + response(:,1));
btnd_tmt_ratio(isnan(btnd_tmt_ratio)) = [];
btnd_tmt_ii = (response(:,9) - max([response(:,5) response(:,1)], [], 2)) ./ (response(:,9) + max([response(:,5) response(:,1)], [], 2));
btnd_tmt_ii(isnan(btnd_tmt_ii)) = [];
new_btnd_tmt = length(find(btnd_tmt_ii == 1)); 
sup_btnd_tmt = length(find(btnd_tmt_ii == -1)); 

mmb_tmt_ratio = response(:,10) ./ (response(:,2) + response(:,1));
mmb_tmt_ratio(isnan(mmb_tmt_ratio)) = [];
mmb_tmt_ii = (response(:,10) - max([response(:,2) response(:,1)], [], 2)) ./ (response(:,10) + max([response(:,2) response(:,1)], [], 2));
mmb_tmt_ii(isnan(mmb_tmt_ii)) = [];
new_mmb_tmt = length(find(mmb_tmt_ii == 1)); 
sup_mmb_tmt = length(find(mmb_tmt_ii == -1)); 

tmb_tmt_ratio = response(:,11) ./ (response(:,3) + response(:,1));
tmb_tmt_ratio(isnan(tmb_tmt_ratio)) = [];
tmb_tmt_ii = (response(:,11) - max([response(:,3) response(:,1)], [], 2)) ./ (response(:,11) + max([response(:,3) response(:,1)], [], 2));
tmb_tmt_ii(isnan(tmb_tmt_ii)) = [];
new_tmb_tmt = length(find(tmb_tmt_ii == 1)); 
sup_tmb_tmt = length(find(tmb_tmt_ii == -1)); 

tot_ratio = [btnd_ger_ratio' btnd_peth_ratio' btnd_tmt_ratio' mmb_tmt_ratio' tmb_tmt_ratio'];
tot_ratio_predator = [mmb_tmt_ratio' tmb_tmt_ratio'];
tot_ratio_att = [btnd_ger_ratio' btnd_peth_ratio'];

tot_ii = [btnd_ger_ii' btnd_peth_ii' btnd_tmt_ii' mmb_tmt_ii' tmb_tmt_ii'];
tot_ii_predator = [mmb_tmt_ii' tmb_tmt_ii'];
tot_ii_att = [btnd_ger_ii' btnd_peth_ii'];


a = new_btnd_ger+ new_btnd_peth+ new_btnd_tmt+ new_mmb_tmt+ new_tmb_tmt;
b = sup_btnd_ger+ sup_btnd_peth+ sup_btnd_tmt+ sup_mmb_tmt+ sup_tmb_tmt;
%tot_new = (a ./ (length(btnd_ger_ii) + length(btnd_peth_ii) + length(tmb_tmt_ii) + length(btnd_tmt_ii) +length(mmb_tmt_ii))) * 100;
tot_sup = (b ./ (length(btnd_ger_ii) + length(btnd_peth_ii) + length(tmb_tmt_ii) + length(btnd_tmt_ii) +length(mmb_tmt_ii))) * 100;


plCoA_btnd_ger_ratio=btnd_ger_ratio;
plCoA_btnd_ger_ii=btnd_ger_ii;
plCoA_btnd_peth_ratio=btnd_peth_ratio;
plCoA_btnd_peth_ii = btnd_peth_ii;
plCoA_btnd_tmt_ratio=btnd_tmt_ratio;
plCoA_btnd_tmt_ii=btnd_tmt_ii;
plCoA_mmb_tmt_ratio=mmb_tmt_ratio;
plCoA_mmb_tmt_ii=mmb_tmt_ii;
plCoA_tmb_tmt_ratio=tmb_tmt_ratio;
plCoA_tmb_tmt_ii=tmb_tmt_ii;
plCoA_tot_ratio=tot_ratio;
plCoA_tot_ratio_predator=tot_ratio_predator;
plCoA_tot_ratio_att=tot_ratio_att;
plCoA_tot_ii=tot_ii;
plCoA_tot_ii_predator=tot_ii_predator;
plCoA_tot_ii_att=tot_ii_att;
plCoA_tot_sup=tot_sup;
plCoA_tot_new=tot_new;

save(fileSave)





