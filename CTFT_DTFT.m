clc;clear;
close all;

%% Information
% Function : CTFT and DTFT of the gate function x.

H = 2;              % Height of the gate
B = 2;              % Weight of the gate
dt = 0.01;          % Time interval
fs = 1/dt;
t = -B:dt:B;    % Time axis
N = length(t);

% Create signal x
x = zeros(1,N);      
% indx = find(t>=-B/2 & t<=B/2);   
indx = find(t>=0 & t<=B);   

x(indx) = H;

%% CTFT
f = -fs/2:0.01:fs/2;
% Input  : Time axis--t, Signal--x, Frequency axis--f
%         'R-I' or 'A-P'--'Real-imag' or 'Abs-Phase'.
% Output : Frequency Axis--f,  DTFT results--X
X = my_CTFT(t,x,f,'A-P');

%% DTFT
H2 = my_DTFT(t,x,f,'A-P');

% %% Parseval's Theorem
% % Time domain integration
% energy_t = sum(h.^2*dt)
% 
% % Frequency domain integration
% df = f(2)-f(1);
% energy_f = sum(abs(H).^2*df)



