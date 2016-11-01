%clear
load('units.mat');
rng('shuffle');
for idxShank = 1:4
    for idxSua = 1: length(shank(idxShank).SUA.spike_matrix)
        A = shank(idxShank).SUA.spike_matrix{idxSua};
        for idxOdor = 1:15
            idx = randperm(8);
            B = A(idx(1),:,idxOdor);
            C = A(idx(2),:,idxOdor);
            D(:,:,idxOdor) = cat(1, A(:,:,idxOdor), B , C);
        end
        shank(idxShank).SUA.spike_matrix{idxSua} = D;
    end
end

save('units.mat', 'shank')
            
            
            
            
        
    