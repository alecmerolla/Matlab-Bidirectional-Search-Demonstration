%%
clear,clc
% put the text on the screen to show where maybe each of them start
% ya cuz it will be a constant axes range, then put the text near each
% for how many iterations each one has done,
% clear,clc
fig
% change number of nodes
n = 50;
% i = 1;
% start nodes
% start1 = 1039;%3;
% two = bfsearch(G,start1);
% start2 = two(length(2));%360;
% % leave condition
% leave = 0;
% % duration between line drawing (seconds)
duration = 1e-2;
% % iterations
% iterations = 0;

I = 4;
% ind = 2;

% [ G g p ] = equalBranch(n,I);

% [ G p ] = gplot(A);
% [ g G ] = buildagraph(n,4*n);

% leave condition
leave = 0;
% duration between line drawing (seconds)
duration = 1e-2;
% iterations
iterations = 0;

% load the graph data of roads
load('roads.mat');
% convert the roads data into a graph object
G = graph(vertex,edge);
% plot the graph in a forced outward style layout
p = plot(G,'Layout','force');

% find the largest connected component using a breadth first search
% the largest component has the largest bfsearch array
mx = 0;
ind = 0;
for k = 1:length(vertex)
    x = length(bfsearch(G,vertex(k)));
    if x > mx
        mx = x;
        ind = k;
    end
end
% 
start1 = vertex(ind);
two = bfsearch(G,start1);
start2 = vertex(mx);%642;%657;
% start1 = 39
% start2 = 33

set(gca,'xlim',[0.3517 12.9181])
set(gca,'ylim',[1.9650 14.1136])
f = gcf;
f.set('Color',[1,1,1])
axis equal
axis off

% for first bfs
nodev1 = bfsearch(G,start1,'edgetonew');
count1 = 1;
count2 = 1;
new1 = 0;
newnodes1 = nodev1(1);

% for second bfs
nodev2 = bfsearch(G,start2,'edgetonew');
count3 = 1;
count4 = 1;
new2 = 0;
newnodes2 = nodev2(1);
% main loop
while leave == 0
    holdnodes1 = [];
    
    % save new nodes
    while ismember(nodev1(count1),newnodes1) && (count1 <= length(nodev1))
        holdnodes1 = [holdnodes1,nodev1(count1,2)];
        count1 = count1 + 1;
    end
    
    % draw the lines for new nodes
    for m = 1:count1-count2
        
        % count2 starts where last left off on nodev
        line([p.XData(nodev1(count2)),p.XData(holdnodes1(m))], ...
            [p.YData(nodev1(count2)),p.YData(holdnodes1(m))],'color','red', ...
            'LineWidth',1.5)
        set(gca,'xlim',[0.3517 12.9181])
        set(gca,'ylim',[1.9650 14.1136])

        % check if node has been visited
        if sum(ismember(nodev1(1:count2,2), newnodes2)) > 0 || leave == 1
            leave = 1;
            iterations = iterations + 1;
            break;
        end
        
        pause(duration)
        
%         M(i) = getframe(gcf);
%         i = i + 1;
        
        count2 = count2 + 1;
    end
    
    % exit loop and finish
    if(leave == 1)
        disp("done!")
        break;
    end
    % make sure count2 = count1;
    if count2 ~= count1
        disp("Error with count1 and count2 not equal.")
    end
    count2 = count1;
    % add the newest nodes to the new nodes
    newnodes1 = [newnodes1, holdnodes1]
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % second bfs
    
    holdnodes2 = [];
    
    % save new nodes
    while ismember(nodev2(count3),newnodes2) && (count3 <= length(nodev2))
        holdnodes2 = [holdnodes2,nodev2(count3,2)];
        count3 = count3 + 1;
    end
    
    % draw the lines for new nodes
    for m = 1:count3-count4
        
        % count2 starts where last left off on nodev
        line([p.XData(nodev2(count4)),p.XData(holdnodes2(m))], ...
            [p.YData(nodev2(count4)),p.YData(holdnodes2(m))],'color','magenta', ...
            'LineWidth',2)
        set(gca,'xlim',[0.3517 12.9181])
        set(gca,'ylim',[1.9650 14.1136])

        % check if node has been visited
        if sum(ismember(nodev2(1:count4,2), newnodes1)) > 0 || leave == 1
            leave = 1;
            iterations = iterations + 1;
            break;
        end

        pause(duration)
        
%         M(i) = getframe(gcf);
%         i = i + 1;
        
        count4 = count4+1;
    end
    
    % exit loop and finish
    if(leave == 1)
        disp("done!")
        break;
    end
    
    % make sure count2 = count1;
    if count4 ~= count3
        disp("Error with count3 and count4 not equal.")
    end
    
    count4 = count3;
    
    % add the newest nodes to the new nodes
    newnodes2 = [newnodes2, holdnodes2]
    iterations = iterations + 1;
    
end

% M(i) = getframe(gcf);
% i = i + 1;
% M(i) = getframe(gcf);
% i = i + 1;
disp("Finished in "+iterations+" iterations!")

%%
clear,clc

expr = '\w*';
fid = fopen('roads.txt');
nextLine = fgetl(fid);

EE = 1; VV = EE;

while ischar(nextLine)
    
    [ v n ] = regexp(nextLine,expr,'match','split');
    L = length(v);
    ist = [ string(v{1}) ];
    
    for k = 2:L
        ist = [ ist string(v{k}) ];
    end
    
    edge(EE) = str2double(ist(1)); vertex(VV) = str2double(ist(2));
    
    nextLine = fgetl(fid);
    
    EE = EE + 1;
    VV = VV + 1;
end
M(i) = getframe(gcf);
i = i + 1;
%
fclose(fid);
g = graph(vertex,edge);

p = plot(g,'Layout','circle');

f = gcf;
f.set('Color',[1,1,1])
axis equal
axis off

%%

% M(i) = getframe(gcf);
% i = i + 1;

v = VideoWriter('biDirectVidRoads4.avi');
v.set('FrameRate',10)
open(v)
writeVideo(v,M)
close(v)