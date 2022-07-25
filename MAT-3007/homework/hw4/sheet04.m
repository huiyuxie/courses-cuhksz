%% A4.2(a)

cvx_begin quiet
variables x1 x2 x3;
    maximize 3300 * x1 + 2000 * x2 + 5000 * x3;
    subject to
        2 * x1 + x2 + x3 <= 250;
        3 * x1 + x2 + 2 * x3 <= 150;
        x1 + 2 * x2 + 4 * x3 <= 160;
        [x1 x2 x3] >= 0;
cvx_end

cvx_optval
[x1 x2 x3]
%% A4.2(b)

cvx_begin quiet
variables y1 y2 y3;
    minimize 250 * y1 + 150 * y2 + 160 * y3;
    subject to
        2 * y1 + 3 * y2 + y3 >= 3300;
        y1 + y2 + 2 * y3 >= 2000;
        y1 + 2 * y2 + 4 * y3 >= 5000;
        [y1 y2 y3] >= 0;
cvx_end

cvx_optval
[y1 y2 y3]