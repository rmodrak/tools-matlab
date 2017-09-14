function expandaxes(axh)
%EXPANDAXES Makes axes cover entire figure window.

defval('axh',gca)
set(axh,'Position',[0 0 1 1]);
