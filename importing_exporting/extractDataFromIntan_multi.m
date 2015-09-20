

function extractDataFromIntan_multi

%global amplifier_data

accel_data = 0;

[files, path, filterindex] = uigetfile('*.rhd', 'Select the first RHD2000 Data File of your experiment', 'MultiSelect', 'on');
num_files = length(files);

Samples = [];
Acc_Samples = [];


h = waitbar(0,'Progress')

for file_n=1:num_files
    
        

    waitbar(1/num_files)

    
    new_file = files{file_n};
    
    
    
    
    
    [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, frequency_parameters, t_amplifier, t_aux_input] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
    % fileToSave='matlabData.mat';
    % save(fileToSave,'amplifier_channels','-v7.3');
    %make_CSC
    
    
    
    for i = 1:size(amplifier_data,1)
        ch_name = amplifier_channels(i).native_channel_name;
        ch_num = str2num(ch_name(3:end));
        fname = sprintf('CSC%d.mat', ch_num);
        
        if file_n > 1
            load(fname);
            Samples = [Samples amplifier_data(i,:)];
            t2 = [t2 t_amplifier];
        else
            Samples = amplifier_data(i,:);
            t2 = t_amplifier;
        end
        
        save(fname, 'Samples', '-v7.3');
    end
    
    if accel_data == 1
       for i = 1:size(aux_input_data,1)
        ch_name = aux_input_channels(i).native_channel_name;
        ch_num = str2num(ch_name(6:end));
        fname = sprintf('ACC%d.mat', ch_num);
        
        if file_n > 1
            load(fname);
            Acc_Samples = [Acc_Samples aux_input_data(i,:)];
            at2 = [at2 t_aux_input];
        else
            Acc_Samples = aux_input_data(i,:);
            at2 = t_aux_input;
        end
        
        save(fname, 'Acc_Samples', '-v7.3');
       end
    end
    
end


close(h);




sr = frequency_parameters.amplifier_sample_rate;

n_traces = size(amplifier_data,1);
n_samples = length(Samples);

options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
stringa=sprintf('Tetrodes');
x = inputdlg(stringa,'How many tetrodes?',1,{''},options);
numTetrodes = str2num(x{:});

tetrodes = 1:1:numTetrodes;

fileToSave='matlabData.mat';     %stores parameters and other useful information
Timestamps = t2*1e6;    %store timestamps in microseconds
save(fileToSave, 'Timestamps', 'n_traces', 'n_samples', 'tetrodes','sr','-v7.3');

end