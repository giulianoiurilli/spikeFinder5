%% Predator and allegedly attractive odors. And mixes od odors.
%% _List of odors_
% _Predators_
% 2,3,5-trimethyl-3-thiazoline
% 3-mercapto-3-methylbutan-1-ol
% 2-methylbutyric acid
% 2-propyltiethane
% isoamylamamine
%
% _allegedly attractive_ (Why should I spend more time exploring something
% that I like?)
% 2-phenylethanol
% 2,3-butanedione
% geraniol
% peanut oil
% estrus female urine
%
% _Mixes_
% 2,3-butanedione + geraniol
% 2,3-butanedione + 2-phenylethanol
% 
% 2,3,5-trimethyl-3-thiazoline + 2,3-butanedione
% 2,3,5-trimethyl-3-thiazoline  + 3-mercapto-3-methylbutan-1-ol
% 2,3,5-trimethyl-3-thiazoline + 2-methylbutyric acid

%% *Anterior piriform cortex*
% Number of responsive units: *149*
% Number of cell-odor pairs: *781*

%% _Tuning curves (auROC)_
% The response is taken over the first 4 sniffs.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/auROCtunings.fig');

%% _Grand average of olfactory responses and Fano factor_
% I used mean-matching (red, for each time bin I take only the cell-odor spike counts that don't exceed the overall firing and I regress the Fano factor), but I'm also showing spike counts and variances without mean-matching (black).
% The responses included in the left plots are aligne only to the first
% sniff.
% Note that the sub-sniff representation using a angle timescale can be
% misleading: there are of course more spikes in the exhalation phase
% because it lasts longer.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/FanoFactors.fig');

%% _Timecourse of the distance between odors_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/distance.fig');

%% _Timecourse of the total variance explained by the first three PCs_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/threePCs.fig');

%% _Timecourse of linear classification_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
% Classification is between all odors, mixes included
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/classification.fig');

%% _Timecourse of spike count distributions_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/spikeDist.fig');

%% _Timecourse of the lifetime sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/ls.fig');

%% _Timecourse of the population sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/ps.fig');

%% _Similarity between tuning profiles of units recorded from the same shank_
% Here I consider the response in a time window of 4 sniffs
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/sigCorr.fig');

%% _Classification accuracy at different sniffs and with different windows (number of sniffs)_
% All odors, but mixes
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/decodingByCycles.fig');

%% _Classification accuracy with concatenations of sniffs_
% All odors, but mixes
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/aPCx/decodingBinWidth.fig');

%% *Postero-lateral cortical amygdala*
% Number of responsive units: *92*
% Number of cell-odor pairs: *422*

%% _Tuning curves (auROC)_
% The response is taken over the first 4 sniffs.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/auROCtunings.fig');

%% _Grand average of olfactory responses and Fano factor_
% I used mean-matching (red, for each time bin I take only the cell-odor spike counts that don't exceed the overall firing and I regress the Fano factor), but I'm also showing spike counts and variances without mean-matching (black).
% The responses included in the left plots are aligne only to the first
% sniff.
% Note that the sub-sniff representation using a angle timescale can be
% misleading: there are of course more spikes in the exhalation phase
% because it lasts longer.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/FanoFactors.fig');

%% _Timecourse of the sistance between odors_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/distance.fig');

%% _Timecourse of the total variance explained by the first three PCs_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/threePCs.fig');

%% _Timecourse of linear classification_
% Here I aligned each sniff and the timescale is in ms and not in deg. I
% divide each sniff in two bins of 100 ms each.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/classification.fig');

%% _Timecourse of spike count distributions_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/spikeDist.fig');

%% _Timecourse of the lifetime sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/ls.fig');

%% _Timecourse of the population sparseness_
% Each row is half a sniff (100 ms). Black is odor off and red is odor on.
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/ps.fig');

%% _Similarity between tuning profiles of units recorded from the same shank_
% Here I consider the response in a time window of 4 sniffs
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/sigCorr.fig');

%% _Classification accuracy at different sniffs and with different windows (number of sniffs)_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/decodingByCycles.fig');

%% _Classification accuracy with concatenations of sniffs_
openfig('/Volumes/neurobio/DattaLab/Giuliano/tetrodes_data/aveatt&mix/plCoA/decodingBinWidth.fig');