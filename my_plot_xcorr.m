function my_plot_xcorr( st1, st2, RP, maxlag, bin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



conc = [st1' st2'];
N = length(conc);
T = max(conc);
[cross,lags] = pxcorr(st1,st2, round(1000/bin), maxlag);
cross0 = cross(find(lags==0));

ov = spikesOverlap(st1, st2);
%[ev,lb,ub] = rpv_contamination(N, T, RP, cross(find(lags==0)));


% c0 = zeros(1,1000);
%     for i = 1:1000
%         cperm = mod((round(st2*1000) + randi(floor(T*1000) - 2)), round(T*1000));
%         [pcross0,lags] = pxcorr(st1,cperm/1000, round(1000/bin), maxlag, 'sort');
%         c0(i) = pcross0(find(lags==0));
%     end
%     max_value = max(c0);
%     mu = mean(c0)
%     sigma = std(c0);
%     %pd = makedist('Normal',mu,sigma);
%     %h = ztest(cross0, mu, sigma, 'Alpha', 0.01);




bb = bar(lags*1000,cross,1.0); 
xlim([-5,5])
set(bb,'FaceColor',[0 0 0 ],'EdgeColor',[0 0 0])
contamination = sprintf('ci = %d - %d', round(ov/length(st1))*100, round(ov/length(st2))*100);
xlabel(contamination)
axis tight


end

