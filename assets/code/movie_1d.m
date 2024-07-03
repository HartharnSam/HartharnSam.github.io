clf;
% Read in data 
x = 0:.1:10;
y = sin(x*pi/2);

% Set up the figure, and videoWriter 
figure(1);
vid = VideoWriter('movie_1D.mp4', 'MPEG-4' );
vid.FrameRate = 2;
open(vid)

for ii = 1:length(x)
    plot(x(1:ii), y(1:ii));
    xlim([x(1) x(end)]);
    ylim([min(y) max(y)]);
    pause(.1);
    writeVideo(vid, getframe(gcf));
end

close(vid)
