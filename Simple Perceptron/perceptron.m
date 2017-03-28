%clc; clear;

x1 = 1;
x2 = 1;
D = 1;

n = 0.25;
%{
theta = 0.24;
w1 = 0.5;
w2 = 0.2;
%}

F = x1*w1 + x2*w2 - theta;

if F >= 0
    Y = 1
else
    Y = 0
end


delta = D - Y;

if delta ~= 0
    d1 = n * delta * x1
    d2 = n * delta * x2

    w1 = w1 + d1;
    w2 = w2 + d2;

    theta = theta - n * delta;
end

[F Y delta]
[w1 w2 theta]