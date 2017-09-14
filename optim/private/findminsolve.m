function x = findminsolve(A,b,opt)
%FMSOLVE solves linear system

% check input arguments
if ~ismatrix(A)
    error('First argument must be a matrix.')
elseif ~isvector(b)
    error('Second argument must be a vector.')
end

if ~iscolumn(b)
    b = b.';
end
if size(A,2) ~= size(b,1)
    error('Inner matrix dimensions must agree.')
end


% solve linear system
switch opt
    case 'Cholesky'
        % Cholesky method without modification
        x = Cholesky(A,b);
        
    case 'ModifiedCholesky'
        % Cholesky method with positive definite modification        
        error('Not yet implemented.')
        
    case 'Krylov'
        % linear conjugate gradient method
        x = cgs(A,b);

    case 'ModifiedSpectral'
        [v,d] = eig((h+h')/2);
        d = diag(d);
        d = max(abs(d),max(max(abs(d)),1)*1e-12);
        x = -v*((v'*g)./d);
        
    case 'TruncatedSingluarValue'
        tol = 1e-9;
        x = pinv(A,tol)*b;
    
    otherwise
        error(badopt(opt))

end
