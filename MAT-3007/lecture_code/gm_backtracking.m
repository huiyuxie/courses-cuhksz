function x = gm_backtracking(x0,tol,gamma)

% build objective function and gradient
obj     = @(x) exp(x(1)+x(2))+x(1)^2+3*x(2)^2-x(1)*x(2);
grad    = @(x) [exp(x(1)+x(2))+2*x(1)-x(2);exp(x(1)+x(2))+6*x(2)-x(1)];

x       = x0;
f_old   = obj(x);
alpha   = 0;

fprintf(1,'- - - gradient method with armijo backtracking; n = %g\n',length(x));
fprintf(1,'ITER ; OBJ.VAL ; G.NORM ; STEP.SIZE\n');

for i = 1:20000
    x_old   = x;
    g       = grad(x);
    ng      = norm(g);
    
    fprintf(1,'[%4i] ; %1.6f ; %1.4e ; %1.2f\n',i,f_old,ng,alpha);
    
    if ng <= tol
        break
    end
    
    alpha   = 1;
    x       = x_old - alpha*g;
    f_new   = obj(x);
    acount  = 1;
    
    while f_new - f_old > -alpha*gamma*ng^2 && acount <= 100
        alpha   = alpha/2;
        x       = x_old - alpha*g;
        f_new   = obj(x);
        acount  = acount + 1;
    end
    
    f_old   = f_new;
end