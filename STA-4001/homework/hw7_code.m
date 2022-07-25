%% 7.6

% Use accept-reject method to generate arrival times which follows a
% non-homogeneous Poisson process. The value of A can be change and here
% choose A=2.

u0 = [0.15386 0.89607 0.15657 0.61391 0.80390];
u1 = [0.58126 0.27798 0.15661 0.26974 0.22975];

n = length(u0);
A = 2;  
g = -(1/A) * log(u0);
h = cumsum(g);
k = zeros(n, 1);

for i = 1:n
    if u1(i) < (h(i)/A)
        k(i) = h(i);
    end
end

disp(k)
        