
% max   8x1 + 5x2
%
% s.t.  9x1 + 5x2   <= 45
%       x1 + x2     <= 6
%       x1, x2 >= 0, x integer

f   = [-8;-5];
A   = [9,5;1,1];
b   = [45;6];

lb  = [0;0];
ub  = [Inf;Inf];

intcon = [1,2];

[x,fval,~,output] = intlinprog(f,intcon,A,b,[],[],lb,ub);

fprintf('x1 = %g, x2 = %g, optimal value = %2.2f; \n',x(1),x(2),-fval);


