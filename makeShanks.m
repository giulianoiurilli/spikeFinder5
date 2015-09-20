%importa i 2 tetrodi di ogni shank, rimuovi le unita ripetute e salva le
%unita in ogni shank

% clear all
%close all
d = dir('buzsaki32L_00*.txt');
d = {d.name};

k=1;
for d_file = 1:4
    part1 = import_unit_spiketimes(d{k}, 2);
    k = k+1;
    part2 = import_unit_spiketimes(d{k}, 2);
    k = k+1;
    
    part1 = sortrows(part1,1); %sort by unit #
    part1(part1(:,1)==0,:) = []; % delete non-clustered units
    part1_u = SplitVec(part1(:,1), 'equal', 'firstval'); %find unit id
    part1(:,1) = part1(:,1) - part1_u(1) + 1; %make sure that unit ids start from 1
    part1_max = max(part1(:,1));
    part2 = sortrows(part2,1);
    part2(part2(:,1)==0,:) = [];
    part2_u = SplitVec(part2(:,1), 'equal', 'firstval');
    part2(:,1) = part2(:,1) - part2_u(1) + 1;
    part2_max = max(part2(:,1));
    fig = figure;
    counter = 1;

    for m = 1:part1_max
        for n = 1:part2_max
            subplot(numel(part1_u), numel(part2_u), counter)
            my_plot_xcorr(part1(part1(:,1) == m, 2), part2(part2(:,1) == n, 2), 0.001, 0.01, 1);
            counter = counter + 1;
        end
    end
    set (fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
    
    x = inputdlg('Enter second-set units to delete (space-separated numbers):',...
        'Units', [1 50]);
    deleted_units = str2num(x{:});
    
    
    part2(:,1) = part2(:,1) + repmat(part1_max, size(part2,1), 1);
    part2_max = part2_max + part1_max;
    
    joined_parts = [part1; part2];
    
    
    
    for j = deleted_units
        joined_parts(joined_parts(:,1) == j,:) = [];
    end
%     if ~(isempty(part2))
%         column = SplitVec(part2(:,1), 'equal', 'firstval');
%         for col_n = 1:numel(column)
%             part2(part2(:,1) == column(col_n), 3) = m + col_n;
%         end
%         part2(:,1) = [];
%         part2(:,[1,2]) = part2(:,[2,1]);
%     end
%     joined_parts = [part1; part2];
    for units_n = 1 : max(joined_parts(:,1))
        unit{units_n} = joined_parts(joined_parts(:,1)==units_n, 2);
    end
    
    shank(d_file).spiketimesUnit = unit;
    clear unit;
       
end

close all
save('units.mat', 'shank')