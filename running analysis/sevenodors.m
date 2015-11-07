%% 7 odors. Pairs of odors are highly similar. Tested at 2 concentrations.
%% _List of odors_
% 2,4,5-methylthiazole 4,5-methylthiazole 5-methylthiazole
% isoamyacetate isobutylacetate
% butanedione exanedione
% 2-phenyl-ethanol

%% *Anterior piriform cortex*
% Number of responsive units: *80*
% Number of cell-odor pairs: *483*

%% _Tuning curves (auROC)_
% The response is taken over the first 4 sniffs.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/auROCtunings.fig');

%% _Grand average of olfactory responses and Fano factor_
% I used mean-matching (red, for each time bin I take only the cell-odor spike counts that don't exceed the overall firing and I regress the Fano factor), but I'm also showing spike counts and variances without mean-matching (black).
% The responses included in the left plots are aligne only to the first
% sniff.
% Note that the sub-sniff representation using a angle timescale can be
% misleading: there are of course more spikes in the exhalation phase
% because it lasts longer.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/FanoFactors.fig');

%% _Timecourse of the distance between odors_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/distance.fig');

%% _Timecourse of the total variance explained by the first three PCs_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/threePCs.fig');

%% _Timecourse of linear classification_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/classification.fig');

%% _Timecourse of spike count distributions_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/spikeDist.fig');

%% _Timecourse of the lifetime sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/ls.fig');

%% _Timecourse of the population sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/ps.fig');

%% _Similarity between tuning profiles of units recorded from the same shank_
% Here I consider the response in a time window of 4 sniffs
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/sigCorr.fig');

%% _Classification accuracy at different sniffs and with different windows (number of sniffs) - High concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/decodingByCyclesHigh.fig');

%% _Classification accuracy with concatenations of sniffs - High concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/decodingBinWidthHigh.fig');
%% _Classification accuracy at different sniffs and with different windows (number of sniffs) - Low concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/decodingByCyclesLow.fig');

%% _Classification accuracy with concatenations of sniffs - Low concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/decodingBinWidthLow.fig');

%% *Postero-lateral cortical amygdala*
% Number of responsive units: *56*
% Number of cell-odor pairs: *271*

%% _Tuning curves (auROC)_
% The response is taken over the first 4 sniffs.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/auROCtunings.fig');

%% _Grand average of olfactory responses and Fano factor_
% I used mean-matching (red, for each time bin I take only the cell-odor spike counts that don't exceed the overall firing and I regress the Fano factor), but I'm also showing spike counts and variances without mean-matching (black).
% The responses included in the left plots are aligne only to the first
% sniff.
% Note that the sub-sniff representation using a angle timescale can be
% misleading: there are of course more spikes in the exhalation phase
% because it lasts longer.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/FanoFactors.fig');

%% _Timecourse of the sistance between odors_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/distance.fig');

%% _Timecourse of the total variance explained by the first three PCs_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/threePCs.fig');

%% _Timecourse of linear classification_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/classification.fig');

%% _Timecourse of spike count distributions_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/spikeDist.fig');

%% _Timecourse of the lifetime sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/spikeDist.fig');

%% _Timecourse of the population sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/spikeDist.fig');

%% _Similarity between tuning profiles of units recorded from the same shank_
% Here I consider the response in a time window of 4 sniffs
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/sigCorr.fig');

%% _Classification accuracy at different sniffs and with different windows (number of sniffs) - High concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/decodingByCyclesHigh.fig');

%% _Classification accuracy with concatenations of sniffs - High concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/decodingBinWidthHigh.fig');
%% _Classification accuracy at different sniffs and with different windows (number of sniffs) - Low concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/aPCX/decodingByCyclesLow.fig');

%% _Classification accuracy with concatenations of sniffs - Low concentrations_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/2conc/plCoA/decodingBinWidthLow.fig');