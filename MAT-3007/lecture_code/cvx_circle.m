% number of points
k = 100;

% generate data points
Y = 10*rand(2,k) - 5;

% Solve the optimization problem
cvx_begin quiet
variables r x(2);
    minimize r
        subject to
            norms(x*ones(1,k)-Y,2,1) <= r*ones(1,k); 
            r >= 0;
cvx_end

% Plot the results
hold on;
axis equal
for i = 1:k
    plot(Y(1,i), Y(2,i),'r.','MarkerSize',12);
    hold on;
end

plot(x(1),x(2),'b.','MarkerSize',12);

alpha = 0:pi/50:2*pi;

plot(x(1)+r*cos(alpha),x(2)+r*sin(alpha),'b','LineWidth',1.5);

hold off;