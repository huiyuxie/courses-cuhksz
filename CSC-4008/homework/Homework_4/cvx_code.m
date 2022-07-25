%% 3.10.1

% Use matrix A of size m by n and vector y of size n by 1 to solve the L^1
% minimization problem. Try different sets of values (alpha, beta) to recover 
% the vector x, and compute the error compared with x0.

%(1) Set alpha = 0.5, beta = 0.25;
%(2) Set alpha = 0.2, beta = 0.1;
%(3) Set alpha = 0.9, beta = 0.6;

%(1)--------------------------------
a = 0.5; b = 0.25; n = 200;

m = a * n; 
k = b * m;
A = normrnd(0, 1, [m, n]);

x1 = rand(n, 1);
x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
x0 = x1 .* x2;
y = A * x0;

cvx_begin quiet
    variable x(n)
    minimize norm(x, 1)
    subject to
        A * x == y;
cvx_end

e = norm(x - x0, 2);
fprintf(1,'The error of the recovered vector x is %g.\n', e);

%(2)--------------------------------
a = 0.2; b = 0.1; n = 200;

m = a * n; 
k = b * m;
A = normrnd(0, 1, [m, n]);

x1 = rand(n, 1);
x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
x0 = x1 .* x2;
y = A * x0;

cvx_begin quiet
    variable x(n)
    minimize norm(x, 1)
    subject to
        A * x == y;
cvx_end

e = norm(x - x0, 2);
fprintf(1,'The error of the recovered vector x is %g.\n', e);

%(3)-------------------------------
a = 0.9; b = 0.6; n = 200;

m = a * n; 
k = b * m;
A = normrnd(0, 1, [m, n]);

x1 = rand(n, 1);
x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
x0 = x1 .* x2;
y = A * x0;

cvx_begin quiet
    variable x(n)
    minimize norm(x, 1)
    subject to
        A * x == y;
cvx_end

e = norm(x - x0, 2);
fprintf(1,'The error of the recovered vector x is %g.\n', e);

%% 3.10.2

% For each set of values (m/n, k/n), randomly generate 200 L^1 minimization
% probles. In the problem, generate random Gaussian matrix A, vector x0,
% and compute vector y. Get the fraction of correct recoveries for each set 
% of values and plug the fraction values into the matrix. Plot the 'Phase 
% Transition in Sparse Recovery' graph based on the matrix. 

%(1) Set n = 50;
%(2) Set n = 100;
%(3) Set n = 200;
%(4) Set n = 400;

%(1)-----------------------------
n = 50;
P = zeros(n, n);

for m = 1 : n
    for k = 1 : n
        r = 0;
        for c = 1 : 200
            A = normrnd(0, 1, [m, n]);
            
            x1 = rand(n, 1);
            x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
            x0 = x1 .* x2;
            
            y = A * x0;
            
            cvx_begin quiet
                variable x(n)
                minimize norm(x, 1)
                subject to
                    A * x == y;
            cvx_end
            
            e = norm(x - x0, 2);
            if e <= 10^-6
                r = r + 1;
            end
        end
        P(m, n) = r / 200;
    end
end

imagesc(P) % Plot the graph

%(2)-------------------------------            
n = 100;
P = zeros(n, n);

for m = 1 : n
    for k = 1 : n
        r = 0;
        for c = 1 : 200
            A = normrnd(0, 1, [m, n]);
            
            x1 = rand(n, 1);
            x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
            x0 = x1 .* x2;
            
            y = A * x0;
            
            cvx_begin quiet
                variable x(n)
                minimize norm(x, 1)
                subject to
                    A * x == y;
            cvx_end
            
            e = norm(x - x0, 2);
            if e <= 10^-6
                r = r + 1;
            end
        end
        P(m, n) = r / 200;
    end
end            

imagesc(P) % Plot the graph
            
%(3)-----------------------------            
n = 200;
P = zeros(n, n);

for m = 1 : n
    for k = 1 : n
        r = 0;
        for c = 1 : 200
            A = normrnd(0, 1, [m, n]);
            
            x1 = rand(n, 1);
            x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
            x0 = x1 .* x2;
            
            y = A * x0;
            
            cvx_begin quiet
                variable x(n)
                minimize norm(x, 1)
                subject to
                    A * x == y;
            cvx_end
            
            e = norm(x - x0, 2);
            if e <= 10^-6
                r = r + 1;
            end
        end
        P(m, n) = r / 200;
    end
end

imagesc(P) % Plot the graph

%(3)-----------------------------            
n = 400;
P = zeros(n, n);

for m = 1 : n
    for k = 1 : n
        r = 0;
        for c = 1 : 200
            A = normrnd(0, 1, [m, n]);
            
            x1 = rand(n, 1);
            x2 = zeros(n, 1); x2(randi(n, k, 1)) = 1;
            x0 = x1 .* x2;
            
            y = A * x0;
            
            cvx_begin quiet
                variable x(n)
                minimize norm(x, 1)
                subject to
                    A * x == y;
            cvx_end
            
            e = norm(x - x0, 2);
            if e <= 10^-6
                r = r + 1;
            end
        end
        P(m, n) = r / 200;
    end
end

imagesc(P) % Plot the graph



