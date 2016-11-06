params.Fs = 20000;
params.fpass = [1 10];
params.tapers = [10 19];
params.trialave=1; 
params.err=[1 0.05]; 
delay_times=[0 3]; 

% datasp=extractdatapt(dsp1t,delay_times,1);
% datalfp=extractdatac(dlfp1t,params.Fs,delay_times); 





app = breath(:,1:40000,:);
datalfp = [];
for idxOdor = 1:15
    datalfp = [datalfp; app(:,:,idxOdor)];
end
datalfp = datalfp';

datasp = [];
idxT = 0;
for idxOdor = 1:15
                for idxTrial = 1:10
                    idxT = idxT + 1;
                    app = [];
                    app = shank(4).SUA.spike_matrix{12}(idxTrial,:,idxOdor);
                    app1=[];
                    app1 = find(app==1);
                    app1 = (app1./1000);
                    datasp(idxT).times = app1;
                end
end
data2=extractdatapt(datasp,delay_times);


[C,phi,S12,S1,S2,f,zerosp,confC,phistd] = coherencycpt(datalfp,data2,params);