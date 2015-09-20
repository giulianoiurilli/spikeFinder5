function [index,xf,thr] = index_detect_pol(x_detect, man_thr, handles)
% return the spike times within a channel

%PARAMETERS
sr=handles.sr;
w_pre=handles.w_pre;
w_post=handles.w_post;
ref=handles.ref;
detect = handles.detection;
stdmin = handles.stdmin;
stdmax = handles.stdmax;

awin = handles.awin;  

xf = x_detect;
lx=length(xf);
%clear x;

noise_std_detect = median(abs(xf))/0.6745;

thr = stdmin * noise_std_detect;        %thr for detection is based on detected settings.
thrmax = stdmax * noise_std_detect;     %thrmax for artifact removal is based on sorted settings.

% LOCATE SPIKE TIMES
switch detect
    case 'pos'
        nspk = 0;
        
        app=find(xf(w_pre+awin+2:end-w_post-awin-2) > thr) + w_pre+awin+1;
        app1=SplitVec(app,'consecutive');
        app=[];
        for j=1:length(app1)
            [maxi, iaux]=max(xf(app1{j}));                          %max((xf(xaux(i):xaux(i)+floor(ref/2)-1)));;
            
            nspk = nspk +1;
            index(nspk)= iaux + app1{j}(1) - 1;
            
        end
        
    case 'neg'
        nspk = 0;
        
        app=find(xf(w_pre+awin+2:end-w_post-awin-2) < thr) + w_pre+awin+1;
        app1=SplitVec(app,'consecutive');
        app=[];
        for j=1:length(app1)
            [maxi, iaux]=min(xf(app1{j}));
            
            nspk = nspk +1;
            index(nspk)= iaux + app1{j}(1) - 1;
            
        end
        
    case 'both'
        nspk = 0;
        
        app=find(abs(xf(w_pre+awin+2:end-w_post-awin-2)) > thr) + w_pre+awin+1;
        app1=SplitVec(app,'consecutive');
        app=[];
        for j=1:length(app1)
            [maxi, iaux]=max(xf(app1{j}));
            
            nspk = nspk +1;
            index(nspk)= iaux + app1{j}(1) - 1;
            
        end
end






% SPIKE STORING (with or without interpolation)
ls=w_pre+w_post; %length of the spike
spikes=zeros(nspk,ls+4); %add 4 more points
xf=[xf zeros(1,w_post+awin)]; %add more points just in case the last point is a spike and we have to align it
aux=[];

if man_thr == 0
    for i=1:nspk                          %Eliminates artifacts
        if max(abs( xf(index(i)-w_pre:index(i)+w_post) )) > thrmax;
            %         spikes(i,:)=xf(index(i)-w_pre-1:index(i)+w_post+2);
            aux(i)=1;
        end
    end
    
    aux = find(spikes(:,w_pre)==0);       %erases indexes that were artifacts, every spike over thrmax is erased
    spikes(aux,:)=[];
    index(find(aux==1))=[];
end