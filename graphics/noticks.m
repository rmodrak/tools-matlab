function noticks(axh,opt)
%NOTICKS Removes axis ticks.
%
%   fjsimons-at-mit.edu

defval('axh',gca)
defval('opt','all')

switch opt
  case 'all'
    set(axh,'XTick',[],'YTick',[])
  case 'x'
    set(axh,'XTick',[])
  case 'y'
    set(axh,'YTick',[])
end

