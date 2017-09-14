function [problem,method,steps] = initialize(varargin)
%FMCHECK processes input arguments

clear global functions
global x f g h alpha p iter

%...........................................................................
% step 1: get input arguments from varargin

if nargin <= 1
    error('Not enough input arguments.')
    
elseif nargin == 2
    
    old.problem = varargin{1};
    old.method = varargin{2};
    steps = struct( ...
        'x',{{}},'f',{{}},'g',{{}},'h',{{}});

elseif nargin == 3
    
    old.problem = varargin{1};
    old.method = varargin{2};
    steps = varargin{3};
    
end

%...........................................................................
% step 2: check 'method'

try
    Method = old.method.Method;
catch
    error('Required field does not exist\n%s','Method');
end

MethodList = {...
    'SteepestDescent' 
    'ConjugateGradient'
    'QuasiNewton'
    'Newton'
    'NewtonKrylov'
    'GaussNewton'
    'GaussNewtonKrylov'
    };

if ~ismember(Method,MethodList)
    error(badopt(Method))
end

%...........................................................................
% step 3: process 'problem' fields

% 'func' or 'resd' must have been supplied
if ismember(Method, {'SteepestDescent' 'ConjugateGradient' 'QuasiNewton' ...
        'Newton' 'NewtonKrylov'})
    if isfield(old.problem,'Func')
        new.problem.Func = old.problem.Func;
    elseif isfield(old.problem,'Resd')
        new.problem.Resd = old.problem.Resd;
        new.problem.Func = @(x) norm(new.problem.Resd(x),2);
    else
        error('FUNC not found.')
    end
elseif ismember(Method, {'GaussNewton' 'GaussNewtonKrylov'})
    if isfield(old.problem,'resd')
        new.problem.Resd = old.problem.Resd;
    else
        error('RESD not found.')
    end
    new.problem.Func = @(x) norm(new.problem.Resd(x),2);
end

% create 'grad' and 'jacb' if not supplied
if ismember(Method, {'SteepestDescent' 'ConjugateGradient' 'QuasiNewton' ...
        'Newton' 'NewtonKrylov'})
    if isfield(old.problem,'Grad')
        new.problem.Grad = old.problem.Grad;
    else
        new.problem.Grad = @(x) autograd(new.problem.Func,x);
    end
elseif ismember(Method, {'GaussNewton' 'GaussNewtonKrylov'})
    if isfield(old.problem,'Jacb')
        new.problem.jacb = old.problem.jacb;
    else
        new.problem.jacb = @(x) autojacb(new.problem.Resd,x);
    end
    new.problem.Grad = @(x) new.problem.jacb(x)*new.problem.Resd(x);
end

% create 'hess' if required
if ismember(Method, {'Newton'})
    if isfield(old.problem,'Hess')
        new.problem.Hess = old.problem.Hess;
    else
        new.problem.Hess = @(x) autohess(new.problem.Grad,x);
    end
end

% create 'Hv' if required
if ismember(Method, {'NewtonKrylov'})
    if isfield(old.problem,'Hv')
        new.problem.Hv = old.problem.Hv;
    else
        new.problem.Hv = @(x,v) autohv(new.problem.Grad,x,v);
    end
end

% create 'Jv' if required
if ismember(Method, {'GaussNewtonKrylov'})
    if isfield(old.problem,'Jv')
        new.problem.Jv = old.problem.Jv;
    else
        new.problem.Jv = @(x,v) autojv(new.problem.Resd,x,v);
    end
end

% nmod, ndat
if isfield(old.problem,'nmod')
    new.problem.nmod = old.problem.nmod;
end
if isfield(old.problem,'ndat')
    new.problem.ndat = old.problem.ndat;
end
%...........................................................................
% step 4: assign starting model

if nargin == 2
    try
        if isfield(old.problem,'x0')
            x = old.problem.x0;
        else
            x = zeros(1,new.problem.nmod);
        end
        if ~isvector(x)
            error('x0 must be a vector.')
        end
        if ~iscolumn(x)
            x = x.';
        end
        steps.x = {x.'};
    catch
        error('x0 not assigned.');
    end    
    try
        f = feval(new.problem.Func,x);
        steps.f = {f};
    catch
        error('f0 not assigned.');
    end
elseif nargin == 3
    try
        x = steps.x{end}.';
    catch
        error('x0 not assigned.');
    end
    try
        f = steps.f{end};
    catch
        error('f0 not assigned.');
    end
end

%...........................................................................
% step 5: process 'method' fields

if 1
    new.method = old.method;
end

%...........................................................................
% step 6: set up evaluation monitor

if 1
    
    fields = {'f',{{}},'g',{{}},'h',{{}},'r',{{}},'j',{{}}};
    evals = struct(fields{:});
    assignin('base','evals',evals)

    new.problem.Func = @(x) evalfunc(new.problem.Func,x);
    new.problem.Grad = @(x) evalgrad(new.problem.Grad,x);
    if isfield(new.problem,'Hess')
        new.problem.Hess = @(x) evalhess(new.problem.Hess,x);
    end
    if isfield(new.problem,'Resd')
        new.problem.Resd = @(x) evalresd(new.problem.Resd,x);
    end
    if isfield(new.problem,'Jacb')
        new.problem.jacb = @(x) evaljacb(new.problem.jacb,x);
    end
    
end

method = new.method;
problem = new.problem;

% wrappers for keeping track of function evaluations

function f = evalfunc(Func,x)
    assignin('base','x',x);
    evalin('base','evals.f{end+1} = x.'';')
    evalin('base','clear x')
    f = feval(Func,x);

function g = evalgrad(Grad,x)
    assignin('base','x',x);
    evalin('base','evals.g{end+1} = x.'';')
    evalin('base','clear x')
    g = feval(Grad,x);

function H = evalhess(Hess,x)
    assignin('base','x',x);
    evalin('base','evals.h{end+1} = x.'';')
    evalin('base','clear x')
    H = feval(Hess,x);

function r = evalresd(Resd,x)
    assignin('base','x',x);
    evalin('base','evals.r{end+1} = x.'';')
    evalin('base','clear x')
    r = feval(Resd,x);

function J = evaljacb(Jacb,x)
    assignin('base','x',x);
    evalin('base','evals.j{end+1} = x.'';')
    evalin('base','clear x')
    J = feval(Jacb,x);
