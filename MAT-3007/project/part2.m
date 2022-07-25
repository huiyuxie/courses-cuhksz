%% Part2 (Q1)

% 1) Transform city image 1024 * 1024 to mosaic, by 12 circle tiles 40 * 40 
%    or 8 symbol tiles 64 * 64
% 2) Transform mountain image 1024 * 1024 to mosaic, by 12 circle tiles 40 * 40
%    or 8 symbol tiles 64 * 64
% 3) Transform bluestreet image 1024 * 1024 to mosaic, by 12 circle tiles 40 * 40
%    or 8 symbol tiles 64 * 64

% When use circle tiles, rescale the original image to 960 * 960 
% When use symbol tiles, keep the original image as 1024 * 1024

m1 = 960; n1 = 960;
% m1 = 1024; n1 = 1024;
s = 40; t = 12; % use circle tiles
% s = 64; t = 8; % use symbol tiles
m2 = m1 / s; n2 = n1 / s;
k = (m2 * n2) / t;
image_A = imread("./test_images/1024_1024_city.jpg"); 
% address choice "./test_images/1024_1024_city.jpg", "./test_images/1024_1024_mountain.jpg", "./test_images/1024_1024_bluestreet.png"
gray_A = rgb2gray(image_A);
array_A = imresize(gray_A, [m1, n1]);
% imshow(gray_A, []);

c = zeros(1, t);
tiles = zeros(s, t * s);
for i = 1 : t
    add_name = strcat("./test_tiles/circles_16/circle_", num2str(i), ".png"); 
    % address choice "./test_tiles/circles_16/circle_", num2str(i), ".png", "./test_tiles/symbols_64/symbol_", num2str(i), ".png"
    tile = imread(add_name);
    tile = rgb2gray(tile);
    tile = imresize(tile, [s, s]);
    range = (i - 1)* s + 1 : i * s;
    tiles( : , range) = tile;
    c(i) = tile(s / 2, s / 2); % use code here when use circle tiles
    % c(i) = sum(sum(tile)) / s^2; % use code here when use symbol tiles
end
beta = zeros(1, m2 * n2);
num = 0;
for i = 1 : s : m1
    for j = 1 : s : n1
        num = num + 1;
        sub_A = array_A(i : (i + s - 1), j : (j + s - 1));
        beta(num) = mean(sub_A( : ));
    end
end

A1 = zeros(m2 * n2, t * m2 * n2);
[row, ~] = size(A1);
for i = 1 : row
    range = (i - 1)* t + 1 : i * t;
    A1(i, range) = 1;
end
A2 = zeros(t, t * m2 * n2);
[row, col] = size(A2);
for i = 1 : row
    range = i : t : col;
    A2(i, range) = 1;
end

f = zeros(1, t * m2 * n2);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        val = (c(i) - beta(j))^2;
        f(num) = val;
    end
end

Aeq = sparse([A1; A2]);
beq = [ones(m2 * n2, 1); k * ones(t, 1)];
lb = zeros(t * m2 * n2, 1);
ub = ones(t * m2 * n2, 1); 

options = optimoptions('linprog', 'Algorithm', 'dual-simplex');
t1 = cputime;
[x, fval, exitflag, output] = linprog(f, [], [], Aeq, beq, lb, ub, options);
t2 = cputime;
run_time = t2 - t1;

array_M1 = zeros(t * m2 * n2, 1);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        gray = c(i) * x(num);
        array_M1(num) = gray;
    end
end
array_M2 = zeros(m2, n2);
for i = 1 : m2 * n2
    range = (i - 1)* t + 1 : i * t;
    gray = sum(array_M1(range));
    if mod(i, n2) == 0
        row = floor(i / n2);
        col = n2;
    else
        row = floor(i / n2) + 1;
        col = mod(i, n2);
    end
    array_M2(row, col) = gray;
end
image_M = zeros(m1, n1);
for i = 1 : m2
    for j = 1 : n2
        val = array_M2(i, j);
        index = find(c == val);
        range = (index - 1)* s + 1 : index * s;
        range1 = (i - 1)* s + 1 : i * s;
        range2 = (j - 1)* s + 1 : j * s;
        image_M(range1, range2) = tiles( : , range);
    end
end

disp(fval); disp(exitflag); disp(output); disp(run_time);
imshow(image_M, [])
%% Part2 (Q2)

