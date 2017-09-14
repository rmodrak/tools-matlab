function autotick(varargin)

if nargin == 1
    axh = gca;
    opt = varargin{1};
elseif nargin == 2
    axh = varargin{1};
    opt = varargin{2};
end

switch opt
  case 'all'
        autotick('x')
        autotick('y')
    case 'x'
        set(axh,'xtickmode','auto')
        set(axh,'xticklabelmode','auto')
    case 'y'
        set(axh,'ytickmode','auto')
        set(axh,'yticklabelmode','auto')
    case {'cb', 'colorbar'}
        h=findall(gcf,'tag','Colorbar');
        autotick(h,'x')
        autotick(h,'y')
end
