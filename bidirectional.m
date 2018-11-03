% go to line 149

% clear,clc
% n = 100;
% p = 0.1;
% t =  combo(n,2);
% g = zeros(n)*0;
% fig
%
% for k = 1:t
%     if randi(n) <= n*p
%         rn = randi(n);
%         rm = randi(n);
%
%         while g(rn,rm) ~= 0 || rn == rm
%
%             rn = randi(n);
%             rm = randi(n);
%
%         end
%
%         g(rn,rm) = 1; g(rm,rn) = 1;
%     end
% end
%
% plot(graph(g),'Layout','circle')
% f = gcf;
% f.set('Color',[1,1,1])
% axis equal
% axis off

% sum(sum(g))
%
% n^2*p
% k = n*p;
% diameter = ceil(log(n)/log(k))
% density = (p*n^2)/n^2
% clustering = k/n

%%
clear,clc
n = 100; k = 10; K = k/2;

v = repelem((1:n)',1,K);

e = v + repmat(1:K,n,1);

e = mod(e-1,n) + 1;

fig, g = graph(v,e);

p = plot(g,'Layout','subspace3');
axis off
g = gcf;
g.set('Color',[1,1,1])
axis equal



% index = 1;
% diameter = 0;
% while (index <= n/2)
%     first = index;
%     if index == n/2
%         index = index + 1;
%     elseif (index + k/2) > (n/2 + 1)
%         index = index + (n/2+1 - index);
%     else
%         index = index + k/2;
%     end
%     line([p.XData(first),p.XData(index)], ...
%          [p.YData(first),p.YData(index)],'color','red')
%     diameter = diameter + 1;
% %     pause(1)
% end

% diameter = ceil(n/k);
% [ a b ] = size(e);
% E = a*b;
% B = combo(n,2);
% density = E/B;
% clustering = (3*k*(k-2))/8 / combo(k,2);


%%
clear,clc
fig
n = 100;
% A = zeros(n);
I = 4;
ind = 2;
for k = 1:floor((n-ind)/I)
    for m = 1:I
        A(k,ind) = 1; A(ind,k) = 1;
        ind = ind + 1;
        %         [ G p ] = gplot(A);
        %         line([p.XData(k),p.XData(ind-1)], ...
        %             [p.YData(k),p.YData(ind-1)],'color','red')
        %         pause(0.01)
    end
    if  n-ind < I && ind ~= n+1
        for J = 1:(n-ind)+1
            A(k+1,ind) = 1; A(ind,k+1) = 1;
            ind = ind + 1;
            %             [ G p ] = gplot(A);
            %             line([p.XData(k+1),p.XData(ind-1)], ...
            %                 [p.YData(k+1),p.YData(ind-1)],'color','red')
            %             pause(0.01)
        end
    end
end

% A = triu(A,+1)' + A;
[ G p ] = gplot(A);

% search 1 down to 16, for I = 4, n = 20
% while nextVertex ~= nV
%     line([p.XData(k+1),p.XData(ind-1)], ...
%         [p.YData(k+1),p.YData(ind-1)],'color','red')
%     red line from target node backwards
%     for k = 1:length(connections to current node)
%         red line each passing connection
%         if line just created == line from target node
%             stop
%         end
%     end
% end

% node = 70;
% start = 15;

% nodev = bfsearch(G,node);
% startv = bfsearch(G,start);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% count1=1;
% nextvertex=1;
% indec = 1;
% track1 = 0;
% track2 = 0;

%start nodes
start1 = 4;
start2 = 3;
leave = 0;

%for first bfs
nodev1 = bfsearch(G,start1,'edgetonew');
count1 = 1;
count2 = 1;
new1 = 0;
newnodes1 = nodev1(1);

%for second bfs

nodev2 = bfsearch(G,start2,'edgetonew');
count3 = 1;
count4 = 1;
new2 = 0;
newnodes2 = nodev2(1);

%%
check1 = 0; check2 = 1;
L1=length(nodev);
L2=length(startv);
count1 = 1;
count2 = 1;
ex1t = 0;
n2 = [0];
M=0;
while ex1t == 0
%     if nodev(check2==nodev(1:count1))
%         ex1t = 1;
%         break
%     end
%     if startv(check1==startv(1:count2))
%         ex1t = 1;
%         break
%     end
%     
    n1 = nearest(G , nodev(count1), 1);
    for k=1:length(n1)
        n1
        pause(0.2)
        check1 = n1(k);
        line([p.XData(nodev(count1)),p.XData(check1)], ...
            [p.YData(nodev(count1)),p.YData(check1)],'color','red')
        if sum(nodev(count1+k) == startv(1:count2)-length(n2)) > 0
            %         if startv(check1==startv(1:count2))
            ex1t = 1;
            break
        end
    end
%     if startv(check1==startv(1:count2))
%         ex1t = 1;
%         break
%     end
    count1 = count1 + length(n1);
    if ex1t == 1
        break
    end
    
    n2 = nearest(G , startv(count2), 1);
    for M = 1:length(n2)
        n2
        check2 = n2(M);
        pause(0.2)
        line([p.XData(startv(count2)),p.XData(check2)], ...
            [p.YData(startv(count2)),p.YData(check2)],'color','red')
        if sum(startv(count2+M) == nodev(1:count1-length(n2))) > 0
            %         if nodev(check2==nodev(1:count1))
            ex1t = 1;
            break
        end
    end
%     if nodev(check2==nodev(1:count1))
%         ex1t = 1;
%         break
%     end
    count2 = count2 + length(n2);
    if ex1t == 1
        break
    end
    
end

        line([p.XData(start),p.XData(node)], ...
            [p.YData(start),p.YData(node)],'color','magenta')


%%
node = 90;
start = 1;
%
O = start;
Z = node;
%
current = 0;
m = node;
%
% Q = zeros(30);

i = 1;
M(i) = getframe(gcf);
i = i + 1;
M(i) = getframe(gcf);
i = i + 1;
K = 1;
newvar = 0;
var = 1;
%
while current ~= m
    % backwards
    %     last = nearest(G,node,1);
    %     m = min(last);
    %
    %     line([p.XData(Z),p.XData(m)], ...
    %          [p.YData(Z),p.YData(m)],'color','red')
    %
    %     Z = m;
    %
    M(i) = getframe(gcf);
    i = i + 1;
    %
    % forewards
    %     if O == 0
    %         O = 2;
    %         first = nearest(G,O,1);
    %     else
    % maybe have a vector of deleted edges from the line 173 -1 operation
    % and iterate after the O == 0 to fill in the other things before
    % incrmemetning
    first = nearest(G,O,1);
    %     end
    if K == 1
        Q(K,1:length(first)) = first;
    else
        Q(K+newvar,1:length(first)-1) = first(2:length(first));%first(2:length(first))
    end
    for k = 1:length(first)
        current = first(k);
        
        line([p.XData(O),p.XData(current)], ...
            [p.YData(O),p.YData(current)],'color','red')
        %
        M(i) = getframe(gcf);
        i = i + 1;
        %
        if current == m
            break
        end
        
    end
    
    %     last = nearest(G,node,1);
    %     m = min(last);
    %
    %     line([p.XData(Z),p.XData(m)], ...
    %          [p.YData(Z),p.YData(m)],'color','red')
    
    M(i) = getframe(gcf);
    i = i + 1;
    
    %     Z = m;
    %     O = min(first);
    if K == nnz(Q(var,:))+1
        var = var + 1
        newvar = newvar+nnz(Q(var,:));
        K = 1;
        O = Q(var,K);
        K = K +1;
        %     break
    else
        %     K = K+1;
        O = Q(var,K);
        K=K+1;
        if var == 2
            %     break
        end
    end
    
end

line([p.XData(k),p.XData(k)], ...
    [p.YData(k),p.YData(k)],'color','red', ...
    'Marker','x','MarkerSize',20)
disp('FOUND!')
M(i) = getframe(gcf);
i = i + 1;
M(i) = getframe(gcf);
i = i + 1;

%%
% for random network edges without interconnectivity
% start with 1, have array of current nodes
% select one at random, randi(numel(vec))
% add the ind+1 edge to the selected vertex at p = x
% repeat for n - 1 edges

%%
axis vis3d
ind = 100;
% M = 1:ind
for i=1:ind
    camorbit(10,0,'camera')
    %    drawnow
    M(i) = getframe(gcf);
    %    pause(0.1)
end
%%
v = VideoWriter('itsTime.avi');
v.set('FrameRate',2)
open(v)
writeVideo(v,M)
close(v)

%%
% tip 120 logic level mosfet
% need to disipate heat for 168 watts
% make sure 3.3 logic level for pi