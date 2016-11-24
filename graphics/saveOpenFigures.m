function saveOpenFigures(totfigs_aperte)

for fignum = 1: totfigs_aperte
    figure(fignum)
    name = sprintf('figura%d.eps', fignum );
    saveas(gcf,name,'epsc')
end