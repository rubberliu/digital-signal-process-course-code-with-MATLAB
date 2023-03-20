clc;clear;
% close all;

%% Parameters
A1 = 1;
A2 = 2;
f1 = 10;
f2 = 20;

fs = 200;
dt = 1/fs;

%%
t = 0:dt:5;
x = A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t);
f = -fs/2:0.1:fs/2;

X = my_CTFT(t,x,f,'A-P');
T = max(t)-min(t);

figure
plot(f,abs(X))
xlabel('Frequency / Hz');
title('CTFT of x(t)')
