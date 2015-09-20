function s = spikeDensity(psth,sigma);

edges = [-3*sigma:0.001:3*sigma];
kernel = normpdf(edges,0,sigma);
kernel = kernel*0.001;
s = conv(psth, kernel);
center = ceil(length(edges)/2);
s(end-center+1:end) = [];
s(1:center-1) = [];
end

