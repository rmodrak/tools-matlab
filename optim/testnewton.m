function steps = testnewton()

global N; N = 100;

method = getmethod('NewtonKrylov');
method.LinearSolveMethod = 'Krylov';
method.StepControl = 'LineSearch';
method.LineSearchMethod = 'Backtracking';
method.StopIterations = 10000;
method.StopTolerance = 1e-4;

% method = getmethod('QuasiNewton');
% method.StepControl = 'LineSearch';
% method.LineSearchMethod = 'Backtracking';
% method.StopIterations = 10000;
% method.StopTolerance = 1e-4;

steps = findmin(problem(), method);


function s = problem()
    global N
    s = struct( ...
        'nmod', N, ...
        'ndat', 2, ...
        'Func', @(x) func(x), ...
        'Resd', @(x) resd(x), ...
        'x0',   zeros(N,1));

function f = func(x)
    global N
    assert(length(x) == N)
    f = sum(100*(x(2:N)-x(1:N-1).^2).^2 + (1-x(1:N-1)).^2);
    
function r = resd(x)
    global N
    assert(len(x) == N)
    r = [10*(x(2:N)-x(1:N-1).^2); 1-x(1:N-1)];
    