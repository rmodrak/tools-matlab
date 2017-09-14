clear global

problem = getproblem('Box3D');
method = getmethod('NewtonKrylov');

method.LinearSolveMethod = 'Krylov';
method.StepControl = 'LineSearch';
method.LineSearchMethod = 'Backtracking';
method.StopIterations = 10000;
method.StopTolerance = 1e-4;

steps = findmin(problem,method);
findminplot(evals)
