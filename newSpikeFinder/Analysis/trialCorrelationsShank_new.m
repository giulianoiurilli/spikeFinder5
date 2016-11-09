%function [noiseCorr1000ms, noiseNCorr1000ms] = trialCorrelationsShank_new(esp, odors)

esp = pcx.esp;
odors = 1:6;

odorsRearranged = odors;
odors = length(odorsRearranged);
n_trials = 10;

%%
idxCell1 = zeros(length(esp),4);
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
%                     resp = zeros(1,odors);
%                     for idxOdor = 1:odors
%                         resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
%                         %resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
%                     end
%                     if sum(resp)>0
%                         idxCell1(idxExp, idxShank) = idxCell1(idxExp, idxShank) + 1;
%                     end
                    idxCell1(idxExp, idxShank) = idxCell1(idxExp, idxShank) + 1;
                end
            end
        end
    end
end

%% 1000 ms
% for idxShank = 1:4
%         noiseCorr1000ms(idxShank).exp = [];
%     noiseCorr1000ms(idxShank).exp = [];
%     noiseCorr1000ms(idxShank).exp = [];
%     noiseCorr1000ms(idxShank).exp = [];
%
%     noiseNCorr1000ms(idxShank).exp = [];
%     noiseNCorr1000ms(idxShank).exp = [];
%     noiseNCorr1000ms(idxShank).exp = [];
%     noiseNCorr1000ms(idxShank).exp = [];
% end
%%
noiseCorr_0_1000ms = [];
noiseCorr_1_1000ms = [];
noiseCorr_2_1000ms = [];
noiseCorr_3_1000ms = [];
noiseNCorr_0_1000ms = [];
noiseNCorr_1_1000ms = [];
noiseNCorr_2_1000ms = [];
noiseNCorr_3_1000ms = [];
signalCorr_0_1000ms = [];
signalCorr_1_1000ms = [];
signalCorr_2_1000ms = [];
signalCorr_3_1000ms = [];
tuningCell1000ms =[];
noiseCell1000ms=[];
signalCell1000ms=[];
for idxExp = 1: length(esp)
    
    for idxShank = 1:4
        tuningCell1000ms(idxShank).shank = nan(idxCell1(idxExp, idxShank),10,numel(odors));
        noiseCell1000ms(idxShank).shank = nan(idxCell1(idxExp, idxShank),10,numel(odors));
        signalCell1000ms(idxShank).shank = nan(idxCell1(idxExp, idxShank),numel(odors));
        idxCell1000ms = 0;
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
%                     resp = zeros(1,odors);
%                     for idxOdor = 1:odors
%                         resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
%                         %resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
%                     end
%                     if sum(resp)>0
                        idxCell1000ms = idxCell1000ms + 1;
                        idxO = 0;
                        app = nan(10,numel(odors));
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms' -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                        end
                        app = nanmean(app);
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            tuningCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                            %                     try
                            noiseCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                repmat(app(idxO), 1, 10);
                            signalCell1000ms(idxShank).shank(idxCell1000ms,idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            %                     catch ME2
                            %                     end
                        end
%                     end
                end
            end
            if size(tuningCell1000ms(idxShank).shank,1) > 0
                tuningCell1000ms(idxShank).shank = reshape(tuningCell1000ms(idxShank).shank, size(tuningCell1000ms(idxShank).shank,1), n_trials * odors);
                tuningCell1000ms(idxShank).shank = tuningCell1000ms(idxShank).shank';
                tuningCell1000ms(idxShank).shank = zscore(tuningCell1000ms(idxShank).shank);
                tuningCell1000ms(idxShank).shank = tuningCell1000ms(idxShank).shank';
                noiseCell1000ms(idxShank).shank = reshape(noiseCell1000ms(idxShank).shank, size(noiseCell1000ms(idxShank).shank,1), n_trials * odors);
                noiseCell1000ms(idxShank).shank = noiseCell1000ms(idxShank).shank';
                noiseCell1000ms(idxShank).shank = zscore(noiseCell1000ms(idxShank).shank);
                noiseCell1000ms(idxShank).shank = noiseCell1000ms(idxShank).shank';
                signalCell1000ms(idxShank).shank = signalCell1000ms(idxShank).shank';
                signalCell1000ms(idxShank).shank = zscore(signalCell1000ms(idxShank).shank);
                if size(tuningCell1000ms(idxShank).shank,1) > 1
                    
                    rho = [];
                    rho = pdist(tuningCell1000ms(idxShank).shank, 'correlation');
                    rho = 1 - rho;
                    noiseCorr_0_1000ms = [noiseCorr_0_1000ms rho];
                    
                    
                    rho = [];
                    rho = pdist(noiseCell1000ms(idxShank).shank, 'correlation');
                    rho = 1 - rho;
                    noiseNCorr_0_1000ms = [noiseNCorr_0_1000ms rho];
                    
                    
                    rho = [];
                    rho = pdist(signalCell1000ms(idxShank).shank, 'correlation');
                    rho = 1 - rho;
                    signalCorr_0_1000ms = rho;
                    if signalCell1000ms(idxShank).shank > 1
                    signalCell1000ms(idxShank).shank = signalCell1000ms(idxShank).shank';
                    end
                end
            end
        end
    end
    
    %%
    for probe = 1:3
        next = probe+1;
        if (size(tuningCell1000ms(probe).shank,1) > 0) && (size(tuningCell1000ms(next).shank,1) > 0)
            app = corr(squeeze(tuningCell1000ms(probe).shank)', squeeze(tuningCell1000ms(next).shank)');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_1_1000ms = [noiseCorr_1_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_1_1000ms = [noiseCorr_1_1000ms apppp(:)'];
        end
        if (size(noiseCell1000ms(probe).shank,1) > 0) && (size(noiseCell1000ms(next).shank,1) > 0)
            app = corr(squeeze(noiseCell1000ms(probe).shank)', squeeze(noiseCell1000ms(next).shank)');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseNCorr_1_1000ms = [noiseNCorr_1_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseNCorr_1_1000ms = [noiseNCorr_1_1000ms apppp(:)'];
        end
        if (size(signalCell1000ms(probe).shank,1) > 0) && (size(signalCell1000ms(next).shank,1) > 0)
            app = corr(signalCell1000ms(probe).shank, signalCell1000ms(next).shank);
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            signalCorr_1_1000ms = [signalCorr_1_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            signalCorr_1_1000ms = [signalCorr_1_1000ms apppp(:)'];
        end
    end
    
    for probe = 1:2
        next = probe+2;
        if (size(tuningCell1000ms(probe).shank,1) > 0) && (size(tuningCell1000ms(next).shank,1) > 0)
            app = corr(squeeze(tuningCell1000ms(probe).shank)', squeeze(tuningCell1000ms(next).shank)');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_2_1000ms = [noiseCorr_2_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_2_1000ms = [noiseCorr_2_1000ms apppp(:)'];
        end
        if (size(noiseCell1000ms(probe).shank,1) > 0) && (size(noiseCell1000ms(next).shank,1) > 0)
            app = corr(squeeze(noiseCell1000ms(probe).shank)', squeeze(noiseCell1000ms(next).shank)');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseNCorr_2_1000ms = [noiseNCorr_2_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseNCorr_2_1000ms = [noiseNCorr_2_1000ms apppp(:)'];
        end
        if (size(signalCell1000ms(probe).shank,1) > 0) && (size(signalCell1000ms(next).shank,1) > 0)
            app = corr(signalCell1000ms(probe).shank, signalCell1000ms(next).shank);
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            signalCorr_2_1000ms = [signalCorr_2_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            signalCorr_2_1000ms = [signalCorr_2_1000ms apppp(:)'];
        end
    end
    
    probe = 1;
    next = 4;
    if (size(tuningCell1000ms(probe).shank,1) > 0) && (size(tuningCell1000ms(next).shank,1) > 0)
        app = corr(squeeze(tuningCell1000ms(probe).shank)', squeeze(tuningCell1000ms(next).shank)');
        index = find(triu(ones(size(app))));
        appp = app(index);
        apppp = appp(~isnan(appp));
        noiseCorr_3_1000ms = [noiseCorr_3_1000ms apppp(:)'];
        clear app
        clear appp
        clear apppp
        clear index
    else
        apppp = [];
        noiseCorr_3_1000ms = [noiseCorr_3_1000ms apppp(:)'];
    end
    if (size(noiseCell1000ms(probe).shank,1) > 0) && (size(noiseCell1000ms(next).shank,1) > 0)
        app = corr(squeeze(noiseCell1000ms(probe).shank)', squeeze(noiseCell1000ms(next).shank)');
        index = find(triu(ones(size(app))));
        appp = app(index);
        apppp = appp(~isnan(appp));
        noiseNCorr_3_1000ms = [noiseNCorr_3_1000ms apppp(:)'];
        clear app
        clear appp
        clear apppp
        clear index
    else
        apppp = [];
        noiseNCorr_3_1000ms = [noiseNCorr_3_1000ms apppp(:)'];
    end
    if (size(signalCell1000ms(probe).shank,1) > 0) && (size(signalCell1000ms(next).shank,1) > 0)
        app = corr(signalCell1000ms(probe).shank, signalCell1000ms(next).shank);
        index = find(triu(ones(size(app))));
        appp = app(index);
        apppp = appp(~isnan(appp));
        signalCorr_3_1000ms = [signalCorr_3_1000ms apppp(:)'];
        clear app
        clear appp
        clear apppp
        clear index
    else
        apppp = [];
        signalCorr_3_1000ms = [signalCorr_3_1000ms apppp(:)'];
    end
end



%%
%     noiseCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseCorr_0_1000ms];
%     noiseCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseCorr_1_1000ms];
%     noiseCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseCorr_2_1000ms];
%     noiseCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseCorr_3_1000ms];
%
%     noiseNCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseNCorr_0_1000ms];
%     noiseNCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseNCorr_1_1000ms];
%     noiseNCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseNCorr_2_1000ms];
%     noiseNCorr1000ms(idxShank).exp = [noiseCorr1000ms(idxShank).exp noiseNCorr_3_1000ms];
% end
