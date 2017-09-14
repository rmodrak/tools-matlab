function cmap(opt,varargin)
%CMAP Select colormap.

defval('opt','')

% default colormaps
default = { 'hsv', 'hot', 'gray', 'bone', 'copper', 'pink', 'white', 'flag',...
    'lines', 'colorcube', 'vga', 'jet', 'prism', 'cool', 'autumn', 'spring',...
    'winter' 'summer'};

% custom colormaps
wild = sprintf('%s/private/*.m',dirname(which('cmap')));
obj = dir(wild);
custom = strip({obj.name});

cmaps = {default{:} custom{:}};
switch opt
    case cmaps
        c = feval(opt,varargin{:});
        colormap(c)
    otherwise
        clc
        fprintf('Available colormaps:\n')
        cellstrdisp(strip(default))
        cellstrdisp(strip(custom))
end
