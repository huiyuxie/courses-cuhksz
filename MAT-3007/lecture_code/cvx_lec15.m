
% Solve the optimization problem
cvx_begin quiet
variables x1 x2

minimize( (x1-1)^2 + (x2-1)^2 )
subject to
    x1 + x2 == 1;
cvx_end

fprintf(1,'x1 = %g, x2 = %g, opt-val = %g\n',x1,x2,cvx_optval);


% Solve the optimization problem
cvx_begin quiet
variables x1 x2

minimize( exp(x1+x2) + (x1-0.5*x2)^2 + 2.75*x2^2 )
subject to
    x1 + 2*x2 == 1;
cvx_end

fprintf(1,'x1 = %g, x2 = %g, opt-val = %g\n',x1,x2,cvx_optval);