
% max   8x1 + 11x2 + 6x3 + 4x4
%
% s.t.  5x1 + 7x2 + 4x3 + 3x4   <= 14
%       x binary

f   = [-8;-11;-6;-4]; 
A   = [5,7,4,3];
b   = 14;

lb  = [0;0;0;0];
ub  = [1;1;1;1];

intcon = [1,2,3,4];

[x,fval,~,output] = intlinprog(f,intcon,A,b,[],[],lb,ub);

fprintf('x1 = %g, x2 = %g, x3 = %g, x4 = %g, optimal value = %2.2f; \n',x(1),x(2),x(3),x(4),-fval);


