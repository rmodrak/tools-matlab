function quadratic_2
% compares gradient- and Hessian-based solutions for full rank problems

for i=1:100

    G = rand(16);
    d = rand(16,1);

    problem.nmod = 16;
    problem.ndat = 16;
    problem.Func = @(m) norm(G*m-d).^2;
    problem.Resd = @(m) d-G*m;

    method = getmethod('Newton');
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
    
end
