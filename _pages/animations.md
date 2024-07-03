---
title: "Animations in MATLAB"
# layout: collection
permalink: /animations/
# collection: research
# entries_layout: grid
header:
  image: /assets/images/TankImage.jpg
  caption: "Laboratory setup for studing Internal Solitary Waves"
---

# To start - design concepts
Nearly all of this is self taught – and of that I picked it up from example scripts I was using, or had access to. A few useful resources:
-	SPINSmatlab
-	[SPINS Wiki](https://wiki.math.uwaterloo.ca/fluidswiki/index.php?title=Special:AllPages) has useful pages on animations and plots that are relevant to SPINS
-	[MATLAB Help Center](https://uk.mathworks.com/help/matlab/animation-1.html)

As a note, I always use shading flat in my pcolor plots. Instead of writing this out every time, I have this in my startup.m script:
`set(0, 'DefaultSurfaceFaceColor', 'flat', 'DefaultSurfaceEdgeColor', 'none');`


# Basic Skeleton Movie Maker code for MATLAB

The fundamental idea of making animations is to make a series of plots, save the plot to a movie frame, and re-make the plot with new data. [Here](/assets/code/skeleton_movie.m)is a short code I wrote a while back to illustrate this for SPINS data. You can easily replace that with an equivalent dataset from the lab, alternative model, or matlab invented data.

It consists of the following pseudocode:
```
Read in variables and parameters that are fixed for all timesteps
Set up the figure, and videoWriter 
for ii = 1:length(timesteps)
	Read and plot the timestep specific data
	Pause to ensure the captured figure is plotted right
	Getframe, and write to the videoWriter object
end
close(vid) 
```

I do this for 1D data (i.e. a line plot with time on x axis that adds a point at each timestep), 2D data (a Hovmoller Plot (x, t) that adds a line at each timestep) and 3D data (an x, z colormap which changes at each timestep). An example of why plotting these as movies can be useful is [here](/assets/images/example_movie.mp4) – you can see how variables actually change as the feature evolves. Example code and outputs below:
- [1D Code](/assets/code/movie_1d.m) and [1D Movie](/assets/images/movie_1d.mp4)
- [2D Code](/assets/code/movie_2d.m) and [2D Movie](/assets/images/movie_2d.mp4)
- [3D Code](/assets/code/movie_3d.m) and [2D Movie](/assets/images/movie_3d.mp4)

# Formatting movies without sacraficing speed
Of course when you’re actually running code, you’ll want the plot to be formatted nicely, and probably plotting with higher resolution data, both these things slow the code down a lot (the latter more obviously than the former). So the question is how to do this without slowing the code down?

Reformatting the plot on each timestep is VERY computationally expensive. We don’t want to have “hold on” because then we’d have plots with N x as much data on as we need (where N is the number of timesteps), but without hold on, formatting is reset each time we re-plot. That is unless we use the following fix:
```
if ii = t1
	xlabel('x'); ylabel('z');
	xlim([min(x) max(x)]);
	ylim([min(y) max(y)]);
	% Add any other formatting here
end
set(gca, 'NextPlot', 'replacechildren') % note this needs setting for each axis
```
I have included an example in a movie maker code [here](/assets/code/movie_fastformat.m)

This means the formatting is set only once, but the contents of the plot itself are cleared and overwritten each timestep. 

For preventing issues with resolution, I have rarely needed to implement these, but the following options are available:
- Downsampling the resolution
- Plotting contourf (or even contour) plots instead of pcolor
- If the data supports it (i.e. regularly spaced grids) using imagesc

# Plotting Improvements
It can improve the look of plots greatly to carry out the following edits:
-	Set an appropriate font size for the plot
-	Use LaTeX interpreter for the labels. To implement this encapsulate any text you want to look “latex-y” in $$ - e.g. `xlabel('$x$ - horizontal')`;. Typically you’d then have to also include `'interpreter', 'latex'` in the brackets, but my later code does this work for you…
-	Outline the axis (box on)
-	Turn the toolbar visibility off, so you don’t ruin your movie by running your mouse over it
-	Set line widths to slightly thicker (1.5 pt)
I always want to do this, so have a simple script I run that does it all for me
`figure_print_format(gcf);`
found [here](/assets/code/figure_print_format.m)

# Colormaps
I have a lot to say about these, but in the meantime please look at some references about good colormaps:
- [The importance of colormaps](https://ieeexplore.ieee.org/document/9167329)
- [cmocean](https://matplotlib.org/cmocean/) perpetually uniform colormaps for oceanographic variables, available for [MATLAB](https://www.mathworks.com/matlabcentral/fileexchange/57773-cmocean-perceptually-uniform-colormaps).
- For line color combinations that work see some help [here](https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3)
- [EGU guide on accessible presentations](https://blogs.egu.eu/geolog/2024/03/27/how-to-make-your-egu24-presentation-accessible/)
- [Colorblindness simulator](https://www.color-blindness.com/coblis-color-blindness-simulator/) for checking your figures are colorblind friendly. 


A final note, I spell colour without the British "u" throughout here, primarily because code uses the "color" version, and it therefore helps with consistency!


{: .text-left}

