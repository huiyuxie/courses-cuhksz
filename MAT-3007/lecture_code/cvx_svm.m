clc;

% Define the dimension of the problem
d = 2;

% Number of points in A = +1
n = 10;

% Number of points in B = -1
m = 10;

% Generate points in A and B
X               = zeros(d, n+m);
X(:,1:n)        = randn(d, n) + [-ones(1, n); ones(1, n)];
X(:,n+1:end)    = randn(d, m) + [ones(1, m); -ones(1, m)];

y               = zeros(n+m,1);
y(1:n)          = 1;
y(n+1:end)      = -1;


% Solve the optimization problem
cvx_begin quiet
variables t(n+m) w(2) b;
    minimize ones(1,n+m) * t
        subject to
            y .* (X' * w + ones(n+m,1) * b) + t >= ones(n+m,1);
            t >= 0;
cvx_end

xmin = min(min(X(1, :))) - 0.1;
xmax = max(max(X(2, :))) + 0.1;
ymin = (-b - w(1) * xmin)/w(2);
ymax = (-b - w(1) * xmax)/w(2);


% Plot the results
hold on;

plot([xmin, xmax],[ymin, ymax],'LineWidth',1.5);

for i = 1:n
    plot(X(1,i), X(2,i), 'bs');
    hold on;
end

for j = 1:m
    plot(X(1,j+n), X(2,j+n), 'r.','MarkerSize',12);
    hold on;
end

hold off;
