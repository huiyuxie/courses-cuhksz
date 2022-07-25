%% A3.4(a)

A = [-2 3 -4 5;
    3 -4 5 -6;
    -4 5 -6 7;
    5 -6 7 -8];
b = [1; 1; 1; 1];

cvx_begin quiet
variables t x(4);
    maximize t;
    subject to
    A * x >= t * b;
    b'* x == 1;
    x >= 0;
cvx_end
  
cvx_optval
t
x

% part of A3.4(d)

cvx_begin quiet
variables t y(4);
    maximize t;
    subject to
    (-A) * y >= t * b;
    b'* y == 1;
    y >= 0;
cvx_end

cvx_optval
t
y
%% A3.4(b)

cvx_begin quiet
variables m y(4);
    minimize m;
    subject to
    A'* y >= m *(-b);
    (-b)'* y == 1;
    y <= 0;
cvx_end

cvx_optval
m
y
%% A3.4(d)

A = [-2 3;
     3 -4];
b = [1; 1];

cvx_begin quiet
variables t x(2);
    maximize t;
    subject to
    A * x >= t * b;
    b'* x == 1;
    x >= 0;
cvx_end

cvx_optval
t
x

cvx_begin quiet
variables t y(2);
    maximize t;
    subject to
    (-A) * y >= t * b;
    b'* y == 1;
    y >= 0;
cvx_end

cvx_optval
t
y
%% A3.5

m = 100;
A = [ones(m), ones(m)];
b = (1:m)';
bt = 1:m;
n = size(A, 2);

% primal problem

t1 = cputime;
cvx_begin quiet
variables x(n) t;
    minimize t;
    subject to
    A * x - b <= t * ones([m, 1]);
    (-A)* x + b <= t * ones([m, 1]);
    cvx_end
t2 = cputime;

tp = t2 - t1;
[cvx_optval tp]

% dual problem

t1 = cputime;
cvx_begin quiet
variables y(m);
    maximize bt * y;
    subject to
    A'* y == 0;
    sum(abs(y)) <= 1;
    cvx_end
t2 = cputime;

td = t2 - t1;
[cvx_optval td]