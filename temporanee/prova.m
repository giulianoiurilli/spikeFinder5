odorToUse = [8 10 11 12 13 7];
aur = [];
responsesSpiCo = [];
responsesTiCo = [];
indicatore = [];
idxOdorLoop = 1;
for idxOdor = odorToUse
    aur(idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax(1);
    rspOn(idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1);
    responsesSpiCo(:,idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycleAllTrials(:,1);
    responsesSpiCo(:,idxOdorLoop) = responsesSpiCo(:,idxOdorLoop) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
    responsesTiCo(:,:,idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth(:,4*cycleLengthDeg:5*cycleLengthDeg);
    idxOdorLoop = idxOdorLoop + 1;
end