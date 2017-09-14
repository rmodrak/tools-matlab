function c = seismic(d)
%REDBLUE Red, blue, and gray color map.

if nargin == 0
    d = 20;
end

u = 0.9;
if mod(d,2) == 0
    r = [linspace(0,1,d/2) linspace(1,1,d/2)]';
    g = [linspace(0,1,d/2) linspace(1,0,d/2)]';
    b = [linspace(1,u*u,d/2) linspace(u*u,0,d/2)]';
else
    r = [linspace(0,u,(d-1)/2) u linspace(u,1,(d-1)/2)]';
    g = [linspace(0,u,(d-1)/2) u linspace(u,0,(d-1)/2)]';
    b = [linspace(1,u,(d-1)/2) u linspace(u,0,(d-1)/2)]';
end

c = [r g b]; 