% Solve the dual of the primal problem
% Continue to use the situation 1), 2) and 3) in Q1

[len, ~] = size(x);
I = eye(len);
A = sparse([Aeq; I]');
b = f';
lb = -inf(m2 * n2 + t + len);
ub = [inf(m2 * n2 + t, 1); zeros(len, 1)];
f = [-beq; -ones(len, 1)];

options = optimoptions('linprog', 'Algorithm', 'dual-simplex');
t1 = cputime;
[y, fval, exitflag, output] = linprog(f, A, b, [], [], lb, ub, options);
t2 = cputime;
run_time = t2 - t1;

disp(fval); disp(exitflag); disp(output); disp(run_time);
%% Part2 (Q3)

% Use sensitivity analyis to decide whether the fond mosaic is still optimal
% Continue to use the situation 1), 2) and 3) in Q1

rgb_A = imresize(image_A, [m1, n1]);
red_A = rgb_A( : , : , 1);
green_A = rgb_A( : , : , 2);
blue_A = rgb_A( : , : , 3);

r_beta = zeros(1, m2 * n2);
g_beta = zeros(1, m2 * n2);
b_beta = zeros(1, m2 * n2);
num = 0;
for i = 1 : s : m1
    for j = 1 : s : n1
        num = num + 1;
        sub_rA = red_A(i : (i + s - 1), j : (j + s - 1));
        sub_gA = green_A(i : (i + s - 1), j : (j + s - 1));
        sub_bA = blue_A(i : (i + s - 1), j : (j + s - 1));
        r_beta(num) = mean(sub_rA( : ));
        g_beta(num) = mean(sub_gA( : ));
        b_beta(num) = mean(sub_bA( : ));
    end
end

rgb_beta = zeros(1, m2 * n2);
for i = 1 : m2 * n2
    avg = r_beta(i) / 3 + g_beta(i) / 3 + b_beta(i) / 3;
    rgb_beta(i) = avg;
end
new_f = zeros(1, t * m2 * n2);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        val = (c(i) - rgb_beta(j))^2;
        new_f(num) = val;
    end
end

set_B = find(x == 1);
set_A = 1:len;
set_C = setdiff(set_A, set_B);

Aeq = [A1; A2]; r1 = rank(Aeq);
Aeq = Aeq(1 : r1, : ); 
aeq = Aeq( : , set_B); r2 = rank(aeq);
r = r1 - r2;

id = zeros(1, r);
num = 0;
for i = set_C
    new_aeq = [aeq, Aeq( : , i)];
    if rank(new_aeq) == r2 + 1
        aeq = new_aeq;
        r2 = r2 + 1; 
        num = num + 1;
        id(num) = i;
        continue; 
    end
    if rank(aeq) == r1
        break;
    end
end

id = sort([id, set_B']); 
reduce_cost = new_f - new_f(id) * (aeq \ Aeq);
res1 = reduce_cost < 0; 
p = find(res1 == 1);

% We can verify the result above by recomputing the linear program

Aeq = sparse([A1; A2]);
beq = [ones(m2 * n2, 1); k * ones(t, 1)];
lb = zeros(t * m2 * n2, 1);
ub = ones(t * m2 * n2, 1); 

options = optimoptions('linprog', 'Algorithm', 'dual-simplex');
new_x = linprog(new_f, [], [], Aeq, beq, lb, ub, options);
res2 = abs(new_x - x); 
q = find(res2 == 1);
%% Part2 (Q4)

% Rescale the circle tiles to size 20 * 20
% Rescale the symbol tiles to size 10 * 10
% Continue to use the situation 1), 2) and 3) in Q1

s = 20; t = 12; % use circle tiles of 20 * 20
% s = 32; t = 8; % use symbol tiles of 32 * 32
m2 = m1 / s; n2 = n1 / s;
k = (m2 * n2) / t;

c = zeros(1, t);
tiles = zeros(s, t * s);
for i = 1 : t
    add_name = strcat("./test_tiles/circles_16/circle_", num2str(i), ".png");
    % address choice "./test_tiles/circles_16/circle_", num2str(i), ".png", "./test_tiles/symbols_64/symbol_", num2str(i), ".png"
    tile = imread(add_name);
    tile = rgb2gray(tile);
    tile = imresize(tile, [s, s]);
    range = (i - 1)* s + 1 : i * s;
    tiles( : , range) = tile;
    c(i) = tile(s / 2, s / 2); % use code here when use circle tiles
    % c(i) = sum(sum(tile)) / s^2; % use code here when use symbol tiles
