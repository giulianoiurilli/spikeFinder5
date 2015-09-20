function getSpikes(tetrodes)






load('matlabData.mat');

% PARAMETERS

%handles.detection = 'both';                        %type of threshold (default 'pos')
%handles.par.detection = 'pos';              
handles.detection = 'neg';
handles.stdmin = 5;                                 %minimum threshold (default 5)
handles.stdmax = 20;                                %maximum threshold (default 50)
handles.interpolation = 'y';                        %interpolation for alignment (default 'y')
handles.int_factor = 2;                             %interpolation factor (default 2)
handles.segments = 10;                              %length of segments in which the data is cutted                      
handles.sr = sr;                                    %sampling rate (Hz)
swl = 1.6;                                          %spike window length in ms
ls = (swl/1000)*handles.sr;
handles.w_pre = round(ls/3);                        %number of pre-event data points stored 
handles.w_post = ls - handles.w_pre;                %number of post-event data points stored 
min_ref_per = 1.5;                                  %minimum refractory period (in ms)
handles.ref = floor(min_ref_per *handles.sr/1000);  %number of counts corresponding the minimum refractory period
handles.awin = 8; % alignment window

ref = handles.ref;
sr = handles.sr;

man_thr = 0;                                        %manual thresholding




for k=1:length(tetrodes)
    
    tetrode = tetrodes(k);
    
    % LOAD TETRODE CHANNELS
    pol = strcat('tetrode',num2str(tetrode),'.txt');
    
    channels = textread(pol,'%s');
    %filename = channels(1);
    %filename = cell2mat(filename);
    filename = strcat(pol(1:end-4));
    
    artifact_thr = [];
     
    if man_thr == 1
        
        for i=1:length(channels)
            sample = load (sprintf('%s',channels{i}));
            FIG = figure;
            plot(sample.FiltSamples1), grid on, axis tight;
            h=helpdlg('Select threshold for artifacts','Artifacts');
            uiwait(h);
            [x, y_thr]=ginput(1);
            artifact_thr(i) = abs(y_thr);
            close(FIG)
        end
        
    else
        artifact_thr = inf;
        
    end
    
    
    index_all = [];
    spikes_all = [];
    for j=1:handles.segments        %that's for cutting the data into pieces
        
        h1 = waitbar(0,'Please wait...');
        for i=1:100, 
            waitbar(i/handles.segments)
        end
        
        poly_spikes = [];
        for i=1:length(channels)
            % LOAD CONTINUOUS DATA
            file_to_cluster = channels(i);
            sample = load (sprintf('%s',channels{i}));      
            tsmin = (j-1)*floor(length(sample.FiltSamples1)/handles.segments)+1;
            tsmax = j*floor(length(sample.FiltSamples1)/handles.segments);
            x_detect(i,:)=sample.FiltSamples1(tsmin:tsmax); %clear FiltSamples1;
            x_detect = double(x_detect);
            
        end
        % SPIKE DETECTION WITH AMPLITUDE THRESHOLDING
        [spikes, index] = amp_detect_pol(x_detect, max(artifact_thr), man_thr, handles); clear x_detect; clear x_sort;
        
        % JOIN SEGMENTS
        index=(index+tsmin)*1e6/sr;
        index_all = [index_all index]; clear index;
        if ~isempty(spikes)
            for i=1:size(channels,1)
                poly_spikes = [poly_spikes spikes(:,1+(i-1)*ls:i*ls)];
            end
            spikes_all = [spikes_all; poly_spikes];
        end
    end
    clear spikes;
    clear poly_spikes;
    index = index_all; %/1000; % time in msecs
    
    spikes = zeros(size(spikes_all,1),size(spikes_all,2));
    spikes = spikes_all;
    clear spikes_all;
    
    outfile = strcat(filename,'_spikes');
    save(outfile, 'spikes', 'index')
    clear spikes;
    
    close all
    
end





