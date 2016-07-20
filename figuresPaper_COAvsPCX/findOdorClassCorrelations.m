function [a, b, ar, br] = findOdorClassCorrelations(esp, odors, option)


% esp = pcx15.esp;
% odors = 1:15;

odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
baselineCell1Mean = [];
responseCell1All = [];
responseCell1MeanSignificant = [];
baselineCell1MeanSignificant = [];
idxCell1 = 0;
idxCell2 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                app3 = [];
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    app3(idxO) = ~(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms==0); 
                end
                if sum(app3) > 0
                    idxCell2 = idxCell2 + 1;
                    responseCell1MeanSignificant(idxCell2,:) = responseCell1Mean(idxCell1,:);
                end
            end
        end
    end
end


R = responseCell1Mean';
R = zscore(R);
Rs = responseCell1MeanSignificant';
Rs = zscore(Rs);

if option == 1
    a = nan(3,3,5);
    a(:,:,1) = corr(R(:,1:3));
    a(:,:,2) = corr(R(:,4:6));
    a(:,:,3) = corr(R(:,7:9));
    a(:,:,4) = corr(R(:,10:12));
    a(:,:,5) = corr(R(:,13:15));
    
    
    b = nan(3,3,10);
    b(:,:,1) = corr(R(:,1:3), R(:,4:6));
    b(:,:,2) = corr(R(:,1:3), R(:,7:9));
    b(:,:,3) = corr(R(:,1:3), R(:,10:12));
    b(:,:,4) = corr(R(:,1:3), R(:,13:15));
    b(:,:,5) = corr(R(:,4:6), R(:,7:9));
    b(:,:,6) = corr(R(:,4:6), R(:,10:12));
    b(:,:,7) = corr(R(:,4:6), R(:,13:15));
    b(:,:,8) = corr(R(:,7:9), R(:,10:12));
    b(:,:,9) = corr(R(:,7:9), R(:,13:15));
    b(:,:,10) = corr(R(:,10:12), R(:,13:15));
    
    
    ar = nan(3,3,5);
    ar(:,:,1) = corr(R(:,1:3));
    ar(:,:,2) = corr(R(:,4:6));
    ar(:,:,3) = corr(R(:,7:9));
    ar(:,:,4) = corr(R(:,10:12));
    ar(:,:,5) = corr(R(:,13:15));
    
    
    br = nan(3,3,10);
    br(:,:,1) = corr(R(:,1:3), R(:,4:6));
    br(:,:,2) = corr(R(:,1:3), R(:,7:9));
    br(:,:,3) = corr(R(:,1:3), R(:,10:12));
    br(:,:,4) = corr(R(:,1:3), R(:,13:15));
    br(:,:,5) = corr(R(:,4:6), R(:,7:9));
    br(:,:,6) = corr(R(:,4:6), R(:,10:12));
    br(:,:,7) = corr(R(:,4:6), R(:,13:15));
    br(:,:,8) = corr(R(:,7:9), R(:,10:12));
    br(:,:,9) = corr(R(:,7:9), R(:,13:15));
    br(:,:,10) = corr(R(:,10:12), R(:,13:15));
    
else
    a = nan(5,5,2);
    a(:,:,1) = corr(R(:,1:5));
    a(:,:,2) = corr(R(:,6:10));
    
    
    b = nan(5);
    b = corr(R(:,1:5), R(:,6:10));

    
    
    ar = nan(5,5,2);
    ar(:,:,1) = corr(R(:,1:5));
    ar(:,:,2) = corr(R(:,6:10));

    
    
    br = nan(5);
    br(:,:) = corr(R(:,1:5), R(:,6:10));
end








