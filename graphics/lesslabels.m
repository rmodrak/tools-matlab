function lesslabels(varargin)
%LESSLABELS Reduces the number of tick labels.

if nargin == 1
    axh = gca;
    opt = varargin{1};
elseif nargin == 2
    axh = varargin{1};
    opt = varargin{2};
end

switch opt
  case 'all'
        lesslabels('x')
        lesslabels('y')
    case 'x'
        xlabels  = get(axh,'xticklabel');
        if ~iscellstr(xlabels)
            xlabels = cellstr(xlabels);
        end
        xlabels(2:2:end-1) = {''};
        set(axh,'xticklabel',xlabels)
    case 'y'
        ylabels  = get(axh,'yticklabel');
        if ~iscellstr(ylabels)
            ylabels = cellstr(ylabels);
        end
        ylabels(2:2:end-1) = {''};
        set(axh,'yticklabel',ylabels)
    case {'cb', 'colorbar'}
        h=findall(gcf,'tag','Colorbar');
        lesslabels(h,'x')
        lesslabels(h,'y')
end
