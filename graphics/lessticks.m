function lessticks(axh,opt)
%LESSTICKS Reduces the number of axis ticks.

defval('axh',gca)
defval('opt','all')

switch opt
  case 'all'
        lessticks(axh,'x')
        lessticks(axh,'y')
    case 'x'
        XTick  = get(axh,'XTick');
        XTick = downsample(XTick,2);
        set(axh,'XTick',XTick)
    case 'y'
        YTick  = get(axh,'YTick');
        YTick = downsample(YTick,2);
        set(axh,'YTick',YTick)
end
