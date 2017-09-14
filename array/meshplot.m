function varargout = meshplot(z,x,y,tri)
%MESHPLOT Plot mesh.
%   MESHPLOT(X,Y,Z,TRI) plots a set of values on an irregular mesh. A
%   Delaunay triangulation TRI can be supplied if available, otherwise a
%   new one is computed.

% check input arguments
if nargin < 4
    [x,y,z] = meshuniq(x,y,z);
    tri = delaunay(x,y);
end

nrow = size(z,1);
ncol = size(z,2);

% create plot
for i=1:ncol
    h(i) = trisurf(tri,x,y,z(:,i));
    shading flat
    view(0,90)
    xlim(minmax(x))
    ylim(minmax(y))
    %noaxes
end

if nargout == 0
    %pass
elseif nargout == 1
    varargout = h;
else
    error('Too many output arguments.')
end
