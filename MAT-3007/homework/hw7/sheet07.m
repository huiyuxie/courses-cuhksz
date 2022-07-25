%% A7.1(a)

f_obj = @(x1, x2) 100 * (x2 - x1^2)^2 + (1 - x1)^2;
f_grad = @(x1, x2) [400 * x1^3 - 400 * x1 * x2 + 2 * x1 - 2; 200 * x2 - 200 * x1^2];
f_hess = @(x1, x2) [1200 * x1^2 - 400 * x2 + 2, -400 * x1; -400 * x1, 200];

opts.maxit = 100;
opts.gamma = 0.5;

x0 = [2; 5];
tol = 1e-6;

[x, iter, obj, trace] = globnewton(f_obj, f_grad, f_hess, x0, tol, opts);
%% A7.1(b)

trace = trace(:, 1 : iter);
xs = repmat(x, 1, iter);
xnorm = norms(trace - xs);
k = 1 : iter;
semilogy(k, xnorm)
title("Log Plot --- Globalized Newton")
xlabel("k")
ylabel("||xk-x*||")
%% A7.1(c)

opts.maxit = 1e6;
opts.gamma = 0.5;

x0 = [2; 5];
tol = 1e-6;

[x, iter, obj, trace] = gradient(f_obj, f_grad, x0, tol, opts);

trace = trace(:, 1 : iter);
xs = repmat(x, 1, iter);
xnorm = norms(trace - xs);
k = 1 : iter;
semilogy(k, xnorm)
title("Log Plot --- Gradient")
xlabel("k")
ylabel("||xk-x*||")
%% A7.2

% S
f = [-2; -1];
A = [-3 2; -1 -2; 5 2];
b = [5; -2; 17];
[x, fval] = linprog(f, A, b, [], [], [], []);
% S1
lb = [-Inf; -Inf];
ub = [1; 4];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S2
lb = [-Inf; 5];
ub = [1; Inf];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S3
lb = [2; -Inf];
ub = [Inf; 4];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S5
lb = [2; -Inf];
ub = [Inf; 3];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S7
lb = [2; -Inf];
ub = [2; 3];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S8
lb = [3; -Inf];
ub = [Inf; 3];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S6
lb = [2; 4];
ub = [Inf; 4];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
% S4
lb = [2; 5];
ub = [Inf; Inf];
[x, fval] = linprog(f, A, b, [], [], lb, ub);
%% A7.3(b)

% Solve the interger program
f = [-2; -2; -1; -1; -3; -3; -2; -2; -1; -1; -4; -4; -2; -2];
A1 = zeros(7, 14);
for i = 1 : 7
    A1(i, 2 * i -1 : 2 * i) = 1;
end
b1 = ones(7, 1);
A2 = [2 0 0.5 0 0.5 0 0.1 0 0.5 0 1 0 1.5 0; 0 2 0 0.5 0 0.5 0 0.1 0 0.5 0 1 0 1.5];
b2 = [3; 2];

A = [A1; A2];
b = [b1; b2];
lb = zeros(14, 1);
ub = ones(14, 1);
intcon = 1 : 14;
    
[x, fval] = intlinprog(f, intcon, A, b, [], [], lb, ub);

% Solve the relaxation linear program
[x, fval] = linprog(f, A, b, [], [], lb, ub);



