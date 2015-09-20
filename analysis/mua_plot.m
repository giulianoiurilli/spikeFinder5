 close all
load('breathing.mat');
load('units.mat');
load('parameters.mat');

mua = zeros(odors,length(shank(1).sdf_trial{1}(1,:,1)));
n_trials = 5;
t_axis = -pre:1/1000:post; t_axis(end-1:end)=[];

kk = 1;
figure
for k = 1:odors 
for sha = 1:4
    for s = 1:length(shank(sha).spiketimesUnit)
          %cycles through odors
          for i =1:n_trials
                mua(k,:) = mua(k,:) + shank(sha).sdf_trial{s}(i,:,k);
          end
        
    end
end

subplot(odors,2,kk);
plot(t_axis,mua(k,:),'r'); axis tight;
kk = kk+1;

end