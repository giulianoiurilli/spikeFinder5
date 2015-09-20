
%% Loading and conversion from voltage signal to acceleration
%close all
%clear all

for k = 1:3
    string = sprintf('ACC%d.mat', k);
    load(string);
    acc(k,:) = Acc_Samples;
end


bias = [1.7265; 1.7104; 1.8183];
sensitivity= [-0.0351; 0.0351; -0.0354];
                                        

acc = bsxfun(@minus, acc, bias);
acc = bsxfun(@rdivide, acc, sensitivity);
acc = acc .*100;

Fs = 5000;


HighPass1 = 0.01;
LowPass1 = 20;



%Load in filter

Wp = [ HighPass1 LowPass1] * 2 / Fs; % pass band for filtering

[B,A] = butter(2 ,Wp); % builds filter


acc_smooth = [];
acc(1,:) = filtfilt(B, A, acc(1,:));
acc_smooth(1,:)=smooth(acc(1,:)',5000);
acc(2,:) = filtfilt(B, A, acc(2,:));
acc_smooth(2,:)=smooth(acc(2,:)',5000);
acc(3,:) = filtfilt(B, A, acc(3,:));
acc_smooth(3,:)=smooth(acc(3,:)',5000);





%% Acceleration Map

% for k = 1:3                                                                 %Sub-sample to 20 Hz
%     acc_sub(k,:) = resampling(acc(k,:), 5000, 20, 1, 0, 0);
% end
% 
% acc_sub = acc_sub';
for k = 1:3                                                                 %Up-sample to 20 kHz 
    app_acc_up(k,:) = resampling(acc(k,:), 5000, 20000, 1, 0, 0);
    acc_up(k,:) = [app_acc_up(k,:) 0];
    %Save last 20 seconds for reshuffling
    %acc_up_short(k,:) = acc_up(k,(acc_up(k,:) < (end - 400000)));
end




acc_sub = acc_up';


edges{1} = [-600:10:600 ];
edges{2} = [-600:10:600 ];

x_y_map = hist3(acc_sub(:,[1 2]), 'Edges', edges);                          %Bin to generate acceleration maps
x_z_map = hist3(acc_sub(:,[1 3]), 'Edges', edges);
y_z_map = hist3(acc_sub(:,[2 3]), 'Edges', edges);

h = fspecial('gaussian');                                                   %Create 2D, 3x3 gaussian filter

x_y_map_f = filter2(h, x_y_map);
figure(1); imagesc(edges{1}, edges{2}, x_y_map);    %Smooth acceleration maps
x_z_map_f = filter2(h, x_z_map);
figure(2); imagesc(edges{1}, edges{2}, x_z_map);
y_z_map_f = filter2(h, y_z_map);
figure(3); imagesc(edges{1}, edges{2}, y_z_map);


fileToSave='accData.mat';     %stores parameters and other useful information
 
save(fileToSave, 'acc', 'acc_up', 'x_y_map', 'x_z_map','y_z_map', 'x_y_map_f', 'x_z_map_f','y_z_map_f', 'edges', 'h', '-v7.3');