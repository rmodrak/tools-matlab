function Hv = autohv(grad,x0,v,g0,opt,varargin)
%AUTOHV numerical Hessian-vector product

if nargin < 3
    error('Too few input arguments.')
end

if nargin < 4
    g0 = grad(x0,varargin{:});
end 

if nargin < 5
    opt = 'Forward';
end

if strcmp(opt,'Complex')
    pert = 1e-150*1i;
else
    pert = 2*sqrt(1e-12)*(1+norm(x0))/norm(v);
end

g = grad(x0+v*pert,varargin{:});
Hv = (g-g0)/pert;
