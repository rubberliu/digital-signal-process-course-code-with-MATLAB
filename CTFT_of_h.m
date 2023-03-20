clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/17
% Function : Continuous Time fourier transform of h.
%            h(t) = 1 when 0<t<T.

%% Parameters
T = 2;                  
dt = 0.01;          % Time interval
% fs = 1/dt;
t = -2*T:dt:2*T;      % Time axis
n = length(t);

% Create signal h
h = zeros(1,n);      
indx = find(t>=-2*T & t<=0);     
h(indx) = 1;

%% CTFT

f = -2/T:0.01:2/T;

% Input  : Time axis--t, Signal--h, Frequency axis--f
%         'R-I' or 'A-P'--'Real-imag' or 'Abs-Phase'.
% Output : Frequency Axis--f,  CTFT results--H
H = my_CTFT(t,h,f,'None');


figure
plot(f,abs(H));

%% Parseval's Theorem
% Time domain integration
energy_t = sum(h.^2*dt)

% Frequency domain integration
df = f(2)-f(1);
energy_f = sum(abs(H).^2*df)



