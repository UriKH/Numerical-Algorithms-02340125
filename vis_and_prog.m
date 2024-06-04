%% Functions

% this function plots the tanh function multiplied by a factor
function plot_tanh(f)
x = linspace(-5, 5, 100);
y = tanh(f*x);
plot(x, y);
pause;
end

plot_tanh(1);

%% ------- Flow control -------
% relational:
%   equal:        ==
%   not equal:    ~=
%   comparison: >, <, >=, <=

% logical:
%   and:        &, &&
%   or:         |, ||
%   not:        ~
%   xor:        xor
%   all true:   all
%   any true:   any

% boolean: 0 := false, 1 := true

%% if / else / elseif / switch
clear all;

x = 1;
if x > 0
    disp('positive')
elseif x == 0 
    disp('is zero')
else
    disp('negative')
end

% example switch:
cond = 1;
switch cond
    case 0.6
        disp('hi');
    otherwise
        disp('default');
end

%% Loops
% for loop:
vec = zeros(1, 10);
for n=1:100
    if mod(n, 10) == 0
        vec(n/10) = n;
    end
end

% while loop:
it = 0;
while it < vec(1)
    vec(2) = it - 1;
    it = it + 1;
end

%% ------ Plot options -------
clear all;

x = linspace(-5, 5, 100);
y = cos(4*x).*sin(10*x).*exp(-abs(x));
plot(x, y, 'k-o');
pause;
plot(x, y, 's--', ...               % s-- is the line style
    'LineWidth', 2, ...         
    'Color', [1 0 0.5], ...         % color as RGB (0 - 1)
    'MarkerEdgeColor', 'k', ...     % k = black
    'MarkerFaceColor', 'g', ...
    'MarkerSize', 10);
pause;

% we can also use logistic axies using:
x = linspace(0, 100, 100);
y = exp(x);

% only x is the logistic axies
semilogx(x, y, 'k.-');
pause;

% only y is the logistic axies
semilogy(x, y, 'k.-');
pause;

% x and y are logistic axies
loglog(x, y, 'k.-');
pause;

%% ------ 3D line plot ------
clear all;

x1 = linspace(0, 5*pi, 1000);
x2 = linspace(-1, 1, 40);

subplot(2, 3, 1);
plot(x1, sin(x1));
subplot(2, 3, 4);
plot(x2, asin(x2));

subplot(2, 3, 2);
plot(x1, cos(x1));
subplot(2, 3, 5);
plot(x2, acos(x2));

subplot(2, 3, 3);
plot(x1, tan(x1));
subplot(2, 3, 6);
plot(x2, atan(x2));
pause;
close all

% manage axis with:
% axis tsquare
% axis xy (l, l)
% axis ij (l, u)
% axis tight (fit)
% axis equal (same scales)

% ------- 3D surfaces -------
clear all;

x = linspace(-2, 2, 20);
y = x.';
z = x .* exp(-x.^2 - y.^2);
surf(x, y, z);
