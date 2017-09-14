function method = getmethod(name)
%GETMETHOD Get optimization method structure.
%   GETMETHOD(NAME) returns a MATLAB structure corresponding to one of the
%   named optimization algorithms below.
%                                                                         
%   Optimization algorithms can be further customized by modifying the
%   options present within the main structure.
%
%   Not all combinations of options are valid. For example,
%   'LinearSolveMethod' can be used only with algorithms that involve
%   solution of a linear system, such as Netwon's method.
%                                                                           
%   GETMETHOD('help') prints help message.
%
%   GETMETHOD('options') prints fields and values that control the behavior
%   of the optimization algorithm.
%
%   Choose from among the following optimization algorithms:
%           SteepestDescent
%           ConjugateGradient
%           QuasiNewton
%           Newton
%           NewtonKrylov
%           GaussNewton 
%           GaussNewtonKrylov
%

if nargin == 0
    name = 'help';
end

switch name

    % print help message
    case 'help'
        help('getmethod')

    % list possible fields and values
    case 'options'
        printopts();
        
    % create method-dependent structure
    case {'SteepestDescent' 'sd'}
        method = SteepestDescent();

    case {'ConjugateGradient' 'cg'}
        method = ConjugateGradient();

    case {'QuasiNewton' 'qn' 'qnewton'}
        method = QuasiNewton();

    case {'Newton' 'newton'}
        method = Newton();

    case {'NewtonKrylov' 'nk'}
        method = NewtonKrylov();
    
    case {'GaussNewton' 'gn' 'gnewton'}
        method = GaussNewton();

    case {'GaussNewtonKrylov' 'gnk'}
        method = GaussNewtonKrylov();
    
    otherwise
        error(badopt(name))

end

%...........................................................................
function printopts()
    fprintf('   The following options control the behavior of the optimization        \n');   
    fprintf('   algorithm:                                                            \n');
    fprintf('                                                                         \n');
    fprintf('                     Method: [ SteepestDescent   | ...                   \n');
    fprintf('                               ConjugateGradient | ...                   \n');
    fprintf('                               QuasiNewton       | ...                   \n');
    fprintf('                               Newton | NewtonKrylov | ...               \n');
    fprintf('                               GaussNewton | GaussNewtonKrylov ]         \n');
    fprintf('                                                                         \n');
    fprintf('                StepControl: [ None | LineSearch | TrustRegion ]         \n');
    fprintf('                                                                         \n');
    fprintf('             StopIterations: [ positive scalar ]                         \n');
    fprintf('              StopTolerance: [ positive scalar ]                         \n');
    fprintf('                                                                         \n');
    fprintf('    ConjugateGradientMethod: [ FletcherReeves | PolakRibiere ]           \n');
    fprintf('           RestartThreshold: [ positive scalar ]                         \n');
    fprintf('          RestartIterations: [ positive scalar ]                         \n');
    fprintf('                                                                         \n');
    fprintf('      QuasiNewtonStepMemory: [ positive scalar ]                         \n');
    fprintf('                                                                         \n');
    fprintf('           LineSearchMethod: [ Backtracking | Brent | MoreThuente ]      \n');
    fprintf('             DecreaseFactor: [ positive scalar ]                         \n');
    fprintf('            CurvatureFactor: [ positive scalar ]                         \n');
    fprintf('        BacktrackingFactors: [ positive scalars ]                        \n');
    fprintf('                                                                         \n');
    fprintf('          LinearSolveMethod: [ Cholesky | Krylov | ModifiedCholesky ]    \n');
    %fprintf('       PreconditionerMethod: [ None | L-BFGS ]                           \n');
    %fprintf('   PreconditionerStepMemory: [ positive scalar ]                         \n');
    fprintf('                                                                         \n');

    
%...........................................................................
function method = SteepestDescent()
    Method = 'SteepestDescent';
    StopIterations = 100;
    StopTolerance = 1e-5;
    StepControl = 'LineSearch';
    LineSearchMethod = 'Backtracking';
    DecreaseFactor = 1e-4;
    CurvatureFactor = 0.9;
    DecreaseFactor = 0.1;
    CurvatureFactor = 0.5;
    pickle('method');

%...........................................................................
function method = ConjugateGradient()
    Method = 'ConjugateGradient';
    StopIterations = 100;
    StopTolerance = 1e-5;
    StepControl = 'LineSearch';
    ConjugateGradientMethod = 'PolakRibiere';
    RestartThreshold = 0.1;
    RestartIterations = Inf;
    LineSearchMethod = 'Backtracking';
    DecreaseFactor = 1e-4;
    CurvatureFactor = 0.9;

    pickle('method');

%...........................................................................
function method = QuasiNewton()
    Method = 'QuasiNewton';
    StopIterations = 100;
    StopTolerance = 1e-5;
    StepControl = 'LineSearch';
    QuasiNewtonMethod = 'L-BFGS';
    QuasiNewtonStepMemory = 5;
    LineSearchMethod = 'Backtracking';
    DecreaseFactor = 1e-4;
    CurvatureFactor = 0.9;

    pickle('method');

%...........................................................................
function method = Newton()
    Method = 'Newton';
    StopIterations = 100;
    StopTolerance = 1e-5;
    StepControl = 'LineSearch';
    LinearSolveMethod = 'TruncatedSingluarValue';
    LineSearchMethod = 'Backtracking';
    DecreaseFactor = 1e-4;
    CurvatureFactor = 0.9;
    
    pickle('method');

%...........................................................................
function method = GaussNewton()
    Method = 'GaussNewton';
    StopIterations = 100;
    StopTolerance = 1e-5;
    StepControl = 'LineSearch';
    LinearSolveMethod = 'TruncatedSingluarValue';
    LineSearchMethod = 'Backtracking';
    DecreaseFactor = 1e-4;
    CurvatureFactor = 0.9;
    
    pickle('method');
%...........................................................................
function method = NewtonKrylov()
    Method = 'NewtonKrylov';
    StopIterations = 100;
    StopTolerance = 1e-5;
    StepControl = 'LineSearch';
    %Preconditioner = 'None';
    %QuasiNewtonStepMemory = 2;

    pickle('method');
    
%...........................................................................
function method = GaussNewtonKrylov()
    error('Not yet implemented.')

