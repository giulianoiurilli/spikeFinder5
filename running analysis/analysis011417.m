esp = [];
espe = [];
esperimento = [];
odorsRearranged = [4     6     7     9    10     1     2     3     5     8];
for idxExp =  1:length(coaAA.esp)
    esp(idxExp).filename = coaAA.esp(idxExp).filename;
    for idxShank = 1:4
        if ~isempty(coaAA.esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(coaAA.esp(idxExp).shank(idxShank).SUA.cell)
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliability =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliability;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliabilityPvalue =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliabilityPvalue;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).isolationDistance =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).isolationDistance;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).clusterID =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).clusterID;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sourceFolder =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sourceFolder;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).meanWaveform =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).meanWaveform;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spike_contamination =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spike_contamination;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_ratio =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_ratio;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_time =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_time;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).half_amplitude_duration =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).half_amplitude_duration;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls300ms =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls300ms;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls1s =...
                    coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls1s;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).peakLatency =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).peakLatency;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).halfWidth =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).halfWidth;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).onsetLatency =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).onsetLatency;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse300ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsll300ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC300ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse300ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse2000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsll2000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC2000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse2000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseOffset =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponseOffset;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsllOffset =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBslOffset;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROCOffset =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROCOffset;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExc1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExc1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInh1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInh1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeak1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcWind1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhWind1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeakDelta1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000ms =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeakDelta1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseDeltaPeakHz =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponseDeltaPeakHz;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseDeltaPeak =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponseDeltaPeak;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExc =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionExc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInh =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionInh;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExc =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionExc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInh =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionInh;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExc1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExc1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInh1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInh1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeak1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcWind1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhWind1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeakDelta1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000msBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeakDelta1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExcBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionExcBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInhBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionInhBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExcBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionExcBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInhBsl =...
                        coaAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionInhBsl;
                    
                    espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix =...
                        coaAA_1.espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix;
                    
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrixRad =...
                        coaAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrixRad;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sniffBinnedPsth =...
                        coaAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).sniffBinnedPsth;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).inh_exa_cycleLength =...
                        coaAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).inh_exa_cycleLength;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).alphaTrial =...
                        coaAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).alphaTrial;
                end
            end
        else 
            esp(idxExp).shank(idxShank).SUA = [];
            espe(idxExp).shank(idxShank).SUA = [];
            esperimento(idxExp).shank(idxShank).SUA = [];
        end
    end
end
save('plCoA_AA_1.mat', 'espe')
save('plCoA_AA_2.mat', 'esp')
save('plCoA_AA_3.mat', 'esperimento')
esp = [];
espe = [];
esperimento = [];


odorsRearranged = [4     6     7     9    10     1     2     3     5     8];
for idxExp =  1:length(pcxAA.esp)
    esp(idxExp).filename = pcxAA.esp(idxExp).filename;
    for idxShank = 1:4
        if ~isempty(pcxAA.esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(pcxAA.esp(idxExp).shank(idxShank).SUA.cell)
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliability =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliability;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliabilityPvalue =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliabilityPvalue;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).isolationDistance =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).isolationDistance;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).clusterID =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).clusterID;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sourceFolder =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sourceFolder;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).meanWaveform =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).meanWaveform;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spike_contamination =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spike_contamination;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_ratio =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_ratio;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_time =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_time;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).half_amplitude_duration =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).half_amplitude_duration;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls300ms =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls300ms;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls1s =...
                    pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls1s;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).peakLatency =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).peakLatency;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).halfWidth =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).halfWidth;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).onsetLatency =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).onsetLatency;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse300ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsll300ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC300ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse300ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse2000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsll2000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC2000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse2000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse2000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseOffset =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponseOffset;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsllOffset =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBslOffset;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROCOffset =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROCOffset;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExc1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExc1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInh1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInh1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeak1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcWind1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhWind1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeakDelta1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000ms =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeakDelta1000ms;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseDeltaPeakHz =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponseDeltaPeakHz;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseDeltaPeak =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponseDeltaPeak;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExc =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionExc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInh =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionInh;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExc =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionExc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInh =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionInh;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExc1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExc1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInh1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInh1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeak1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcWind1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhWind1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeakDelta1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000msBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialInhPeakDelta1000msBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExcBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionExcBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInhBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responsePeakFractionInhBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExcBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionExcBsl;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInhBsl =...
                        pcxAA.esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).responseWindFractionInhBsl;
                    
                    espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix =...
                        pcxAA_1.espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix;
                    
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrixRad =...
                        pcxAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrixRad;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sniffBinnedPsth =...
                        pcxAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).sniffBinnedPsth;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).inh_exa_cycleLength =...
                        pcxAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).inh_exa_cycleLength;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).alphaTrial =...
                        pcxAA_3.esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).alphaTrial;
                end
            end
        else 
            esp(idxExp).shank(idxShank).SUA = [];
            espe(idxExp).shank(idxShank).SUA = [];
            esperimento(idxExp).shank(idxShank).SUA = [];
        end
    end
end

save('aPCx_AA_1.mat', 'espe')
save('aPCx_AA_2.mat', 'esp')
save('aPCx_AA_3.mat', 'esperimento')
