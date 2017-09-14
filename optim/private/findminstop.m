function stop = findminstop(problem,method,steps)
%FINDMINSTOP checks stopping conditions

try
    StopTolerance = method.StopTolerance;
catch
    StopTolerance = 1e-6;
end

if 0
    disp(length(steps))
end

x1 = steps.x{end-1};
f1 = steps.f{end-1};

x2 = steps.x{end};
f2 = steps.f{end};

tolx = norm(x2-x1);
tolf = abs(f2-f1);

if tolx < StopTolerance
    stop = true;
else
    stop = false;
end