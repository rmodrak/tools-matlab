function varargout = syspath()
%SYSPATH Print system path.

error(nargchk(0,0,nargin))

if nargout == 0
    disp(getenv('PATH'))
elseif nargout == 1
    varargout{1} = getenv('PATH');
else
    error('Too many output arguments.')
end