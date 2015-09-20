function Lratio = L_Ratio(Fet, ClusterSpikes)


% L-ratio
% Measure of cluster quality
%
% Inputs:   Fet:           N by D array of feature vectors (N spikes, D dimensional feature space)
%           ClusterSpikes: Index into Fet which lists spikes from the cell whose quality is to be evaluated.
% Created by Ken Harris


% find # of spikes in this cluster

nSpikes = size(Fet,1);

nClusterSpikes = length(ClusterSpikes);

% mark spikes which are not cluster members
NoiseSpikes = setdiff(1:nSpikes, ClusterSpikes);

%%%%%%%%%%% compute mahalanobis distances %%%%%%%%%%%%%%%%%%%%%
if nargin < 3
	m = mahal(Fet, Fet(ClusterSpikes,:));
end

mCluster = m(ClusterSpikes); % mahal dist of spikes in the cluster
mNoise = m(NoiseSpikes); % mahal dist of all other spikes

df = size(Fet,2);

L = sum(1-chi2cdf(m(NoiseSpikes),df));
Lratio = L/nClusterSpikes;