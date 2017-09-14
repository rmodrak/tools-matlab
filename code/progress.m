function p = progress(p,pnew)
%TEXTBAR Text progress bar.
%   P = TEXTBAR('init',TITLE) initializes progress bar.
%
%   P = TEXTBAR(P,PNEW) updates progress bar.

if nargout == 0
    error('Use output argument to save status.')
end

% length of bar
lmax = 50;

if strcmpi(p,'init')
  % initialize progress bar
  if nargin > 1
    title = pnew;
    fprintf(1,'\n   %s\n',title);
  else
    fprintf(1,'\n');
  end
  buffer = repmat(' ',1,lmax-4);
  fprintf(1,'  |-%s-|\n',buffer);
  fprintf(1,'%s','  ');
  p = 0;
  
else
  % update progress bar
  lold = ceil(p*lmax);
  lnew = ceil(pnew*lmax);
  dl = lnew - lold;
  if dl < 1
    dl = 0;
  elseif lold >= lmax
    return
  elseif lnew >= lmax
    dl = lmax - lold;
  end
  buffer = repmat('*',1,dl);
  fprintf(1,'%s',buffer);
  if pnew >= 1
    fprintf(1,'%s\n',' done');
  end
  p = pnew;

end
