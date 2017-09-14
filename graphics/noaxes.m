function noaxes(axh)
%NOAXES Makes axes invisible.

defval('axh',gca)
set(axh,'Visible','off')
