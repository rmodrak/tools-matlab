function [x,y,z] = meshuniq(x,y,z,opt)
%MESHUNIQ Remove nonunique mesh points.
%   MESHUNIQ(X,Y,Z) returns vectors X,Y,Z with nonunique x,y coordinate 
%   pairs removed and corresponding z values averaged.

% check input argument
if nargin < 4
    opt = '';
end
       
if ~isnumeric(x) || ~isreal(x)
    error('X must be numeric and real.');

elseif ~isnumeric(y) || ~isreal(y)
    error('Y must be numeric and real.');

elseif ~isvector(x)
    error('X must be a vector.');

elseif ~isvector(y)
    error('Y must be a vector.');

elseif ~isvector(z)
    error('Z must be a vector.');

end

nx = length(x);
ny = length(y);
nz = length(z);

if ~isequal(nx,ny) || ~isequal(nx,nz)
    error('X,Y,Z must have the same length.')
end

x = reshape(x,nz,1);
y = reshape(y,nz,1);
z = reshape(z,nz,1);

% sort
[xyz,ixyz] = sortrows([x y z],[2 1]);
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);

myepsx = eps(0.5 * (max(x) - min(x)))^(1/3);
myepsy = eps(0.5 * (max(y) - min(y)))^(1/3);
ixy = [0; ((abs(diff(y)) < myepsy) & (abs(diff(x)) < myepsx)); 0];

if sum(ixy) > 0

    fb = find(ixy(1:end-1) == 0 & ixy(2:end) == 1);
    fe = find(ixy(1:end-1) == 1 & ixy(2:end) == 0);

    % take average of z
    for i = 1:length(fb)
        z(fb(i):fe(i)) = mean(z(fb(i):fe(i)));
    end

    if ~strcmp(opt,'same')
        % now remove duplicates
        xyz = xyz(~ixy(2:end),:);
        ixyz = ixyz(~ixy(2:end));
    end

end

% restore original ordering
[xyz] = sortrows([xyz ixyz],[4]);
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);
