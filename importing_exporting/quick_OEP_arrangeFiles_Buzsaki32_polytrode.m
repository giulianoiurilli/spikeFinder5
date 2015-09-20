function quick_OEP_arrangeFiles_Buzsaki32_polytrode

numTetrodes = 4;

shanks = [ 30 27;...
           28 29;...
           0 8;...
           6 5];

numChannels = 2;   
    
for i = 1 : numTetrodes
        
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