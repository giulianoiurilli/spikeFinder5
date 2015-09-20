dfold = '\\research.files.med.harvard.edu\Neurobio\DattaLab\Giuliano\tetrodes_data\15 odors\plCoA\awake';
List = uipickfiles('FilterSpec', dfold, ...
    'Prompt',    'Pick all the folders you want to analyze');


for ii = 1 : length(List)
    folder = List{ii};
    cd(folder)
    
    load('parameters.mat')
    load('units.mat');
    
    for m = 1:1%length(shank)
        for n=1:length(shank(m).spike_matrix)
            for o = 8:odors
                try
                    trialAnalysis(m, n, o, pre, post, response_window-1);
                catch
                    errore = sprintf('error in unit %d from shank %d for odor %d', n, m, o);
                    disp(errore);
                end
            end
            
        end
    end
end