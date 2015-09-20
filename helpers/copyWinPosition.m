function setText = copyWinPosition()
pos = get(gcf,'Position');
setText = sprintf('set(gcf,''Position'',[%d %d %d %d]);\n',pos);
clipboard('copy',setText);
end