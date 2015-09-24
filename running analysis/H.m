%% information vs time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% THIS IS NOT WORKING. NOT ENOUGH MEMORY.
% The best bin size seems to be 100 ms. Let's move 100ms bin by 5 ms step
% from the -2 cycle to the 10th cycle and let's calculate the information
% carried by the population for each bin. The population includes only
% units that had at least 1 aurocMax > 0.75 or a significant peak
% amplitude. Let's make 8 equipopulated bins for the responses. Let's
% consider only odors at the same concentration.

% binWidth = 100;
% odorList = 8:15;
% 
% bslActivityRemodeled =[];
% neuronActivity =[];
% idxNeuron = 1;
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
%             peakResponses = [];
%             rocMax = [];
%             for idxOdor = odorList
%                 peakResponses = [peakResponses find(exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).peakDigitalResponsePerCycle > 0)];
%                 rocMax =  [rocMax find(exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).aurocMax > 0.75)];
%             end
%             if ~isempty(peakResponses) || ~isempty(rocMax)
%                 bslActivity = exp(idxExp).shank(idxShank).cell(idxNeuron).cycleBslSdf;
%                 for idxTrial = 1:n_trials
%                     v = zeros(1,cycleLengthDeg);
%                     v = v + mean(bslActivity(randi(floor(size(bslActivity,1)/n_trials)),:));
%                     bslActivityRemodeled{idxNeuron}(idxTrial, :) = v;
%                 end
%                 %                 for step = 1:5: 10*cycleLength - 105
%                 %                     airResponse(idxNeuron,:,step) = mean(bslActivityRemodeled(:,step:step + binWidth),2);
%                 %                 end
%                 idxOdor = 1;
%                 for idxOdor = odorList
%                     neuronActivity{idxNeuron}(:, :, idxOdor) = exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).smoothedPsth(:,2*cycleLengthDeg + 1: end);
%                     idxOdor = idxOdor+1;
%                 end
%                 idxNeuron = idxNeuron+1;
%             end
%         end
%     end
% end
% 
% R = [];
% bslR = [];
% oR = [];
% 
% idxPasso = 1;
% for passo = 1:5:cycleLengthDeg-binWidth
%     B = zeros(length(bslActivityRemodeled), n_trials);
%     B = zeros(1, n_trials);
%     for idxNeuron = 1:1%:length(bslActivityRemodeled)
%         v= zeros(n_trials,1);
%         v = v + mean(bslActivityRemodeled{idxNeuron}(:,passo:passo+binWidth), 2);
%         v = v';
%         B(idxNeuron,:) = v;
%     end
%     bslR{idxPasso} = B;
%     idxPasso = idxPasso+1;
% end
% 
% 
% X = [];
% R = [];
% for idxCycle = 1:postInhalations + 2
%     idxPasso = 1;
%     for passo = 1:5:cycleLengthDeg-binWidth
%         oR = zeros(length(bslActivityRemodeled), n_trials, length(odorList));
%         oR = zeros(1, n_trials, length(odorList));
%         for idxNeuron = 1:1%:length(bslActivityRemodeled)
%             v = zeros(n_trials,1,length(odorList));
%             v = v + mean(neuronActivity{idxNeuron}(:, idxCycle * passo:idxCycle * passo+binWidth, :), 2);
%             v = permute(v,[2,1,3]);
%             oR(idxNeuron,:,:) = v;
%         end
%         R = cat(3, oR, bslR{idxPasso});
%         R = binr(R, n_trials, 9, 'eqspace');
%         opts.nt = repmat(n_trials, 1, size(R,3));
%         opts.method = 'dr';
%         opts.bias = 'pt';
%         X(idxCycle,idxPasso) = information(R, opts, 'Ish');
%         idxPasso = idxPasso + 1;
%     end
% end
        
            
% X = reshape(X',1,size(X,1)*size(X,2));
% figure; plot(X)

