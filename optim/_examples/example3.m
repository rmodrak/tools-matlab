function quadratic_3
% compares gradient- and Hessian-based solutions for partial-rank problems 
% (SVD regularization)

for i=1:100

    G = rand(14,16);
    d = rand(14,1);

    problem.nmod = 16;
    problem.ndat = 14;
    problem.Func = @(m) norm(G*m-d).^2;
    problem.Resd = @(m) d-G*m;

    method = getmethod('Newton');
    method.LinearSolveMethod = 'TruncatedSingluarValue';
    method.StepControl = 'LineSearch';
    method.LineSearchMethod = 'MoreThuente';
    method.StopIterations = 1e3;
    method.StopTolerance = 1e-10;
    steps = findmin(problem,method);
    xnewton = steps.x{end};
    
    method = getmethod('ConjugateGradient');
    method.StepControl = 'LineSearch';
    method.LineSearchMethod = 'MoreThuente';
    method.StopIterations = 1e3;
    method.StopTolerance = 1e-10;
    steps = findmin(problem,method);
    xcg = steps.x{end};
    
    disp(norm(xcg - xnewton));
    disp('');
    
    ej = zeros(problem.nmod,1);
    ej(1) = 1;
    H = autohess(@(x)autograd(problem.Func,x),xcg');
    tol = 1e-9;
    figure
    pimage(pinv(H,tol)*H*ej);
    
    figure
    pimage(eye(problem.nmod)*H*ej)
    
    close all

end
