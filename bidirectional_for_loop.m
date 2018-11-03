%count1 = 1; track = 1
for m = 1:length(nearest(G,100,indec))-track
n1 = nearest(G , nodev(count1), 1);
    for k=1:length(n1)
        n1
        pause(0.2)
        check1 = n1(k);
        line([p.XData(nodev(count1)),p.XData(check1)], ...
            [p.YData(nodev(count1)),p.YData(check1)],'color','red')
%         if sum(nodev(count1+k) == startv(1:count2)-length(n2)) > 0
%             %         if startv(check1==startv(1:count2))
%             ex1t = 1;
%             break
%         end
    end
    count1 = count1 + 1
    
end
track = length(nearest(G,100,indec)) - track
indec=indec+1;