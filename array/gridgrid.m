function [X,Y] = gridgrid(x,y)
%GRIDGRID Construct coordinate arrays.

[X,Y] = meshgrid(x,y);

if all(diff(x) < 0)
    X = fliplr(X);
end

if all(diff(y) < 0)
    Y = flipud(Y);
end
