function clim(f)
%CLIM Adjusts colormap limits.
%
%  see also CAXIS

try
    f = str2num(f);

    if f > 0
        % increase saturation
        axh = gca;
        clim = get(axh,'clim');
        set(axh,'clim',(1/f)*clim);
    
    elseif f < 0
        % decrease saturation'
        axh = gca;
        clim = get(axh,'clim');
        set(axh,'clim',-f*clim);

    elseif f == 0
        % make symmetric about zero
        axh = gca;
        clim = get(axh,'clim');
        set(axh,'clim', max(abs(clim(:))) * [-1,1]);
    end

catch
    disp({
         'f > 0 : increase saturation'
         'f < 0 : decrease saturation'
         'f = 0 : make symmetric about zero'
    });

end
