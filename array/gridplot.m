function h = gridplot(Z,varargin)
%GRIDPLOT Plot grid data.

if nargin == 1
    nx = size(Z,2);
    ny = size(Z,1);
    h = imagesc(Z);

elseif nargin == 3
    X = varargin{1};
    Y = varargin{2};

    if isvector(X)
        %pass
    elseif ismatrix(X)
        X = X(1,:);
    end
    
    if isvector(Y)
        %pass
    elseif ismatrix(Y)
        Y = Y(:,1);
    end
    h = imagesc(X,Y,Z);

    if all(diff(X) < 0)
        flipaxis(gca,'x')
    end
    
    if all(diff(Y) < 0)
        flipaxis(gca,'y')
    end
        
else
    error()
end

% adjust aspect ratio
if nargin == 1
    ar = nx/ny;
elseif nargin == 3
    ar = (max(X(:))-min(X(:)))/(max(Y(:))-min(Y(:)));
end
try
    resize(gcf,ar);
catch
    %pass
end
