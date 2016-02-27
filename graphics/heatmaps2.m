clear all
close all


blanks = uigetdir('', 'Select folder where blank heatmaps are stored');
odour = uigetdir('', 'Select folder where test odour heatmaps are stored');
results = uigetdir('', 'Select folder where results will be saved');

string_map = sprintf('heatmap*.csv');
string_roi = sprintf('roi*.csv');

maps_blanks = dir(fullfile(blanks,string_map));
maps_odour = dir(fullfile(odour,string_map));
roi_blanks = dir(fullfile(blanks,string_roi));
roi_odour = dir(fullfile(odour,string_roi));

map_b = [];
map_o = [];
roi_b = [];
roi_o = [];

v = [1 0];

for k = 1:length(maps_blanks)
    
    map_b = [];
    map_o = [];
    roi_b = [];
    roi_o = [];
    
    map_b = load(fullfile(blanks,maps_blanks(k).name),'csv');
    map_o = load(fullfile(odour,maps_odour(k).name),'csv');
    roi_b = load(fullfile(blanks,roi_blanks(k).name),'csv');
    roi_o = load(fullfile(odour,roi_odour(k).name),'csv');
    
    map_b = map_b(roi_b(2):roi_b(4),roi_b(1):roi_b(3));
    map_o = map_o(roi_o(2):roi_o(4),roi_o(1):roi_o(3));
    
    map_b = imresize(map_b, [160 160]);
    map_o = imresize(map_o, [160 160]);

    top_right_b = map_b(1:80, 81:160);
    top_left_b = map_b(1:80, 1:80);
    bottom_right_b = map_b(81:160, 81:160);
    bottom_left_b = map_b(81:160, 1:80);
    
    tr_b(k) = sum(top_right_b(:));
    tl_b(k) = sum(top_left_b(:));
    br_b(k) = sum(bottom_right_b(:));
    bl_b(k) = sum(bottom_left_b(:));
    tot_b(k) = tr_b(k)+tl_b(k)+br_b(k)+bl_b(k);
    
    rel_tr_b(k) = tr_b(k) / tot_b(k) * 100;
    rel_tl_b(k) = tl_b(k) / tot_b(k) * 100;
    rel_br_b(k) = br_b(k) / tot_b(k) * 100;
    rel_bl_b(k) = bl_b(k) / tot_b(k) * 100;
    
    top_right_o = map_o(1:80, 81:160);
    top_left_o = map_o(1:80, 1:80);
    bottom_right_o = map_o(81:160, 81:160);
    bottom_left_o = map_o(81:160, 1:80);
    
    tr_o(k) = sum(top_right_o(:));
    tl_o(k) = sum(top_left_o(:));
    br_o(k) = sum(bottom_right_o(:));
    bl_o(k) = sum(bottom_left_o(:));
    tot_o(k) = tr_o(k)+tl_o(k)+br_o(k)+bl_o(k);
    
    rel_tr_o(k) = tr_o(k) / tot_o(k) * 100;
    rel_tl_o(k) = tl_o(k) / tot_o(k) * 100;
    rel_br_o(k) = br_o(k) / tot_o(k) * 100;
    rel_bl_o(k) = bl_o(k) / tot_o(k) * 100;
    
    diff_tr(k) = rel_tr_o(k) - rel_tr_b(k);
    diff_tl(k) = rel_tl_o(k) - rel_tl_b(k);
    diff_br(k) = rel_br_o(k) - rel_br_b(k);
    diff_bl(k) = rel_bl_o(k) - rel_bl_b(k);
    
    tot_o(k) = tr_b(k)+tl_b(k)+br_b(k)+bl_b(k);
    
    delta_tr(k) = (tr_o(k) - tr_b(k)) / tot_b(k) * 100;
    delta_tl(k) = (tl_o(k) - tl_b(k)) / tot_b(k) * 100;
    delta_br(k) = (br_o(k) - br_b(k)) / tot_b(k) * 100;
    delta_bl(k) = (bl_o(k) - bl_b(k)) / tot_b(k) * 100;
    
    kdelta_tr(k) = (tr_o(k) - tr_b(k)) / tr_b(k) * 100;
    kdelta_tl(k) = (tl_o(k) - tl_b(k)) / tl_b(k) * 100;
    kdelta_br(k) = (br_o(k) - br_b(k)) / br_b(k) * 100;
    kdelta_bl(k) = (bl_o(k) - bl_b(k)) / bl_b(k) * 100;
    
    CT=cellfun(@(n) 1:n, num2cell(size(map_o)),'uniformoutput',0);
    [CT{:}]=ndgrid(CT{:});
    CT=cellfun(@(x) x(:), CT,'uniformoutput',0);
    CT=[CT{:}];
    CenterOfMassT{k}=map_o(:).'*CT/sum(map_o(:),'double');
    
    CT=cellfun(@(n) 1:n, num2cell(size(map_b)),'uniformoutput',0);
    [CT{:}]=ndgrid(CT{:});
    CT=cellfun(@(x) x(:), CT,'uniformoutput',0);
    CT=[CT{:}];
    CenterOfMassB{k}=map_b(:).'*CT/sum(map_b(:),'double');
    
    direction(k,:) =  [floor(CenterOfMassT{k}(2)) - floor(CenterOfMassB{k}(2)) floor(CenterOfMassB{k}(1)) - floor(CenterOfMassT{k}(1))];
    modulus(k) = norm(direction(k,:));
    theta(k) = mod(atan2(direction(k,1)*v(2)-direction(k,2)*v(1),direction(k,1)*v(1)+direction(k,2)*v(2)),2*pi);
end

avg_diff_tr = mean(diff_tr(:));
avg_diff_tl = mean(diff_tl(:));
avg_diff_br = mean(diff_br(:));
avg_diff_bl = mean(diff_bl(:));

std_diff_tr = std(diff_tr(:));
std_diff_tl = std(diff_tl(:));
std_diff_br = std(diff_br(:));
std_diff_bl = std(diff_bl(:));

mean_direction = mean(direction);

fig = figure(1001);
set(gcf, 'Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);
max_lim = 75;
x_fake=[0 max_lim 0 -max_lim];
y_fake=[max_lim 0 -max_lim 0];
h_fake=compass(x_fake,y_fake);
for k=1:k
    hold on
    compass(direction(k,1),direction(k,2))
end
compass(mean_direction(1),mean_direction(2), 'r')
set(h_fake,'Visible','off');
hold off
h=findall(gca);
gh=h(strcmp(get(h,'linestyle'),':'));
set(gh,'visible','off')
%find all of the text objects in the polar plot
t = findall(gcf,'type','text');
%delete the text objects
delete(t);
title('TMT-induced shift of the centres of mass')
stringa_fig=sprintf('shift.png');
saveas(fig,fullfile(results,stringa_fig),'png')

stringa=sprintf('analisys.mat');
save(fullfile(results,stringa),'tr_b', 'tl_b', 'br_b', 'bl_b', 'tr_o', 'tl_o', 'br_o', 'bl_o', 'tot_b', 'tot_o',...
    'diff_tr', 'diff_tl', 'diff_br', 'diff_bl', 'delta_tr', 'delta_tl', 'delta_br', 'delta_bl', 'theta',...
    'modulus', 'direction', 'mean_direction', 'CenterOfMassB','CenterOfMassT')

    