end
beta = zeros(1, m2 * n2);
num = 0;
for i = 1 : s : m1
    for j = 1 : s : n1
        num = num + 1;
        sub_A = array_A(i : (i + s - 1), j : (j + s - 1));
        beta(num) = mean(sub_A( : ));
    end
end

A1 = zeros(m2 * n2, t * m2 * n2);
[row, ~] = size(A1);
for i = 1 : row
    range = (i - 1)* t + 1 : i * t;
    A1(i, range) = 1;
end
A2 = zeros(t, t * m2 * n2);
[row, col] = size(A2);
for i = 1 : row
    range = i : t : col;
    A2(i, range) = 1;
end
f = zeros(1, t * m2 * n2);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        val = (c(i) - beta(j))^2;
        f(num) = val;
    end
end

Aeq = sparse([A1; A2]);
beq = [ones(m2 * n2, 1); k * ones(t, 1)]; lb = zeros(t * m2 * n2, 1); ub = ones(t * m2 * n2, 1); 

options = optimoptions('linprog', 'Algorithm', 'dual-simplex');
t1 = cputime;
[x, fval, exitflag, output] = linprog(f, [], [], Aeq, beq, lb, ub, options);
t2 = cputime;
run_time = t2 - t1;

array_M1 = zeros(t * m2 * n2, 1);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        gray = c(i) * x(num);
        array_M1(num) = gray;
    end
end
array_M2 = zeros(m2, n2);
for i = 1 : m2 * n2
    range = (i - 1)* t + 1 : i * t;
    gray = sum(array_M1(range));
    if mod(i, n2) == 0
        row = floor(i / n2);
        col = n2;
    else
        row = floor(i / n2) + 1;
        col = mod(i, n2);
    end
    array_M2(row, col) = gray;
end
image_M = zeros(m1, n1);
for i = 1 : m2
    for j = 1 : n2
        val = array_M2(i, j);
        index = find(c == val);
        range = (index - 1)* s + 1 : index * s;
        range1 = (i - 1)* s + 1 : i * s;
        range2 = (j - 1)* s + 1 : j * s;
        image_M(range1, range2) = tiles( : , range);
    end
end

