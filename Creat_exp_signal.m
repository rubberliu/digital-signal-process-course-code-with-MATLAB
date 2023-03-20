clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/13
% Function : Create an exponential signal.

%% Creat Signal
T = 0.1;                % Period
n = 20;                 % Number of Points Per Period
dt = T/n;               % Time Interval
t = 0:dt:1;             % Time Axis
f = 1/T;                % Frequency
omega = 2*pi*f;         % Angular Frequency

y = exp(1j*omega*t);    % Signal

%% Plot
figure
subplot(221)
plot(t,real(y));

xlabel('Time / s')
ylabel('Real')
ylim([-2,2])
legend('Real')
title('Real Part')

subplot(222)
plot(t,abs(y));

xlabel('Time / s')
ylabel('Abs')
ylim([0,2])
legend('Abs')
title('Absolute Value')

subplot(223)
plot(t,imag(y));

xlabel('Time / s')
ylabel('Imag')
ylim([-2,2])
legend('Imag')
title('Imaginary Part')

subplot(224)
% plot(t,angle(y));
plot(t,unwrap(angle(y)));

xlabel('Time / s')
ylabel('Angle / rad')
legend('Phase')
title('Phase')


