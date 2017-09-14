function spqn(problem,method)
% a collection of sparse quasi-Newton routines

    % global variables
    global x f g h alpha p iter

    % local variables
    persistent x_new x_old f_new f_old g_new g_old p_new p_old LBFGS
    
    if iter == 1
        lbfgs = qninit(problem.dim_mod,method.QuasiNewtonStepMemory);
        x_new = x;
        f_new = f;
        g_new = problem.grad(x);
        p_new = -g_new;
    else
        x_old = x_new;
        f_old = f_new;
        g_old = g_new;
        p_old = p_new;
        x_new = x;
        f_new = f;
        g_new = problem.grad(x);
        
        % modification
        W = 0.0001*eye(problem.dim_mod);
        
        LBFGS = qnupdate(LBFGS,g_new-g_old,x_new-x_old);
        p_new = qnsolve(LBFGS,g_new,W);
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
    
    
%---------------------------------------------------------------------------
function x = qninit(n,m)
    
    % the number of optimization variables
    x.n     = n;

    % the number of correction pairs stored so far
    x.m     = 0;
    
    % the maximum number of correction pairs
    x.mmax  = m;
    
    % scaling factor for the initial Hessian approximation
    x.sigma = 1;

    % n x m matrix that stores the iterate differences
    x.S = zeros(n,0);
    
    % n x m matrix that stores the gradient differences
    x.Y = zeros(n,0);

    % m x m matrix containing the matrix product S'*S
    x.SS = [];
    
    % the diagonal of an m x m matrix in which the ith diagonal entry is
    % the dot product of the ith correction pair
    x.D  = [];
    
    % m x m matrix L containing the matrix product S'*Y
    x.L  = [];

% -------------------------------------------------------------------------
function p = qnsolve(x,b,W)

    m = x.m;
    
    if m == 0
        % In the case when no correction pairs have been added, then there
        % is very little that needs to be done.
        p = W \ (-b);
        
    else
        % compute the vector U
        U = [ x.Y x.sigma*x.S ];
        U = [ U; zeros(length(b) - x.n,2*m) ];

        % Apply the Sherman-Morrison-Woodbury formula to compute the final
        % solution. Here, we are effectively computing the inverse of W
        % plus a low-rank update U*V'. Most of the expense is contained in
        % the fifth step here, because it involves factorizing a dense 2m x
        % 2m matrix, and because it involves multiplying an n x 2m matrix
        % times an 2m x 2m matrix for a total cost of O(nm^2).
        factor = ldlfactor(W);
        p = ldlsolve(factor,-b);
        p = qnproduct(x,U'*p);
        CU = ldlsolve(factor,U);
        p = (eye(2*m) - qnproduct(x,U'*CU))\p;
        p = ldlsolve(factor,U*p - b);
    
    end

    
% -------------------------------------------------------------------------
function P = qnproduct (x, U)

    % Compute the subblocks of the factors of M.
    O  = zeros(x.m);
    D  = diag(sqrt(x.D));
    LD = x.L * diag(1./sqrt(x.D));

    % Compute the Cholesky factor; see equation (2.26) on p. 136 of
    % Byrd, Nocedal and Schnabel (1994).
    J = chol(x.sigma*x.SS + x.L*diag(sparse(1./x.D))*x.L','lower');

    % Perform a forward substitution and then a backward substitution
    % to obtain the desired product.
    P = [ -D LD'; O J' ] \ ([ D O; -LD J ] \ U);


% -------------------------------------------------------------------------
function x = ldlfactor(A)

    [x.L x.D x.P] = ldl(A,'matrix');
    
    
% -------------------------------------------------------------------------
function y = ldlsolve(x,b)

    %y = x.S * x.P * (x.L' \ (x.D \ (x.L \ (x.P' * x.S * b))));
    y = x.P * (x.L' \ (x.D \ (x.L \ (x.P' * b))));
