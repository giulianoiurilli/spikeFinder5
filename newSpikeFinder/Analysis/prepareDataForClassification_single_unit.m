function prepareDataForClassification_single_unit(esp, nOdors, folder)

currentFolder = pwd;

idxCell = 0;
for idxExp = 1:length(esp)
    cd(fullfile((esp(idxExp).filename), 'ephys'))
    disp(esp(idxExp).filename)
    load('units.mat')
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.1
                    app = zeros(1,15);
                    for idxOdor = 1:nOdors                
                        %app(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        app(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(app) > 0
                        idxCell = idxCell + 1;
                        raster_data = [];
                        idxT = 0;
                        for idxOdor = 1:nOdors
                            app = double(shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor));
                            raster_data = [raster_data; app];
                            for idxTrial = 1:10
                                idxT = idxT + 1;
                                raster_labels.stimulusID{idxT} = num2str(idxOdor);
                            end
                        end
                        raster_site_info = [];
                        filename = sprintf('rasters_cell_%d.mat', 1);
                        s = sprintf('%d', idxCell);
                        stringa = [folder s];
                        mkdir(fullfile(currentFolder, stringa))
                        cd(fullfile(currentFolder, stringa))
                        save(filename, 'raster_data', 'raster_labels', 'raster_site_info');
                        cd(currentFolder)
                    end
                end
            end
        end
    end
end
cd(currentFolder)

