function fig();
% initialize a docked 3d rotatable figure x

delete(gcf);
fig1 = figure;
axe1 = axes;
set(gca,'Box','on');
fig1.WindowStyle = 'docked';
%fig1.WindowState = 'fullscreen';
pause(0.1)
rotate3d on

end