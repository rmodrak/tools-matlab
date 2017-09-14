function Z = gauss2(X,Y,mu,sigma)
%GAUSS2 Bivariate Gaussian function.
%   GAUSS2(X,Y,MU,COV) evaluates a Gaussian function with mean MU and
%   covariance SIGMA at the points of X and Y.

assert(isequal(size(X),size(Y)),...
    'SizeError')
assert(isvector(mu),...
    'ValueError')
assert(ismatrix(sigma),...
    'ValueError')

% determinant of covariance matrix
D = sigma(1,1)*sigma(2,2) - sigma(1,2)*sigma(2,1);

% inverse of covariance matrix
B = D^-1 * [sigma(2,2) -sigma(1,2); -sigma(2,1) sigma(1,1)];

% evaluate Gaussian
X = X-mu(1);
Y = Y-mu(2);
Z = B(1,1)*X.^2 + B(1,2)*X.*Y + B(2,1)*X.*Y + B(2,2)*Y.^2;
Z = exp(-0.5*Z);
Z = (2*pi*sqrt(D))^-1 * Z;
