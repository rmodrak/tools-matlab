function steps = findmin(varargin)
%FINDMIN Finds a local minimum of a function.
%   STEPS = FINDMIN(PROBLEM,METHOD[,STEPS]) finds a local minimimum using
%   given PROBLEM and METHOD structures and appends a record of model steps
%   and function evaluations to STEPS.
%
%   PROBLEM is a structure that defines the minimization problem to be
%   solved. The objective function and its derivatives must be supplied to 
%   the appropriate structure fields. See GETPROBLEM for more information.
%
%   METHOD is a structure that defines the minimization algorithm. The
%   main choice is between steepest descent, conjugate gradient, quasi-
%   Newton, Newton, and Gauss-Newton. Other options are available for more
%   detailed control. See GETMETHOD for more information.
%
%   STEPS contains a record of steps taken and function evaluations
%   computed in current and previous FINDMIN calls. If STEPS is not given 
%   as an input argument, FINDMIN starts from an initial model X0 supplied
%   in PROBLEM. If that also does not exist, the routine attempts to start 
%   from X0 = 0.
%
%   To see how it all works, use GETPROBLEM and GETMETHOD to generate a
%   test case, FINDMIN to find a local minimum, and FINDMINPLOT to plot the 
%   results, as in the following example:
%           problem = getproblem('Rosenbrock');
%           method = getmethod('Netwon');
%           steps = findmin(problem,method);
%           findminplot(steps); 
%

global x f g h alpha p iter

% process input arguments
[problem,method,steps] = initialize(varargin{:});

% begin optimization loop
for iter = 1:method.StopIterations

    % compute search direction
    switch method.Method
        case 'SteepestDescent'
            SteepestDescent(problem,method);
        case 'ConjugateGradient'
            ConjugateGradient(problem,method);
        case 'QuasiNewton'
            QuasiNewton(problem,method);
        case 'Newton'
            Newton(problem,method);
        case 'GaussNewton'
            GaussNewton(problem,method);
        case 'NewtonKrylov'
            NewtonKrylov(problem,method);
        otherwise
            error(badopt(Method));
    end
    
    % compute step length
    switch method.StepControl
        case 'LineSearch'
            findminsearch(problem,method);
        case 'TrustRegion'
            findmintrust(problem,method);
        case 'None'
            x = x + alpha * p;
            f = problem.Func(x);
        otherwise
            error(badopt(StepControl))
    end
    
    % append newest result
    steps.x{end+1} = x.';
    steps.f{end+1} = f;
    
    % check stopping conditions
    if findminstop(problem,method,steps)
        return
    elseif iter == method.StopIterations
        disp('Maximum number of iterations reached.')
        return
    end
    
end


%...........................................................................
function SteepestDescent(problem,method)
% steepest descent method

    % global variables
    global x f g h alpha p iter
    
    % local variables
    persistent f_new f_old g_new g_old p_new p_old

    % update variables
    if iter > 1
        f_old = f_new;
        g_old = g_new;
        p_old = p_new;
    end
    f_new = f;
    g_new = problem.Grad(x);
    p_new = [];
    
    % compute search direction
    p_new = -g_new;

    % choose initial step
    if iter == 1
        alpha = 1/sum(abs(g_new));
    else
        % 1) new step similar to previous step
        % 2) new step based on objective function
        %alpha = alpha*dot(g_old,p_old)/dot(g_new,p_new); % 1
        alpha = 2*(f_new-f_old)/dot(g_new,p_new); %2
    end

    % update global variables
    g = g_new;
    p = p_new;
    

