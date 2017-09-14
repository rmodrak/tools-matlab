function x = cgsolve(matprod,b,tol,maxiter)
%CGSOLVE Matrix-free conjugate gradient solver.

defval('tol',1e-3)
defval('maxiter',20)

% check input arguments
if nargin < 2
    error('Too few input arguments.')
end

if ~isa(matprod,'function_handle')
    error('Argument 1 must be a function handle.')
end

if ~isvector(b)
    error('Argument 2 must be a vector.')
end

if ~iscolumn(b)
    b = b.';
end

% initialize
n = length(b);
x = zeros(n,1);
r = -b;
y = r;
p = -y;
ry = dot(r,y); 

for iter = 1:maxiter
    
    % compute matrix-vector product
    Ap = matprod(p);
    pAp = dot(p,Ap);

    % check curvature
    if pAp < 0
        %warning('Negative curvature detected.')
    end

    alpha = ry/(pAp);
    x = x + alpha*p;
    r = r + alpha*Ap;
    
    % check E-W condition
    if 1
        fprintf('LHS:   %s\n', norm(-b+Ap))
        fprintf('RHS:   %s\n', norm(-b))
        fprintf('RATIO: %s\n\n', norm(-b)/norm(-b+Ap))
    end
    
    % check for convergence
    resd = norm(r);
    if resd < tol
        break
    end
    
    % apply preconditioner
    y = r;
    
    ry_old = ry;
    ry = dot(r,y);
    beta = ry/ry_old;
    p = -y + beta*p;
        
end
