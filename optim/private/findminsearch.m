function findminsearch(problem,method)
%FMSEARCH carries out line search

global x f g h alpha p iter

% method options
LineSearchMethod = method.LineSearchMethod;
% DecreaseFactor
% CurvatureFactor
% BacktrackingFactors

% prepare input arguments
phix = @(alpha) x + alpha*p;
phif = @(alpha) problem.Func(x+alpha*p);
phig = @(alpha) dot(problem.Grad(x+alpha*p), p);
f0 = f;
g0 = dot(g,p);

% call subroutine
switch LineSearchMethod
    case 'Backtracking'
        % backtracking based on quadratic or cubic interpolation; continues
        % until decrease condition satisfied
        [x,f] = Backtracking(phix,phif,phig,f0,g0,alpha);
        
    case 'Brent'
        % combines golden section search and quadratic interpolation;
        % attempts to find minimum within tolerances, ignores decrease and
        % curvature factors; derivative free method
        [x,f] = Brent(phix,phif,phig,f0,g0,alpha);
        
    case 'MoreThuente'
        % finds step length that satifies both decrease and curvature
        % conditions; based on minpack implementation
        [x,f] = MoreThuente(phix,phif,phig,f0,g0,alpha);
        
    otherwise
        error(badopt(LineSearchMethod));
end

end

%...........................................................................
function [x,f] = Backtracking(phix,phif,phig,f0,g0,alpha)
% see Nocedal & Wright p. 56-57, Denis & Schnabel p. 126-129
        
    % line search parameters
    c1 = 1e-4;
    c2 = 0.9;
    b1 = 0.1;
    b2 = 0.5;
    max_iter = 10;

    [~,f,alpha] = srchbac(phif,0,f0,g0,alpha,c1,c2,b1,b2,max_iter);
    x = phix(alpha);
    
end

%...........................................................................
function [x,f] = BacktrackingGeometric(phix,phif,phig,f0,g0,alpha)

    % line search parameters
    rho = 0.5;
    c1 = 1e-4;
    c2 = 0.5;
    max_iter = 10;

    % backtrack until sufficient decrease condition satisfied
    for iter = 1:max_iter
    alpha = alpha*rho;
    x = feval(phix,alpha);
    f = feval(phif,alpha);

    if f + c1*alpha > f0
        return
    end
    end

    % line search failed
    warning(['Line search failed to satisfy decrease condition' ...
         'within %d iterations'],max_iter)
end

%...........................................................................
function [x,f] = Brent(phix,phif,phig,f0,g0,alpha)

    % line search parameters
    a = 0;
    b = 3*alpha;
    epsilon = 0.1;
    tol = 0;

    [alpha,f] = srchbre(a,b,epsilon,tol,phif,alpha);
    x = phix(alpha);

end

%...........................................................................
function [x,f] = MoreThuente(phix,phif,phig,f0,g0,alpha)

    % line search parameters
    c1 = 1e-4;
    c2 = 0.9;
    b1 = 0;
    b2 = Inf;
    xtol = 1e-6;
    max_fev = 10;

    % prepare input arguments
    phi = @(~,alpha) deal(phif(alpha),phig(alpha));
    n = 1;
    x0 = 0;
    p = 1;
    ftol = c1;
    gtol = c2;

    % call minpack subroutine
    [alpha,f] = srchwlf(phi,n,x0,f0,g0,p,alpha,c1,c2,xtol,b1,b2,max_fev);
    x = phix(alpha);
    
end
