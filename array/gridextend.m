function varargout = gridextend(varargin)
%GRIDEXTEND Extend grid.
%   Z = GRIDEXTEND(Z,NT,NB,NL,NR) extends grid.
%
%   Z = GRIDEXTEND(Z,NT,NB,NL,NR,VAL) pads sides with given value.
%
%   [X,Y,Z] = GRIDEXTEND(X,Y,Z,NT,NB,NL,NR) extend grid coordinate and data
%   arrays.
%
%   [X,Y,Z] = GRIDEXTEND(X,Y,Z,NT,NB,NL,NR,VAL) extend grid coordinate
%   array and pads sides of data array with given value.

% parse input
if ~isscalar(varargin{3})
    isxyz = 1;
else
    isxyz = 0;
end

if isxyz
    Z0 = varargin{1};
    X = varargin{2};
    Y = varargin{3};
    args = varargin(4:end);
else
    Z0 = varargin{1};
    nx = size(Z0,2);
    ny = size(Z0,1);
    [X,Y] = meshgrid(1:nx,1:ny);
    args = varargin(2:end);
end

error(nargchk(4,5,length(args)))
nt = args{1};
nb = args{2};
nl = args{3};
nr = args{4};

% extend data array
switch length(args)
    case 4
        % pad temporarily with zeros
        Z = gridextend(Z0,args{:},0);

        % replicate outer rows and columns
        if nt, Z(1:nt,:) = repmat(Z(1+nt,:),nt,1);
        end
        if nb, Z(end-nb+1:end,:) = repmat(Z(end-nb-1,:),nb,1);
        end
        if nl, Z(:,1:nl) = repmat(Z(:,1+nl),1,nl);
        end
        if nr, Z(:,end-nr+1:end) = repmat(Z(:,end-nr-1),1,nr);
        end

    case 5
        % pad with given value
        Z = args{5} * ones(size(Z0)+[nt+nb,nl+nr]);
        Z(nt+1:end-nb,nl+1:end-nr) = Z0;

end

if isxyz
    % extend coordinate arrays
    if isvector(X) && isvector(Y)
        x = X;
        y = Y;
        dx = mean(diff(x));
        dy = mean(diff(y));
        x = linspace(x(1)-nl*dx,x(end)+nr*dx,length(x)+nl+nr);
        y = linspace(y(1)-nt*dy,y(end)+nb*dy,length(y)+nt+nb);
        varargout = {Z,x,y};
    elseif ismatrix(X) && ismatrix(Y)
        x = X(1,:);
        y = Y(:,1);
        dx = mean(diff(x));
        dy = mean(diff(y));
        x = linspace(x(1)-nl*dx,x(end)+nr*dx,length(x)+nl+nr);
        y = linspace(y(1)-nt*dy,y(end)+nb*dy,length(y)+nt+nb);
        [X,Y] = gridgrid(x,y);
        varargout = {Z,X,Y};
    end
else
    varargout = {Z};
end
