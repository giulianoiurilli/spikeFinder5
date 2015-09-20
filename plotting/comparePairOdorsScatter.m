k = 1;
for i = [1 2 5 6]
    apcxDprime(:,k) = d_prime(:,i);
    k = k+1;
end


a = find(position == 1);
b = find(position == 2);
c = find(position == 3);
d = find(position == 4);

na = length(a);
nb = length(b);
nc = length(c);
nd = length(d);

colore = zeros(1,na + nb + nc + nd);
colore(1:na) = 10;
colore(na+1:nb) = 20;
colore(nb+1:nc) = 30;
colore(nc+1:nd) = 40;



h=figure('position',[200 200 500 500]);
z = 1;
for i = 1:4
    for k = 1:4
        hold on
        sp1 = subplot(4,4,z);
        together = [apcxDprime(:,i) apcxDprime(:,k) position'];
        together = sortrows(together,3);        
        scatter(together(:,1), together(:,2), 7, colore, 'filled')
        together(:,3) = [];
        maxAx = max(max(together));
        minAx = abs(min(min(together)));
        limit = max([minAx maxAx]);
        xlim([-limit limit]); ylim([-limit limit]); 
        line([0 0], [-limit limit], 'Color', 'k')
        line([-limit limit], [0 0], 'Color', 'k')
        axis square
        axis off
        set(sp1,'XTick',[])
%         %set(sp1,'XTickLabel', {'0'})
%         set(sp1,'YTick',[])
        %set(sp1,'YTickLabel', {'0'})
        z = z+1;
        hold off
    end
end


set(h,'color','white', 'PaperPositionMode', 'auto');

stringa_fig=sprintf('apcxScatters.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')