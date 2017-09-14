function Y = gauss1(X,mu,sigma)
%GAUSS1 Gaussian function.
%   GAUSS(X,MU,SIGMA) evaluates a Gaussian function with mean MU and
%   variance SIGMA^2 at the points of X.

Y = exp( -X.^2 / (2*sigma^2) ) / (sigma*sqrt(2*pi));