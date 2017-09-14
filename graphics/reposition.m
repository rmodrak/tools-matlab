function varargout = reposition(fgh,pFigure,pScreen)
%REPOSITION Repositions figure.
%   Repositions figure with respect to reference points on figure and
%   screen.

defval('fgh',gcf)
defval('pFigure','cc')
defval('pScreen','cc')

set(0,'Units','Inches');
ScreenSize = get(0,'ScreenSize');

set(fgh,'Units','Inches');
pos = get(fgh,'Position');

switch pScreen(1)
    case 'l'
        pos(1) = 0;
    case 'r'
        pos(1) = ScreenSize(3);
    case 'c'
        pos(1) = ScreenSize(3)/2;
    otherwise
        error(badname(pScreen(1)))
end

switch pScreen(2)
    case 'u'
        pos(2) = ScreenSize(4);
    case 'd'
        pos(2) = 0;
    case 'c'
        pos(2) = ScreenSize(4)/2;
    otherwise
        error(badname(pScreen(1)))
end

switch pFigure(1)
    case 'l'
        pos(1) = pos(1);
    case 'r'
        pos(1) = pos(1) - pos(3);
    case 'c'
        pos(1) = pos(1) - pos(3)/2;
    otherwise
        error(badname(pScreen(1)))
end

switch pFigure(2)
    case 'u'
        pos(2) = pos(2) - pos(4);
    case 'd'
        pos(2) = pos(2);
    case 'c'
        pos(2) = pos(2) - pos(4)/2;
    otherwise
        error(badname(pScreen(1)))
end

set(fgh,'Position',pos);

if nargout == 0
    % pass
elseif nargout == 1
    varargout = pos;
else
    error('Too many output arguments.')
end