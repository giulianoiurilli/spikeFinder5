%% 15 different odorants
%% _List of odors_
% CLASS A (aliphatic acids and aldheids)
% Pentanal Hexanoic acid Heptanal
% CLASS B (alcohols)
% Methyl butanol Heptanol Nonanol
% CLASS C (phenol and its derivatives)
% Phenetol Guaiacol m-Cresol
% CLASS D (thiazoles)
% 2,4,5-trimethyl thiazol
% Benzothiazol
% 2-methyl-2 thiazol
% AMINES
% Trimethylamine Isoamilamine 2-phenyl-ethylamine

%% *Anterior piriform cortex*
% Number of responsive units: *185*
% Number of cell-odor pairs: *1027*

%% _Tuning curves (auROC)_
% The response is taken over the first 4 sniffs.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/auROCtunings.fig');

%% _Grand average of olfactory responses and Fano factor_
% I used mean-matching (red, for each time bin I take only the cell-odor spike counts that don't exceed the overall firing and I regress the Fano factor), but I'm also showing spike counts and variances without mean-matching (black).
% The responses included in the left plots are aligne only to the first
% sniff.
% Note that the sub-sniff representation using a angle timescale can be
% misleading: there are of course more spikes in the exhalation phase
% because it lasts longer.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/FanoFactors.fig');

%% _Timecourse of the distance between odors_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/distance.fig');

%% _Timecourse of the total variance explained by the first three PCs_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/threePCs.fig');

%% _Timecourse of linear classification_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/classification.fig');

%% _Timecourse of spike count distributions_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/spikeDist.fig');

%% _Timecourse of the lifetime sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/ls.fig');

%% _Timecourse of the population sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/ps.fig');

%% _Similarity between tuning profiles of units recorded from the same shank_
% Here I consider the response in a time window of 4 sniffs
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/sigCorr.fig');

%% _Classification accuracy at different sniffs and with different windows (number of sniffs)_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/decodingByCycles.fig');

%% _Classification accuracy with concatenations of sniffs_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/decodingBinWidth.fig');

%% *Postero-lateral cortical amygdala*
% Number of responsive units: *281*
% Number of cell-odor pairs: *1163*

%% _Tuning curves (auROC)_
% The response is taken over the first 4 sniffs.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/auROCtunings.fig');

%% _Grand average of olfactory responses and Fano factor_
% I used mean-matching (red, for each time bin I take only the cell-odor spike counts that don't exceed the overall firing and I regress the Fano factor), but I'm also showing spike counts and variances without mean-matching (black).
% The responses included in the left plots are aligne only to the first
% sniff.
% Note that the sub-sniff representation using a angle timescale can be
% misleading: there are of course more spikes in the exhalation phase
% because it lasts longer.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/FanoFactors.fig');

%% _Timecourse of the sistance between odors_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/distance.fig');

%% _Timecourse of the total variance explained by the first three PCs_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/threePCs.fig');

%% _Timecourse of linear classification_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/classification.fig');

%% _Timecourse of spike count distributions_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/spikeDist.fig');

%% _Timecourse of the lifetime sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/ls.fig');

%% _Timecourse of the population sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/ps.fig');

%% _Similarity between tuning profiles of units recorded from the same shank_
% Here I consider the response in a time window of 4 sniffs
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/sigCorr.fig');

%% _Classification accuracy at different sniffs and with different windows (number of sniffs)_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/decodingByCycles.fig');

%% _Classification accuracy with concatenations of sniffs_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/decodingBinWidth.fig');