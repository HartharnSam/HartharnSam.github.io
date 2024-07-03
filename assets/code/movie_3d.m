clf;
% Read in data 
x = 0:.1:10;
y = (0:.1:20)';
t = 0:100;
[X, Y] = meshgrid(x, y);
% Set up the figure, and videoWriter 
figure(1);
vid = VideoWriter('movie_3D.mp4', 'MPEG-4' );
vid.FrameRate = 2;
open(vid)

for ii = 2:length(t)
    %Read and plot the timestep specific data
    z = cos(x+y+t(ii));
    pcolor(X, Y, z);
    
    % getframe, and write to the videoWriter object
    pause(.1);
    writeVideo(vid, getframe(gcf));
end

close(vid)
