function x = bisection(f, xl, xr, options)

fr  = f(xr); 
fl  = f(xl); 
sl = sign(fl);

if fl * fr > 0
    fprintf(1,'The input data not suitable!'); 
    x = [];
    return
end

if options.display
    fprintf(1, '\n- - - bisection algorithm; \n- - - [tol = %1.2e/ maxit = %4i]\n', options.tol, options.maxit);
    fprintf(1, 'ITER ; X ; |F(X)| ; |XR-XL|\n');
end

for i = 1 : options.maxit
    xm  = (xl + xr)/ 2; 
    fm  = f(xm);
    
    if options.display
        fprintf(1, '[%4i] ; %1.8e ; %1.2e ; %1.2e \n',i, xm, abs(fm), abs(xl - xr));
    end
    
    if abs(xl - xr) < options.tol 
        x = xm;
        return
    end
    
    if fm > 0
        if sl < 0
            xr = xm;
        else
            xl = xm;
        end
    else
        if sl < 0
            xl = xm;
        else
            xr = xm;
        end
    end
end