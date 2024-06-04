%% Using vectors
v1 = [1, 2, 3, 4, 5];
v1_t = transpose(v1);

v2 = [1, 2, 1i, 2i];
v2_hermitian = v2.';

%% Matrices
clear all;

% defined same as with vectors or as followes:
mat1 = [[1, 2]; [3, 4]];

% matrices can also be combined into one big matrix:
m_a = [1, 2];
m_b = [3, 4];
m_c = [5; 6];
m_d = [m_a; m_b];
m_e = [m_d, m_c];                   % = [[m_a; m_b], m_c]
m_f = [[m_e, m_e]; [m_a, m_b, m_a]];

% NOTE: strings are character vectors

%% Date and time
clear all;

time = datetime('now'); % returns the current datetime

% time can be also retrieved as a vector:
time_vec = clock();
time_str = datestr(time_vec);
disp(time_vec);
disp(time_str);

%% Variable manipulations
clear all;

% usage:
temp = (2 + 5)^2 - 7*2^0.5;
temp = 1/5 + 2.5i;

% more constants
% *  i / j for complex
% *  Inf and -Inf
% *  Nan

%% Utility functions
% regular:
%       sqrt, log [log10, log2, ...], exp
%       round, florr, ceil, abs
% trigonometric: 
%       cos, sin, tan (inverse: acos, asin, atan)
%       cosd, sind, tand (returns value in degrees)
%       acosd, asind, atand (inverse and returns value in degrees)
%       cosh, sinh, tanh (inverse: acosh, asinh, atanh)
% complex:
%       angle, abs

%% Operaions:
clear all;

row = [2, 2, 3];
s = sum(row); 
p = prod(row);

%% automatic matrics generation
clear all;

m = 3;
n = 5;

one = ones(m, n);
zero = zeros(m, n);
random = rand(m, n);
random_square = rand(m); 
nan_m = nan(m, n);
I = eye(n, n);

% initialization
a = linspace(0, 10, 5);
b = 0:2:10;
c = 1:5;

%% Indexing
% n-th value in vector vec :    vec(n)
% m,n-th value in matrix mat :  mat(m, n)

% n-m to n first elements in a vector: vec(n-m: n)
% n-th row in a matrix: mat(n, :)

[minVal, minInd] = min(random);
[maxVal, maxInd] = max(random);
% minVal is the minimum value in each column (works also on vectors)

% finding elements:
ind = find(random > 0.5 & random < 0.9);


%% Plotting
clear all;

x1 = linspace(0, 4*pi, 10);
y1 = sin(x1);
x = linspace(0, 4*pi, 100);
y = sin(x);
plot(x, y);
hold on;
plot(x1, y1);