disp(fval); disp(exitflag); disp(output); disp(run_time);
imshow(image_M, [])
%% Part2 (Q4 Extension£©

% We include color information respectively in the linear programs

m1 = 960; n1 = 960;
s = 20; t = 12;
m2 = m1 / s; n2 = n1 / s;
k = (m2 * n2) / t;
image_A = imread("./test_images/1024_1024_city.jpg"); 
% address choice "./test_images/1024_1024_city.jpg", "./test_images/1024_1024_mountain.jpg", "./test_images/1024_1024_bluestreet.png"
array_A = imresize(image_A, [m1, n1]);
% imshow(array_A, []);

c = zeros(1, t);
tiles = zeros(s, t * s);
for i = 1 : t
    add_name = strcat("./test_tiles/circles_16/circle_", num2str(i), ".png"); 
    % address choice "./test_tiles/circles_16/circle_", num2str(i), ".png", "./test_tiles/symbols_64/symbol_", num2str(i), ".png"
    tile = imread(add_name);
    tile = rgb2gray(tile);
    tile = imresize(tile, [s, s]);
    range = (i - 1)* s + 1 : i * s;
    tiles( : , range) = tile;
    c(i) = tile(s / 2, s / 2); % use code here when use circle tiles
end
beta1 = zeros(1, m2 * n2);
num = 0;
for i = 1 : s : m1
    for j = 1 : s : n1
        num = num + 1;
        sub_A1 = array_A(i : (i + s - 1), j : (j + s - 1), 1);
        beta1(num) = mean(sub_A1( : ));
    end
end
beta2 = zeros(1, m2 * n2);
num = 0;
for i = 1 : s : m1
    for j = 1 : s : n1
        num = num + 1;
        sub_A2 = array_A(i : (i + s - 1), j : (j + s - 1), 2);
        beta2(num) = mean(sub_A2( : ));
    end
end
beta3 = zeros(1, m2 * n2);
num = 0;
for i = 1 : s : m1
    for j = 1 : s : n1
        num = num + 1;
        sub_A3 = array_A(i : (i + s - 1), j : (j + s - 1), 3);
        beta3(num) = mean(sub_A3( : ));
    end
end

A = zeros(m2 * n2, t * m2 * n2);
[row, ~] = size(A);
for i = 1 : row
    range = (i - 1)* t + 1 : i * t;
    A(i, range) = 1;
end

f1 = zeros(1, t * m2 * n2);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        val = (c(i) - beta1(j))^2;
        f1(num) = val;
    end
end
f2 = zeros(1, t * m2 * n2);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        val = (c(i) - beta2(j))^2;
        f2(num) = val;
    end
end
f3 = zeros(1, t * m2 * n2);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        val = (c(i) - beta3(j))^2;
        f3(num) = val;
    end
end

Aeq = sparse(A);
beq = ones(m2 * n2, 1);
lb = zeros(t * m2 * n2, 1);
ub = ones(t * m2 * n2, 1); 

options = optimoptions('linprog', 'Algorithm', 'dual-simplex');
x1 = linprog(f1, [], [], Aeq, beq, lb, ub, options);
x2 = linprog(f2, [], [], Aeq, beq, lb, ub, options);
x3 = linprog(f3, [], [], Aeq, beq, lb, ub, options);

array_M1 = zeros(t * m2 * n2, 1);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        gray = c(i) * x1(num);
        array_M1(num) = gray;
    end
end
matrix_M1 = zeros(m2, n2);
for i = 1 : m2 * n2
    range = (i - 1)* t + 1 : i * t;
    gray = sum(array_M1(range));
    if mod(i, n2) == 0
        row = floor(i / n2);
        col = n2;
    else
        row = floor(i / n2) + 1;
        col = mod(i, n2);
    end
    matrix_M1(row, col) = gray;
end
image_M1 = zeros(m1, n1);
for i = 1 : m2
    for j = 1 : n2
        val = matrix_M1(i, j);
        index = find(c == val);
        range = (index - 1)* s + 1 : index * s;
        range1 = (i - 1)* s + 1 : i * s;
        range2 = (j - 1)* s + 1 : j * s;
        image_M1(range1, range2) = tiles( : , range);
    end
end

array_M2 = zeros(t * m2 * n2, 1);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        gray = c(i) * x2(num);
        array_M2(num) = gray;
    end
end
matrix_M2 = zeros(m2, n2);
for i = 1 : m2 * n2
    range = (i - 1)* t + 1 : i * t;
    gray = sum(array_M2(range));
    if mod(i, n2) == 0
        row = floor(i / n2);
        col = n2;
    else
        row = floor(i / n2) + 1;
        col = mod(i, n2);
    end
    matrix_M2(row, col) = gray;
end
image_M2 = zeros(m1, n1);
for i = 1 : m2
    for j = 1 : n2
        val = matrix_M2(i, j);
        index = find(c == val);
        range = (index - 1)* s + 1 : index * s;
        range1 = (i - 1)* s + 1 : i * s;
        range2 = (j - 1)* s + 1 : j * s;
        image_M2(range1, range2) = tiles( : , range);
    end
end

array_M3 = zeros(t * m2 * n2, 1);
for i = 1 : t
    for j = 1 : m2 * n2
        num = (j - 1)* t + i;
        gray = c(i) * x3(num);
        array_M3(num) = gray;
    end
end
matrix_M3 = zeros(m2, n2);
for i = 1 : m2 * n2
    range = (i - 1)* t + 1 : i * t;
    gray = sum(array_M3(range));
    if mod(i, n2) == 0
        row = floor(i / n2);
        col = n2;
    else
        row = floor(i / n2) + 1;
        col = mod(i, n2);
    end
    matrix_M3(row, col) = gray;
end
image_M3 = zeros(m1, n1);
for i = 1 : m2
    for j = 1 : n2
        val = matrix_M3(i, j);
        index = find(c == val);
        range = (index - 1)* s + 1 : index * s;
        range1 = (i - 1)* s + 1 : i * s;
        range2 = (j - 1)* s + 1 : j * s;
        image_M3(range1, range2) = tiles( : , range);
    end
end

image_M = zeros(m1, n1, 3);
image_M( : , : , 1) = image_M1;
image_M( : , : , 2) = image_M2;
image_M( : , : , 3) = image_M3;

imshow(uint8(image_M))