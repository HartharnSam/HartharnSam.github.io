clf;
% Read in data 
x = 0:.1:10;
t = (0:.1:20)';
z = cos(x+t);
[X, T] = meshgrid(x, t);
% Set up the figure, and videoWriter 
figure(1);
vid = VideoWriter('movie_2D.mp4', 'MPEG-4' );
vid.FrameRate = 2;
open(vid)

for ii = 2:length(t)
    %Read and plot the timestep specific data
    pcolor(X(1:ii, :), T(1:ii, :), z(1:ii, :));
    xlim([x(1) x(end)]);
    ylim([min(t) max(t)]);
    
    % getframe, and write to the videoWriter object
    pause(.1);
    writeVideo(vid, getframe(gcf));
end

close(vid)
