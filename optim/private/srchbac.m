function [x_new,f_new,alpha_new] = srchbac(func,x0,f0,g0,alpha,c1,c2,b1,b2,max_iter)

    % suggested parameter values
    % c1 = 1e-4
    % c2 = 0.9
    % b1 = 0.1
    % b2 = 0.5

    % try initial step
    alpha_new = alpha;
    x_new = x0 + alpha_new;
    f_new = func(x_new);
    if f_new + c1*alpha_new*g0 < f0,
        return; 
    end

    % try quadratic interpolation
    alpha_old = alpha_new;
    alpha_new = - g0*alpha_old^2 / (2*(f_new-f0-alpha_old*g0));
    
    if alpha_new > b2*alpha_old, 
        alpha_new = b2*alpha_old; 
    elseif alpha_new < b1*alpha_old, 
        alpha_new = b1*alpha_old; 
    end

    x_new = x0 + alpha_new;
    f_old = f_new;
    f_new = func(x_new);
    if f_new + c1*alpha_new*g0 < f0,
        return; 
    end

    for iter = 3:max_iter
    
        % try cubic interpolation
        u1 = (alpha_old^2 * alpha_new*2 * (alpha_new-alpha_old)).^-1;
        u2 = [ alpha_old^2, -alpha_new^2; ...
              -alpha_old^3,  alpha_new^3 ];
        u3 = [ f_new-f0 - g0*alpha_new; ...
               f_old - f0 - g0*alpha_old ];
        v = u1*u2*u3;

        alpha_old = alpha_new;
        alpha_new = (-v(2) + sqrt(v(2)^2-3*v(1)*g0))/(3*v(1));

        if alpha_new > b2*alpha_old, 
            alpha_new = b2*alpha_old; 
        elseif alpha_new < b1*alpha_old, 
            alpha_new = b1*alpha_old; 
        end

        x_new = x0 + alpha_new;
        f_old = f_new;
        f_new = func(x_new);
        if f_new + c1*alpha_new*g0 < f0,
            return;
        end
    
    end

    % line search failed
    error('Failed to satisfy decrease condition within max iterations.')
    