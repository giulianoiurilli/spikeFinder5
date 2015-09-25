% exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).
%
% smoothedPsth
%
% peakDigitalResponsePerCycle
%
% peakAnalogicResponsePerCycle
%
% peakLatencyPerCycle
%
% fullCycleDigitalResponsePerCycle
%
% fullCycleAnalogicResponsePerCycle
%
% aurocMax
%
% bestBinSize
%
% bestPhasePoint
%
% odorDriveAllCycles
%
% popCouplingAllCycles
%
% fullCycleAnalogicResponsePerCycleAllTrials
%
% peakAnalogicResponsePerCycleAllTrials
%
% spikeMatrix
%
% bslSpikeRate
%
% bslPeakRate
%
% bslPeakLatency
%
% cycleBslSdf
%
% baselinePhases
%
% responsePhases
%
% spikeMatrixNoWarp 
%
% sdf_trialNoWarp
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
%     'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
%     'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% extract response timecourse for each odor
%load('parameters.m')
A 

%% plot responses timecourses by pairs of concentrations
%listodors = {'2,4,5-trimethylthiazole', '4,5-dimethylthiazole', '5-methylthiazole', 'isobutylacetate', 'isoamylacetate', 'exanedione', 'butanedione','2-phenylethanol'};
%listodors = {'PE0', 'ET4', 'ET3', 'ET2', 'ET1', 'ET0', 'IA4', 'IA3', 'IA2', 'IA1', 'IA0', 'PE4', 'PE3', 'PE2', 'PE1'};
idxOdor1 = 9;
idxOdor2= 8;
B    %pre-requisite A

%% population responses without breathing warping (only first sniff alignement)
load('parameters.m')
C

%% MUA responses (low threshold spike detection, no breathing warping)
load('parameters.m')
D

%% plot responses and demixed responses of odor A vs odor B
load('parameters.m')
E

%% plot distribution of the best bin size
F

%% plot distribution of bsl spike rates 
load('parameters.m')
G

%% information vs time
%H %THIS IS NOT WORKING. NOT ENOUGH MEMORY.

%% prepare data for 'data high'
load('parameters.m')
I

%% SPIKE PHASE-LOCKING
load('parameters.m')
K

%% pca-score responses in a cycle
load('parameters.m')
J

%% PCA scoring of un-warped responses
load('parameters.m')
L

%% plot responses timecourses for concentration series
listOdors = {'pentanal', 'ethyl-tiglate', 'isoamylacetate'};
odorsRearr = [1 15 14 13 12 11 10 9 8 7 6 5 4 3 2];
idxOdor = 3; %from listOdors
idxOdor1 = odorsRearr(11); %from odorsRearr
idxOdor2 = odorsRearr(15);
idxOdor3 = odorsRearr(12);
idxOdor4 = odorsRearr(13);
idxOdor5 = odorsRearr(14);
M %requires A


%% extract auroc for excitatory responses and cycle spike counts for inhibitory responses 
N

%% plot auroc for excitatory responses and cycle spike counts for inhibitory responses
odorsRearr = [1 15 14 13 12 11 10 9 8 7 6 5 4 3 2];
idxOdor = 3;
listOdorConc = [odorsRearr(11) odorsRearr(15) odorsRearr(12) odorsRearr(13) odorsRearr(14)];
O
%% clearvars
clearvars -except exp








         