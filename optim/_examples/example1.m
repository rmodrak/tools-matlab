function example1

    close all
    plot_sd
    plot_cg
    plot_newton


function plot_sd
% plots the steepest descent path for quadratic surface
    A =    [ 3  3;  3  9 ];
    xmin = [ 2 -0.25]';
    func = @(x) 0.5*(x-xmin)'*A*(x-xmin);

    n = 10;
    x = cell(n,1);
    x{1} = [0;0];

    for i = 2:n
       g = autograd(func,x{i-1});
       alpha = g'*g/(g'*A*g);
       x{i} = x{i-1} - alpha*g;
    end

    plot_path(func, cat(2,x{:}))
    export(gcf,'_figures/sd.eps')


function plot_cg
% plots the conjugate gradient path for quadratic surface
    A =    [ 3  3;  3  9 ];
    xmin = [ 2 -0.25]';
    func = @(x) 0.5*(x-xmin)'*A*(x-xmin);

    n = 3;
    x = cell(n,1);

    x0 = [0;0];
    g = autograd(func,x0);
    alpha = g'*g/(g'*A*g);

    x{1} = x0;
    x{2} = x{1} - alpha*g;
    x{3} = xmin;

    plot_path(func, cat(2,x{:}))
    export(gcf,'_figures/cg.eps')
    ! cp _figures/cg.eps _figures/qn.eps

function plot_newton
    A =    [ 3  3;  3  9 ];
    xmin = [ 2 -0.25]';
    func = @(x) 0.5*(x-xmin)'*A*(x-xmin);

    n = 2;
    x = cell(n,1);
    x{1} = [0;0];
    x{2} = xmin;

    plot_path(func, cat(2,x{:}))
    export(gcf,'_figures/newton.eps')


function plot_path(func, p)
    figure
    set(gcf,'color','white')
    resize(gcf,1.4,5)

    ezcontourf(@(x,y)func([x y]').^0.2,[-1,3,-1.5,1.5],100)
    colormap gray
    flipcmap
    caxis([0,1e3])

    noaxes
    hold on

    plot(p(1,:),p(2,:),'ko','markerfacecolor','black')
    plot(p(1,:),p(2,:),'k-','linewidth',3)

    axis equal
    box on
