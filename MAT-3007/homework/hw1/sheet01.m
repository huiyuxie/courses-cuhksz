%% Code A1.2

cvx_begin quiet
variables x1 x2
    maximize 8 * x1 + 7 * x2
        subject to
            (1/3) * x1 + (1/4) * x2 <= 100;
            (1/5) * x1 + (1/4) * x2 <= 70;
            [x1 x2] >=0;
cvx_end

[x1 x2]
cvx_optval
%% Code A1.3

A = [0 11 8 0 0 0;
    0 0 10 12 0 0;
    0 1 0 0 11 0;
    0 0 4 0 0 15;
    0 0 0 7 0 4;
    0 0 0 0 0 0];
B = [0 0 0 1 1 1];
C = [0 0 0 0 0 1]';

cvx_begin quiet
variables x(6,6)
    maximize sum(sum(B * x * C))
        subject to
            x <= A;
            x >= 0;
            sum(x(2:5, :), 2) - sum(x(:, 2:5))' == 0;
cvx_end

x
cvx_optval