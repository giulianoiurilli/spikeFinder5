clear all
for k = 1:3
    string = sprintf('ACC%d.mat', k);
    load(string);
    acc(k,:) = Acc_Samples;
    
end


Fs = 5000;


HighPass1 = 0.01;
LowPass1 = 20;



%Load in filter

Wp = [ HighPass1 LowPass1] * 2 / Fs; % pass band for filtering

[B,A] = butter(2 ,Wp); % builds filter

acc_s = zeros(3,size(acc,2));

acc(1,:) = filtfilt(B, A, acc(1,:)); acc_s(1,:) = smooth(acc(1,:), 199);
acc(2,:) = filtfilt(B, A, acc(2,:));acc_s(2,:) = smooth(acc(2,:), 199);
acc(3,:) = filtfilt(B, A, acc(3,:));acc_s(3,:) = smooth(acc(3,:), 199);

E = zeros(size(acc_s,2), 200);


    E = acc_s' * normrnd(0,1,3,200);
%     E(:,i) = acc_s' * (2*rand(3,1) - 1);

e1 = E';
clear E;
clear acc;
clear acc_s;
figure
imagesc(e1(:,1:500000))
colormap('bone')
