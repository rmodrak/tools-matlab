function zs = meshsmooth(x,y,z,span,opt)
%MESHSMOOTH Smooth mesh.
%   MESHSMOOTH(X,Y,Z,SPAN,OPT,XI,YI) smooths data on an irregular mesh,
%   where X,Y contain the mesh coordinates, Z contains the data, and SPAN
%   is the width of the smoothing kernel.

% check input arguments
if nargin < 4
    error('Not enough input arguments.');
end
if nargin < 5
    opt = 'moving';
end

switch opt
    case {'moving' 'gauss' 'gaussian'}
        
        % remove nonunique points
        [xs,ys,zs] = meshuniq(x,y,z);
        
        % interpolate to grid
        xmin = min(x(:));
        xmax = max(x(:));
        ymin = min(y(:));
        ymax = max(y(:));
        nx = floor( sqrt( 2*length(x)*(xmax-xmin)/(ymax-ymin) ) );
        ny = floor( sqrt( 2*length(y)*(ymax-ymin)/(xmax-xmin) ) );

        vx = linspace(xmin,xmax,nx);
        vy = linspace(xmin,xmax,nx);
        [X,Y] = meshgrid(vx,vy);
        Z = griddata(xs,ys,zs,X,Y);
        
        % smooth data
        ZS = smooth2(Z,span,opt);
        zs = interp2(X,Y,ZS,x,y);
    
    case 'laplacian'

        % remove nonunique points
        [x,y,z] = meshuniq(x,y,z);
        
        % compute delaunay triangulation
        f.faces = delaunay(x,y);
        f.vertices = [x y z];

        % smooth data
        f = smoothpatch(f,1,span);
        zs = f.vertices(:,3);
     
    otherwise
        error(badopt(opt))

end
