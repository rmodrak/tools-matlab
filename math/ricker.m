function Y = ricker(X,mu,sigma)
%RICKER Ricker function.
%  RICKER(X,MU,SIGMA) evaluates, at the points of X, the second derivative
%  of a Gaussian function with mean MU and standard deviation SIGMA.

Y = - ((X-mu).^2 - sigma^(1/2)) .* exp( -(X-mu).^2 / (2*sigma^(1/2)) ) / ...
    (sigma^3*sqrt(2*pi));

