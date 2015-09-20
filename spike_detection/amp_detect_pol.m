function [spikes,index] = amp_detect_pol(x_detect, art, man_thr, handles)
%detect spikes in a tetrode

%PARAMETERS
sr = handles.sr; 
w_pre = handles.w_pre;
w_post = handles.w_post;
ref = handles.ref; % refractory period (value in counts)
detect = handles.detection;
stdmin = handles.stdmin;
stdmax = handles.stdmax;

awin = handles.awin;  

spikes = [];

% SPIKE DETECTION FOR EACH CHANNEL
% Detects all spike times including all channels
% there will be spike times very close
% probably belonged to the same spike at 
% different channels. 
index = [];
for i=1:size(x_detect,1)
   [indexch,xf(i,:),thr(i)] = index_detect(x_detect(i,:), man_thr, handles); % spike times 
   index = [index indexch];
   clear indexch;
end

% ALIGNMENT OF THE TETRODE CHANNELS
% Only spike times separated more than the refractory period 
% will be taken. The minimum distance between two 
% different spikes allowed by the detection algorithm 
% is the refractory period 
index = sort(index);
index( find(abs(diff(index))<ref/2) ) = []; 



% SPIKE CONCATENATION: POLY-SPIKE
for i=1:length(index)
    for j=1:size(x_detect,1)
        spikes(i,1+(j-1)*(w_pre+w_post+2*awin):j*(w_pre+w_post+2*awin)) = xf(j,index(i)-w_pre-awin+1:index(i)+w_post+awin);
    end
end

% POLY-SPIKE INTERPOLATION
% interpolation and downsampling is done separately in every channel within
% each poly-spike which does the interchannel alignment
if ~isempty(spikes)
    switch handles.interpolation
        case 'n'
            spikes(:,end-1:end)=[];       %eliminates borders that were introduced for interpolation
            spikes(:,1:2)=[];
        case 'y'
            %Does interpolation
            spikes = int_spikes_pol(spikes,size(x_detect,1),thr,handles);
    end
end
if man_thr == 1
    for i = 1:size(spikes,1)       %get rid of large artifacts
        g(i) = sum(abs(spikes(i,:))>=art) >0;
    end
    spikes(find(g==1),:) = [];
end









    