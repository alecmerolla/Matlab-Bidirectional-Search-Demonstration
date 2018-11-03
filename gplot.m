function [ G p ] = gplot(g)
% creates a graph plot and returns the graph G and plot p

G = graph(g);
p = plot(G,'Layout','force');

axis off
f = gcf;
f.set('Color',[1,1,1])
axis normal