%...........................................................................
function ConjugateGradient(problem,method)
% nonlinear conjugate gradient method

    % global variables
    global x f g h alpha p iter

    % local variables
    persistent f_new f_old g_new g_old p_new p_old itercg nstarts

    % update local variables
    if iter == 1
        itercg = 0;
        nstarts = 0;
    else
        f_old = f_new;
        g_old = g_new;
        p_old = p_new;
    end
    itercg = itercg + 1;
    f_new = f;
    g_new = problem.Grad(x);
    p_new = [];

    % compute search direction
    if itercg > 1

        % compute beta
        switch method.ConjugateGradientMethod
        case 'FletcherReeves'
            gtg = dot(g_old, g_old);
            beta= dot(g_new, g_new)/gtg;

        case 'PolakRibiere'
            gtg = dot(g_old, g_old);
            beta= dot(g_new, g_new-g_old)/gtg;

        case 'GilbertNocedal'
            gtg = dot(g_old, g_old);
            fr  = dot(g_new, g_new)/gtg;
            pr  = dot(g_new, g_new-g_old)/gtg;
            beta= max(-fr, min(pr,fr));

        otherwise
            error(badopt(method.ConjugateGradientMethod));
        end

        p_new = -g_new + beta*p_old;

        % check orthogonality condition
        if abs(dot(g_new,g_old))/dot(g_new,g_new) > method.RestartThreshold
            p_new = -g_new;
            itercg = 1;
            nstarts = nstarts + 1;

        % require descent direction
        elseif dot(p_new,g_new) > 0
            p_new = -g_new;
            itercg = 1;
            nstarts = nstarts + 1;
        end
        
    else
        p_new = -g_new;
        
    end

    % require periodic restarts
    if rem(itercg, method.RestartIterations) == 0
        itercg = 0;
        nstarts = nstarts + 1;
    end

    % choose initial step
    if iter == 1
        alpha = 1/sum(abs(g_new));
    else
        % 1) choose initial step similar to previous step
        % 2) choose initial step by interpolating objective function
        %alpha = alpha*dot(g_old,p_old)/dot(g_new,p_new); % 1
        alpha = 2*(f_new-f_old)/dot(g_new,p_new); %2
    end

    % update global variables
    g = g_new;
    p = p_new;
    

%...........................................................................
function QuasiNewton(problem,method)
% quasi-Newton method

    % global variables
    global x f g h alpha p iter

    % local variables
    persistent x_new x_old f_new f_old g_new g_old p_new p_old S Y
    
    n = problem.nmod;
    m = method.QuasiNewtonStepMemory;
    al = zeros(m,1);
    rh = zeros(m,1);
    
    if iter == 1
        x_new = x;
        f_new = f;
        g_new = problem.Grad(x);
        p_new = -g_new;
        
        S = zeros(n,m);
        Y = zeros(n,m);
        
    else
        x_old = x_new;
        f_old = f_new;
        g_old = g_new;
        p_old = p_new;
        x_new = x;
        f_new = f;
        g_new = problem.Grad(x);

        S(:,2:end) = S(:,1:end-1);
        Y(:,2:end) = Y(:,1:end-1);
        S(:,1) = x_new-x_old;
        Y(:,1) = g_new-g_old;        
        q = g_new;

        for i=1:min(iter-1,m)
            rh(i) = 1/dot(Y(:,i),S(:,i));
            al(i) = rh(i)*dot(S(:,i),q);
            q = q - al(i)*Y(:,i);
        end
        
        sty = dot(S(:,1),Y(:,1));
        yty = dot(Y(:,1),Y(:,1));
        r = sty/yty * q;
        
        for i=min(iter-1,m):-1:1
            be = rh(i)*dot(Y(:,i),r);
            r = r + S(:,i)*(al(i)-be);
        end
        
        p_new = -r;
        
    end
    
    % choose initial step
    if iter == 1
        alpha = 1/sum(abs(g_new));
    else
        % 1) choose initial step similar to previous step
        % 2) choose initial step by interpolating objective function
        %alpha = alpha*dot(g_old,p_old)/dot(g_new,p_new); % 1
        %alpha = 2*(f_new-f_old)/dot(g_new,p_new); %2\
        alpha = 1;
    end

    % update global variables
    g = g_new;
    p = p_new;
    
%...........................................................................
function Newton(problem,method)
% Newton method

    % global variables
    global f g x alpha p iter
    
    % construct linear system
    g = problem.Grad(x);
    H = problem.Hess(x);

    % solve linear system
    p = findminsolve(H,-g,method.LinearSolveMethod);
    alpha = 1;

    % require descent direction
    if dot(p,g) > 0
        print 'require descent'
        p = -g;
        alpha = 1/sum(abs(g));
    end
    
%...........................................................................
function GaussNewton(problem,method)
% Gauss-Newton method

    % global variables
    global x f g h alpha p iter
    
    % construct linear system
    r = problem.Resd(x);
    j = problem.Jacb(x);
    jtj = j'*j;
    g = j'*r;
    
    % solve linear system
    p = findminsolve(jtj,-g,method.LinearSolveMethod);
    alpha = 1;
    
    % require descent direction
    if dot(p,g) > 0
        p = -g;
        alpha = 1/sum(abs(g));
    end
    
%...........................................................................
function NewtonKrylov(problem,method)
% Newton-Krylov method

    % global variables
    global f g x alpha p iter
    
    % matrix-free solver
    g = problem.Grad(x);
    p = cgsolve(@(v)problem.Hv(x,v),-g);
    alpha = 1;

    % require descent direction
    if dot(p,g) > 0
        p = -g;
        alpha = 1/sum(abs(g));
    end
    