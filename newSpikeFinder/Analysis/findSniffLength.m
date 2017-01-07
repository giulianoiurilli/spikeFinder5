function sniffLength = findSniffLength(esp)


folderlist = {esp(:).filename};
sniff_length = [];
for idxExp = 1 : length(folderlist)
    folderExp = folderlist{idxExp};
    disp(folderExp)
        cd(fullfile(folderExp, 'ephys'))
%     cd(folderExp)
    load('breathing.mat', 'interInhalationDelay')
    if size(interInhalationDelay,1) > 1
        interInhalationDelay = interInhalationDelay';
    end
    sniff_length = [sniff_length interInhalationDelay];
end
sniffLength = sniff_length(sniff_length > 0 & sniff_length < 1);


