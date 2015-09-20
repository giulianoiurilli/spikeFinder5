function arrangeFiles_Buzsaki32_polytrode
%enter numTetrodes
% options.Resize='on';
% options.WindowStyle='normal';
% options.Interpreter='tex';
% stringa=sprintf('Tetrodes');
% x = inputdlg(stringa,'How many tetrodes?',1,{''},options);
numTetrodes = 4;

shanks = [ 30 26 21 17 27 22 20 25;...
           28 23 19 24 29 18 31 16;...
           0 15 2 13 8 9 7 1;...
           6 14 10 11 5 12 4 3];

numChannels = 8;   
    
for i = 1 : numTetrodes
        
    %enter  numChannels
%     options.Resize='on';
%     options.WindowStyle='normal';
%     options.Interpreter='tex';
%     stringa=sprintf('Channels?');
%     x = inputdlg(stringa,'Enter space-separated channel numbers?',1,{''},options);
%     numChannels = str2num(x{:}); 
    fName = sprintf('tetrode%d.txt', i);
    
    fid = fopen(fName,'w');            %# Open the file
    if fid ~= -1
        for j = 1:numChannels
            str = sprintf('CSC%d', shanks(i,j));
            fprintf(fid,'%s\r\n',str);       %# Print the string
        end
        fclose(fid);%# Close the file
    end
end