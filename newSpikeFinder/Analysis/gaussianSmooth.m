function s = gaussianSmooth(dist, sigma)




interp_factor = 100;
dist = interp(dist,interp_factor);
edges = -2*sigma:0.001:2*sigma;
kernel = normpdf(edges,0,sigma);
kernel = kernel*0.001;
s = conv(dist, kernel);
center = ceil(length(edges)/2);
s(end-center+1:end) = [];
s(1:center-1) = [];
end