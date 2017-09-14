function notoolbar(fgh)
%NOTOOLBAR Hides toolbar GUI element.

defval('fgh',gcf)
set(fgh,'Toolbar','none')
