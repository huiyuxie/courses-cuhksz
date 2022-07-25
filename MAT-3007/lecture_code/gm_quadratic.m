function [x,obj,iter] = gm_quadratic(A,b,x0,eps)

% === INPUT ==========
% A      the positive definite matrix associated with the objective function
% b      a column vector associated with the linear part of the objective
%        function
% x0     initial point
% eps    tolerance parameter
% === OUTPUT =========
% x      an optimal solution of min 0.5*x^T A x + b^T x
% obj    the optimal function value up to a tolerance

x       = x0;
iter    = 0;
Ax      = A*x;
g       = Ax + b;
ng      = norm(g);

fprintf(1,'- - - gradient method for quadratic programs; n = %g\n',length(b));
fprintf(1,'ITER ; OBJ.VAL ; G.NORM ; STEP.SIZE\n');

% main loop
while ng > eps && iter < 25000
 iter   = iter + 1;
 Ag     = A*g;
 alpha  = ng^2 / (g'*Ag);
 x      = x - alpha*g;
 Ax     = Ax - alpha*Ag;
 g      = Ax + b;
 ng     = norm(g);
 
 fprintf(1,'[%4i] ; %2.6f ; %2.6f ; %1.2f\n',iter,0.5*x'*Ax+b'*x,ng,alpha);
end

obj    = 0.5*x'*Ax + b'*x;
