function flipcmap(fgh)
%FLIPCMAP Reverses color map.

defval('fgh',gcf);

set(fgh,'Colormap',flipud(get(fgh,'Colormap')))
