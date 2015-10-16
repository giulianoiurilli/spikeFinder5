
j                           = 1;
 for rep = 1:500
     % Split training/testing
     idx                         = randperm(numInst);
     app_trainData               = data(idx(1:numTrain),:);
     app_testData                = data(idx(numTrain+1:end),:);
     trainLabel                  = labels(idx(1:numTrain));
     testLabel                   = labels(idx(numTrain+1:end));
     
     
     units = 175;
     idxUnits                = randsample(size(data,2), units);%1:units;%
     trainData               = app_trainData(:,idxUnits);
     testData                = app_testData(:,idxUnits);
     
     stepSize = 10;
     bestLog2c = 1;
     bestLog2g = -1;
     epsilon = 0.005;
     bestcv = 0;
     Ncv = 3; % Ncv-fold cross validation cross validation
     deltacv = 10^6;
     
     while abs(deltacv) > epsilon
         bestcv_prev = bestcv;
         prevStepSize = stepSize;
         stepSize = prevStepSize/2;
         log2c_list = bestLog2c-prevStepSize:stepSize/2:bestLog2c+prevStepSize;
         
         numLog2c = length(log2c_list);
         
         for i = 1:numLog2c
             log2c = log2c_list(i);
             cmd = ['-t 0 -q -c ', num2str(2^log2c)];
             cv = get_cv_ac(trainLabel, trainData, cmd, Ncv);
             if (cv >= bestcv),
                 bestcv = cv; bestc = 2^log2c;
             end
         end
         deltacv = bestcv - bestcv_prev;
         
     end
     C(rep) = bestc;  Accuracy(rep) = bestcv*100;
     j=j+1;
 end
 bestc = median(C);  bestcv = mean(Accuracy);
 disp(['The best parameters, yielding Accuracy=',num2str(bestcv),'%, are: C=',num2str(bestc)]);