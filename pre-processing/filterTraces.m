function filterTraces( tetrodes, HighPass1, LowPass1, varargin )
    %Filters the raw trace with a custom designed Butterworth band-pass
    %filter. 
    %
 
    tic
    
    %load('matlabData.mat');
    
    %Fs = sr;
    Fs = 20000;
    
    if nargin<2
        HighPass1 = 700; 
        LowPass1 = 8000;
        %HighPass2 = 500;
        %LowPass2 = 5000;
    end
    
    %Load in filter
    
    Wp = [ HighPass1 LowPass1] * 2 / Fs; % pass band for filtering
    Ws = [ 500 9950] * 2 / Fs; %transition zone
    [N,Wn] = buttord( Wp, Ws, 3, 20); % determine filter parameters 
    [B,A] = butter(N,Wn); % builds filter
    
    
    
    

    
    
    disp('-----------------------------------------------------------')
    disp('## Starting band-pass filtering of all channels')
    disp(['Filter 1: ' num2str(HighPass1) ' - ' num2str(LowPass1) ' Hz'])
    %disp(['Filter 2: ' num2str(HighPass2) ' - ' num2str(LowPass2) ' Hz'])
    
    

    
    for k=1:length(tetrodes)
        tetrode = tetrodes(k);
        % LOAD TETRODE CHANNELS
        pol = strcat('tetrode',num2str(tetrode),'.txt');
        channels = textread(pol,'%s');
        
        for i=1:length(channels)
            file_to_cluster = channels(i);
            disp('-----------------------------------------------------------')
            string = sprintf('Filtering channel %s', file_to_cluster{1}(4:end));
            disp(string)
            sample = load (sprintf('%s',channels{i}));
            %Apply the filter once in the forward direction and once in the
            %backward direction using filtfilt so there is no phase shift
            %FiltSamples1 = FiltFiltM(B, A, sample.Samples);   
            FiltSamples1 = filtfilt(B, A, sample.Samples);
            RawSamples = sample.Samples;
            %Save output
            
            fileToSave = sprintf('CSC%d.mat', str2num(channels{i}(4:end)));
            save( fileToSave, 'FiltSamples1');
            save( fileToSave, 'RawSamples', '-append');
            %save( fileToSave, 'FiltSamples1', 'FiltSamples2'); %no necessity to -append and store the unfiltered Samples
            disp('Filtering done!')
        end
    end
    

toc
      


        

