samplingFrequency = 20000;
responseWindow = 2;
triggerToOnsetDelay = 3;
thresTTL = 0.5;
preTrigger = 1;
postTrigger = 4;
preOnset = preTrigger + triggerToOnsetDelay;
postOnset = responseWindow + postTrigger;

sigmaSDF = 0.1;

save('paramsExperiment.mat', 'samplingFrequency', 'responseWindow', 'triggerToOnsetDelay', 'thresTTL', 'preTrigger', 'postTrigger', 'preOnset', 'postOnset', 'sigmaSDF')