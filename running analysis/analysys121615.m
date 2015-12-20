% RSP = zeros(15, 150*3);
% BSL = zeros(15, 150*3);
% RSP1 = zeros(15, 150);

for idxExp = 9 : 8+length(List)%-1
    cartella = List{idxExp-8};
    cd(cartella)
    load('breathing.mat', 'sec_on_bsl', 'sec_on_rsp', 'sec_off_bsl', 'sec_off_rsp');
    bsl1 = sec_off_bsl{3} - sec_off_bsl{2};
    bsl2 = sec_off_bsl{2} - sec_off_bsl{1};
    bsl3 = sec_off_bsl{1} - sec_on_bsl;
    BSL(idxExp,:) = [bsl1(:)' bsl2(:)' bsl3(:)'];
    rsp1 = sec_off_rsp{3} - sec_off_rsp{2};
    rsp2 = sec_off_rsp{2} - sec_off_rsp{1};
    rsp3 = sec_off_rsp{1} - sec_on_rsp;
    RSP(idxExp,:) = [rsp1(:)' rsp2(:)' rsp3(:)'];
    RSP1(idxExp,:) = rsp3(:)';
end

meanRSP = mean(RSP(:));
meanBSL = mean(BSL(:));
meanRSP1 = mean(RSP1(:));
ALL = [RSP(:) BSL(:)];

meanALL = mean(ALL(:));

