%%
clear,clc
fig
% change number of nodes
n = 300;
% start nodes
start1 = 275;
start2 = 75;
% leave condition
leave = 0;
% duration between line drawing (seconds)
duration = 0.3;
% iterations
iterations = 0;
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

[ G p ] = gplot(A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% count1=1;
% nextvertex=1;
% indec = 1;
% track1 = 0;
% track2 = 0;


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

% below must be defined only once
% nodev = bfsearch(G,100,'edgetonew');
% count1 = 1;
% count2 = 1;
% new = 0;
% newnodes = nodev(1);

while leave == 0
  %  w = waitforbuttonpress
    holdnodes1 = [];
    
    %save new nodes
    while ismember(nodev1(count1),newnodes1) && (count1 <= length(nodev1))
        holdnodes1 = [holdnodes1,nodev1(count1,2)];
        count1 = count1 + 1;
    end
    
    %draw the lines for new nodes
    for m = 1:count1-count2
        
        %check if node has been visited
        if ismember(nodev1(count2), newnodes2) || leave == 1
            leave = 1;
            break;
        end
        
        %count2 starts where last left off on nodev
        line([p.XData(nodev1(count2)),p.XData(holdnodes1(m))], ...
            [p.YData(nodev1(count2)),p.YData(holdnodes1(m))],'color','red')
        pause(duration)
        
        
        count2 = count2+1;
    end
    
    %exit loop and finish
    if(leave == 1)
        disp("done!")
        break;
    end
    %make sure count2 = count1;
    if count2 ~= count1
        disp("Error with count1 and count2 not equal.")
    end
    count2 = count1;
    %add the newest nodes to the new nodes
    newnodes1 = [newnodes1, holdnodes1]
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %second bfs
    
    holdnodes2 = [];
    
    %save new nodes
    while ismember(nodev2(count3),newnodes2) && (count3 <= length(nodev2))
        holdnodes2 = [holdnodes2,nodev2(count3,2)];
        count3 = count3 + 1;
    end
    
    %draw the lines for new nodes
    for m = 1:count3-count4
        %check if node has been visited
        if ismember(nodev2(count4), newnodes1) || leave == 1
            leave = 1;
            break;
        end
        
        %count2 starts where last left off on nodev
        line([p.XData(nodev2(count4)),p.XData(holdnodes2(m))], ...
            [p.YData(nodev2(count4)),p.YData(holdnodes2(m))],'color','green')
        pause(duration)
        
        
        count4 = count4+1;
    end

    
    %exit loop and finish
    if(leave == 1)
        disp("done!")
        break;
    end
    
    %make sure count2 = count1;
    
    if count4 ~= count3
        disp("Error with count3 and count4 not equal.")
    end
    count4 = count3;
    %add the newest nodes to the new nodes
    newnodes2 = [newnodes2, holdnodes2]
    iterations = iterations + 1;
end
disp("Finished in "+iterations+" iterations!")
nodecount = length(newnodes1) + length(newnodes2)