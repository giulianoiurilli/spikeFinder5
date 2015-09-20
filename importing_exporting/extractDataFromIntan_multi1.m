function extractDataFromIntan_multi1

%global amplifier_data

accel_data = 0;
digital_in = 1;
adc = 1;

import_opt = [accel_data digital_in adc];

opt1 = [0 0 0];
opt2 = [1 0 0];
opt3 = [0 1 0];
opt4 = [0 0 1];
opt5 = [1 1 0];
opt6 = [0 1 1];
opt7 = [1 0 1];
opt8 = [1 1 1];



[files, path, filterindex] = uigetfile('*.rhd', 'Select the first RHD2000 Data File of your experiment', 'MultiSelect', 'on');
num_files = length(files);

Samples = [];
Dig_inputs = [];
Acc_Samples = [];




for file_n=1:num_files
    
    
    
    
    new_file = files{file_n};
    
    [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, board_dig_in_channels, board_dig_in_data, board_adc_channels, board_adc_data, frequency_parameters, t_amplifier, t_aux_input, t_dig, t_board_adc] = read_Intan_RHD2000_file_multi(new_file, path, file_n);
    
    
    
%     if isequal(import_opt, opt1)
%         [amplifier_channels, amplifier_data, frequency_parameters, t_amplifier, t_aux_input] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     if isequal(import_opt, opt2)
%         [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, frequency_parameters, t_amplifier, t_aux_input] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     if isequal(import_opt, opt3)
%         [amplifier_channels, amplifier_data,  board_dig_in_channels, board_dig_in_data, frequency_parameters, t_amplifier, t_dig] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     if isequal(import_opt, opt4)
%         [amplifier_channels, amplifier_data,  board_adc_channels, board_adc_data, frequency_parameters, t_amplifier, t_board_adc] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     
%     if isequal(import_opt, opt5)
%         [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, board_dig_in_channels, board_dig_in_data, frequency_parameters, t_amplifier, t_aux_input, t_dig] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     if isequal(import_opt, opt6)
%       [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data,  board_dig_in_channels, board_dig_in_data, board_adc_channels, board_adc_data, frequency_parameters, t_amplifier, t_aux_input, t_dig, t_board_adc] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     if isequal(import_opt, opt7)
%         [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, board_adc_channels, board_adc_data, frequency_parameters, t_amplifier, t_aux_input, t_board_adc] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
%     if isequal(import_opt, opt7)
%         [amplifier_channels, amplifier_data, aux_input_channels, aux_input_data, board_dig_in_channels, board_dig_in_data, board_adc_channels, board_adc_data, frequency_parameters, t_amplifier, t_aux_input, t_dig, t_board_adc] = read_Intan_RHD2000_file_multi(new_file, path, file_n); %does not save anything.
%     end
    
    
        
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
        
        save(fname, 'Samples', 't2', '-v7.3');
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
            
            save(fname, 'Acc_Samples', 'at2', '-v7.3');
        end
    end
    
    if digital_in == 1
        
        for i = 1:size(board_dig_in_data,1)
            ch_name = board_dig_in_channels(i).native_channel_name;
            ch_num = str2num(ch_name(5:end));
            fname = sprintf('dig%d.mat', ch_num);
            
            if file_n > 1
                load(fname);
                Dig_inputs = [Dig_inputs board_dig_in_data(i,:)];
            else
                Dig_inputs = board_dig_in_data(i,:);
            end
            save(fname, 'Dig_inputs', '-v7.3');
            %end
        end
    end
    
    
    
    
    if adc == 1
        
        for i = 1:size(board_adc_data,1)
            ch_name = board_adc_channels(i).native_channel_name;
            ch_num = str2num(ch_name(5:end));
            fname = sprintf('adc%d.mat', ch_num);
            
            if file_n > 1
                load(fname);
                ADC = [ADC board_adc_data(i,:)];
            else
                ADC = board_adc_data(i,:);
            end
            save(fname, 'ADC', '-v7.3');
            %end
        end
        
    end
    
    
    
    
    
end

sr = frequency_parameters.amplifier_sample_rate;

n_traces = size(amplifier_data,1);
n_samples = length(Samples);

disp('Loading done!')


% options.Resize='on';
% options.WindowStyle='normal';
% options.Interpreter='tex';
% stringa=sprintf('Tetrodes');
% x = inputdlg(stringa,'How many tetrodes?',1,{''},options);
% numTetrodes = str2num(x{:});
% disp('How many tetrodes?')
numTetrodes = 4;
 tetrodes = 1:numTetrodes;
%tetrodes=1:32;


fileToSave='matlabData.mat';     %stores parameters and other useful information
Timestamps = t2*1e6;    %store timestamps in microseconds
save(fileToSave, 'Timestamps', 'n_traces', 'n_samples', 'tetrodes','sr','-v7.3');
save('tetrodes.mat', 'tetrodes');


end

