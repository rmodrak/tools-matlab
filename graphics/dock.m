function dock(fgh)
%DOCK Docks figure window.

defval('fgh',gcf)
set(fgh,'WindowStyle','docked')
