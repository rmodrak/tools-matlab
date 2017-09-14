function V = gauss3(X,Y,Z,mu,sigma)
%   GAUSS2(X,Y,MU,COV) evaluates a Gaussian function with mean MU and
%   covariance SIGMA at the points of X, Y, and Z.

assert(isequal(size(X),size(Y),size(Z)),...
    'SizeError')
assert(isvector(mu),...
    'ValueError')
assert(ismatrix(sigma),...
    'ValueError')

D = det(sigma);
B = sigma^-1;

% evaluate Gaussian
X = X-mu(1);
Y = Y-mu(2);
Z = Z-mu(3);
V = B(1,1)*X.^2 + B(1,2)*X.*Y + B(1,3)*X.*Z + ...
    B(2,1)*X.*Y + B(2,2)*Y.^2 + B(2,3)*Y.*Z + ...
    B(3,1)*X.*Z + B(3,2)*Y.*Z + B(3,3)*Z.^2;
V = exp(-0.5*V);
V = (2*pi*sqrt(D))^-1 * V;