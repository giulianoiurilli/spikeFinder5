function extractDataFromIntan_multi2

[files, path, filterindex] = uigetfile('*.rhd', 'Select the first RHD2000 Data File of your experiment', 'MultiSelect', 'on');
num_files = length(files);

SamplesAll = [];
Dig_inputsAll = [];
Acc_SamplesAll = [];
ADCAll = [];
acelleration_data = 0;

for file_n=1:num_files
    new_file = files{file_n};
    
    [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, board_dig_in_channels, board_dig_in_data, board_adc_channels, board_adc_data, frequency_parameters, t_amplifier, t_aux_input, t_dig, t_board_adc] = read_Intan_RHD2000_file_multi(new_file, path, file_n);
    
    SamplesAll = [SamplesAll amplifier_data];
    t2 = [t2 t_amplifier];
    Dig_inputsAll = [Dig_inputsAll board_dig_in_data];
    ADCAll = [ADCAll board_adc_data];
    if acelleration_data == 1
        Acc_SamplesAll = [Acc_SamplesAll aux_input_data];
        at2 = [at2 t_aux_input];
    end
end


for i = 1:size(SamplesAll,1)
    ch_name = amplifier_channels(i).native_channel_name;
    ch_num = str2num(ch_name(3:end));
    fname = sprintf('CSC%d.mat', ch_num);
    Samples = SamplesAll(i,:);
    Timestamps = t2;
    save(fname, 'Samples', 'TimeStamps', '-v7.3');
end

if acelleration_data == 1
    for i = 1:size(aux_input_data,1)
        ch_name = aux_input_channels(i).native_channel_name;
        ch_num = str2num(ch_name(6:end));
        fname = sprintf('ACC%d.mat', ch_num);
        Acc_Samples = Acc_SamplesAll(i,:);
        TimeStamps_Acc = at2;
        save(fname, 'Acc_Samples', 'TimeStamps_Acc', '-v7.3');
    end
end

for i = 1:size(board_dig_in_data,1)
    ch_name = board_dig_in_channels(i).native_channel_name;
    ch_num = str2num(ch_name(5:end));
    fname = sprintf('dig%d.mat', ch_num);
    Dig_inputs = Dig_inputsAll(i,:);
    save(fname, 'Dig_inputs', '-v7.3');
end

for i = 1:size(board_adc_data,1)
    ch_name = board_adc_channels(i).native_channel_name;
    ch_num = str2num(ch_name(5:end));
    fname = sprintf('adc%d.mat', ch_num);
    ADC = ADCAll(i,:);
    save(fname, 'ADC', '-v7.3');
    
end
            


SamplingRateAmplifier = frequency_parameters.amplifier_sample_rate;
n_channels = size(amplifier_data,1);
n_samples = length(SamplesAll);

disp('Loading done!')

fileToSave='matlabData.mat';     %stores parameters and other useful information
Timestamps = t2*1e6;    %store timestamps in microseconds
save(fileToSave,'n_channels', 'n_samples', 'SamplingRateAmplifier');

end

