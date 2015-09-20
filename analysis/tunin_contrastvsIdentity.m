[response, index] = max(sorted_signalVector, [], 2);
edges_bin = 1:5:15;
[N, edges_bin, bins] = histcounts(index, edges_bin)



a = [1 6 11; 2 7 12; 3 8 13; 4 9 14; 5 10 15];

for i = 1:size(sorted_signalVector,1)
    for k = 1:5
        tune(k,:) =  sorted_signalVector(i, a(k,:));
    end
    tun_cell{i} = tune;
    figure; plot(tune')
end



