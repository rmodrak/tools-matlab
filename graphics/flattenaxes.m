function flattenaxes(axh)
%FLATTENAXES Flattens 3D axes.

defval('axh',gca)

view(axh,[0 90])
