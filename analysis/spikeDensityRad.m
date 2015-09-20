function s = spikeDensityRad(psth,sigma);

edges = [-3*sigma:3*sigma];
kernel = normpdf(edges,0,sigma);
%kernel = kernel;
s = conv(psth, kernel);
center = ceil(length(edges)/2);
s(end-center+1:end) = [];
s(1:center-1) = [];
end

