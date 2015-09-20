function spike_breathing_phase(c,e,sha,s,k)
% sha=3;
% s=4;
% k=7;
cd(c);
load('parameters.mat');
load('units.mat');
load('breathing.mat');
    
% sua = shank(sha).spiketimesUnit{s};
% sua=sua';
% 
% for i = 1:n_trials     %cycles through trials
%     sua_trial{i} = sua(find((sua > sec_on_rsp(i,k) - pre) & (sua < sec_on_rsp(i,k) + post))) - sec_on_rsp(i,k);
% end

%figure

X = breath(:,:,k);
y = hilbert(X');
sigphase1 = angle(y);
time = -pre:1/20000:post;
time(end) = [];
% for i = 1:10 %n_trials
%     %subplot(2,1,i)
%     subplot(5,2,i)
%     color_line(time,X(i,:),sigphase(:,i)');
%     hold on
%     t=[];
%     t = sua_trial{i}; %shank(sha).spike_matrix{u}(i,:,k);
%     for rr = 1:length(t)
%         
%         line([t(rr) t(rr)] , [-1 1], 'Color',[.9 .9 .9])
%         
%         
%     end
%     % plot(time,sigphase(:,i)')
%     hold off
%     xlim([-1 3]) 
%     
% end



spikes = shank(sha).spike_matrix{s}(:,:,k);

fig = sprintf('exp %d - shank %d - unit %d - odor %d', e, sha, s, k);
h=figure('Name',fig, 'NumberTitle','off');
hold on
for kkk = 1:10
    app_sigphase = [];
    app_sigphase = sigphase1(:,kkk)';
    sp_times = [];
    sp_times = find(spikes(kkk,:)==1);
    spike_phase = [];
    spike_phase = app_sigphase(sp_times);
    plot(sp_times, spike_phase, 'o')
end
axis([0 7000 -3.14 3.14]);

pos=[2000 -3.14 2000 6.28]; 
% a grey box with no edge
h1=rectangle('pos',pos,'edgecolor','k');

hold off


% ass = [];
% for i = 1:n_trials
%     t = sua_trial{i};
%     t(find(t<0)) = [];
%     t(find(t>2)) = [];
%     aff = sigphase(floor((t+2)*20000),i)';
%     ass = [ass aff];
% end
% 
% figure
% rose(ass,10)
% 
% 
% 
% app1 = sigphase(pre*200000:end,i);
% [m n] = min(app1,2);
