function findminplot(s)
%FINDMINPLOT Plots function minimization results.


% get input arguments
if nargin == 0 
if evalin('base',['exist(''evals'',''var'')'])
    s = evalin('base','evals');

elseif evalin('base',['exist(''steps'',''var'')'])
    s = evalin('base','steps');

else
    error('Nothing to plot.')
end
end

% create figure
%figure
hold on

% plot function evaluations in green
if isfield(s,'f')

    X = cat(1,s.f{:});
    n = size(X,2);
    options = {13,'g'};
    
    if n == 2
        findminplot2(X,options{:})
    elseif n == 3
        findminplot3(X,options{:})
    end
    
end

% plot gradient evaluations in magenta
if isfield(s,'g')

    X = cat(1,s.g{:});
    n = size(X,2);
    options = {9,'m'};
    
    if n == 2
        findminplot2(X,options{:})
    elseif n == 3
        findminplot3(X,options{:})
    end
    
end

% plot Hessian evaluations in cyan
if isfield(s,'h')

    X = cat(1,s.h{:});
    n = size(X,2);
    options = {5,'c'};
    
    if n == 2
        findminplot2(X,options{:})
    elseif n == 3
        findminplot3(X,options{:})
    end
    
end

% plot steps in black
if isfield(s,'x')

    X = cat(1,s.x{:});
    n = size(X,2);
    options = {9,'k'};
    
    if n == 2
        findminplot2(X,options{:})
    elseif n == 3
        findminplot3(X,options{:})
    end

end

%---------------------------------------------------------------------------
function findminplot2(X,MarkerSize,MarkerFaceColor)
%2D model space

x1 = X(:,1);    x2 = X(:,2);

plot(x1,x2, ...
    'LineStyle',        'None', ...
    'Marker',           'o', ...
    'MarkerEdgeColor',  'None', ...
    'MarkerSize',       MarkerSize, ...
    'MarkerFaceColor',  MarkerFaceColor)
        

%---------------------------------------------------------------------------
function findminplot3(X,MarkerSize,MarkerFaceColor)
%3D model space

x1 = X(:,1);    x2 = X(:,2);    x3 = X(:,3);

plot3(x1,x2,x3, ...
    'LineStyle',        'None', ...
    'Marker',           'o', ...
    'MarkerEdgeColor',  'None', ...
    'MarkerSize',       MarkerSize, ...
    'MarkerFaceColor',  MarkerFaceColor)
        