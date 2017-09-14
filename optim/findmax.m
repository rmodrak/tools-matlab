function steps = findmax(varargin)
%FINDMAX Finds a local maximum of a function.
%   STEPS = FINDMIN(PROBLEM,METHOD[,STEPS]) finds a local maximum using
%   given PROBLEM and METHOD structures and appends a record of model steps
%   and function evaluations to STEPS.
error('Not yet implemented.')


% prepare input for findmin
[problem,method,steps] = findminargs(varargin{:});

if isfield(problem,'func')
    problem.func = @(x) -problem.func(x);
end

if isfield(problem,'grad')
    problem.grad = @(x) -problem.grad(x);
end

if isfield(problem,'hess')
    problem.hess = @(x) -problem.hess(x);
end

if isfield(problem,'resd')
    problem.resd = @(x) -problem.resd(x);
end

if isfield(problem,'jacb')
    problem.jacb = @(x) -problem.jacb(x);
end


% call findmin
steps = findmin(problem,method,steps);


% undo changes
if isfield(problem,'func')
    problem.func = @(x) -problem.func(x);
end

if isfield(problem,'grad')
    problem.grad = @(x) -problem.grad(x);
end

if isfield(problem,'hess')
    problem.hess = @(x) -problem.hess(x);
end

if isfield(problem,'resd')
    problem.resd = @(x) -problem.resd(x);
end

if isfield(problem,'jacb')
    problem.jacb = @(x) -problem.jacb(x);
end

