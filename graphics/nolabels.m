function nolabels(axh,opt)
%NOLABELS Removes axis labels.
%
%   fjsimons-at-mit.edu

defval('axh',gca)
defval('opt','all')

switch opt
  case 'all'
    set(axh,'XTickLabel',{},'YTickLabel',{})
  case 'x'
    set(axh,'XTickLabel',{})
  case 'y'
    set(axh,'YTickLabel',{})
end
