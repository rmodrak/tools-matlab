function bgcolor(opt,fgh,axh)
%BGCOLOR Changes background color.

defval('fgh',gcf)
defval('axh',gca)
defval('opt','gray')

switch opt
    case 'white'
        set(fgh,'Color','white')
        set(axh,'Color','white')
    case 'gray'
        set(fgh,'Color','white')
        set(axh,'Color',[0.9,0.9,0.9])
    otherwise
        background('white',fgh,axh)
end
