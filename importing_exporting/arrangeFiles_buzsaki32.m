function arrangeFiles_buzsaki32
%enter numTetrodes
% options.Resize='on';
% options.WindowStyle='normal';
% options.Interpreter='tex';
% stringa=sprintf('Tetrodes');
% x = inputdlg(stringa,'How many tetrodes?',1,{''},options);
% numTetrodes = str2num(x{:});

numProbes = 32;
    
    
for i = 1 : numProbes
        
    %enter  numChannels

    numChannels = i - 1;
    fName = sprintf('tetrode%d.txt', i);
    
    fid = fopen(fName,'w');            %# Open the file
    if fid ~= -1
        for j = numChannels
            str = sprintf('CSC%d', j);
            fprintf(fid,'%s\r\n',str);       %# Print the string
        end
        fclose(fid);%# Close the file
    end
end

    
