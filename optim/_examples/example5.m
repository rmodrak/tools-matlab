function example5

nn = 2;
mm = 10;


% generate misfit function and gradient from quadratic forms
f = cell(nn,1);
g = cell(nn,1);

for ii=1:nn
    a = randn(mm);
    a = a'*a;
    b = randn(mm,1);

    h = @(x) x'*a*x + b'*x;
    f{ii} = h;

    h = @(x) 2*a*x + b;
    g{ii} = h;
end



% utility functions

function y = evalfunc(f,x)
mm = length(f);
nn = length(x);
y = 0;
for ii=1:nn
    x = ones(mm,1);
    h = f{ii};
    y = y + h(x);
end


function z = evalgrad(f,x)
mm = length(f);
nn = length(x);
z = zeros(nn*mm,1);
for ii=1:nn
    x = ones(mm,1);
    h = f{ii};
    z = z + h(x);
end


function c = evalcov(g,x)
c = zeros(nn,nn);
for ii=1:nn
for jj=1:nn
    x = ones(mm,1);
    hi = g{ii};
    hj = g{jj};
    c(ii,jj) = dot(hi(x),hj(x))
end
end
