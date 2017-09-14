function matrix(M)
%MATRIX Prints information about matrix.

% check input arguments
if ~ismatrix(M)
    disp('Not a matrix.')
    return
end

table = {
    'symmetric'         all(all(M == M.'))
    'Hermitian'         all(all(M == M'))
    'positive definite' isposdef(M)
    'diagally dominant' all(2*diag(M)-sum(M,2) > 0)
    'sparse'            issparse(M)
    };

for i=1:length(table)
    str1 = table{i,1};
    if table{i,2}
        str2 = 'yes';
    else
        str2 = 'no';
    end
    fprintf('%s ... ',str1)
    fprintf('%s',str2)
    fprintf('\n')
end
fprintf('\n')

function tf = isposdef(M)
try
    chol(M);
    tf = true;
catch
    tf = false;
end