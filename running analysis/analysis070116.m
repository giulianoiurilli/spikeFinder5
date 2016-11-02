[sigAnovaCoa] = concSeriesAnalysis2_new(coaCS.esp, 1:15);
[sigAnovaPcx] = concSeriesAnalysis2_new(pcxCS.esp, 1:15);

[VariantCoa, InvariantCoa, nonmonotonic, nonmonotonicSem, monotonicD, monotonicDSem, monotonicI, monotonicISem] = findConcInvarianceAndMonotonicity_new(coaCS.esp);
[VariantPcx, InvariantPcx, nonmonotonic, nonmonotonicSem, monotonicD, monotonicDSem, monotonicI, monotonicISem] = findConcInvarianceAndMonotonicity_new(pcxCS.esp);


nonResponsiveCoa = numel(find(sigAnovaCoa==0)) ./ numel(sigAnovaCoa);
odorIDCoa = numel(find(sigAnovaCoa==1)) ./ numel(sigAnovaCoa);
odorConcCoa = numel(find(sigAnovaCoa==2)) ./ numel(sigAnovaCoa);
odorBothCoa = numel(find(sigAnovaCoa==3)) ./ numel(sigAnovaCoa);

nonResponsivePcx = numel(find(sigAnovaPcx==0)) ./ numel(sigAnovaPcx);
odorIDPcx = numel(find(sigAnovaPcx==1)) ./ numel(sigAnovaPcx);
odorConcPcx = numel(find(sigAnovaPcx==2)) ./ numel(sigAnovaPcx);
odorBothPcx = numel(find(sigAnovaPcx==3)) ./ numel(sigAnovaPcx);
%%
figure
b = bar([nonResponsiveCoa nonResponsivePcx; odorIDCoa odorIDPcx; odorConcCoa odorConcPcx; odorBothCoa odorBothPcx]);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

sqrt(nonResponsiveCoa * (1-nonResponsiveCoa)/(numel(sigAnovaCoa)-1))*0.68/.1
sqrt(nonResponsivePcx * (1-nonResponsivePcx)/(numel(sigAnovaCoa)-1))*0.68/.1
sqrt(odorIDCoa * (1-odorIDCoa)/(numel(sigAnovaCoa)-1)) *0.68/.1
sqrt(odorIDPcx * (1-odorIDPcx)/(numel(sigAnovaCoa)-1)) *0.68/.1
sqrt(odorConcCoa * (1-odorConcCoa)/(numel(sigAnovaCoa)-1)) *0.68/.1
sqrt(odorConcPcx * (1-odorConcPcx)/(numel(sigAnovaCoa)-1))*0.68/.1
sqrt(odorBothCoa * (1-odorBothCoa)/(numel(sigAnovaCoa)-1)) *0.68/.1
sqrt(odorBothPcx * (1-odorBothPcx)/(numel(sigAnovaCoa)-1))*0.68/.1

%%
invariantCoa = numel(find(sigAnovaCoa==1)) / (numel(find(sigAnovaCoa==1))+numel(find(sigAnovaCoa==2))+numel(find(sigAnovaCoa==3)));
variantCoa = 1 - invariantCoa;
invariantPcx = numel(find(sigAnovaPcx==1)) / (numel(find(sigAnovaPcx==1))+numel(find(sigAnovaPcx==2))+numel(find(sigAnovaPcx==3)));
variantPcx = 1 - invariantPcx;
figure
b = bar([variantCoa variantPcx; invariantCoa invariantPcx]);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

sqrt(invariantCoa * (1-invariantCoa)/ (numel(find(sigAnovaCoa==1))+numel(find(sigAnovaCoa==2))+numel(find(sigAnovaCoa==3))))*0.95/.2
sqrt(invariantPcx * (1-invariantPcx)/ (numel(find(sigAnovaPcx==1))+numel(find(sigAnovaPcx==2))+numel(find(sigAnovaPcx==3))))*0.95/.2
sqrt(variantCoa * (1-variantCoa)/ (numel(find(sigAnovaCoa==1))+numel(find(sigAnovaCoa==2))+numel(find(sigAnovaCoa==3))))*0.95/.2
sqrt(variantPcx * (variantPcx)/ (numel(find(sigAnovaPcx==1))+numel(find(sigAnovaPcx==2))+numel(find(sigAnovaPcx==3))))*0.95/.2