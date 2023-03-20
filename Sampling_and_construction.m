clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/14
% Function : Signal sampling and reconstruction

%% Create a Signal
% Original Signal
f = 800;                    % Signal Frequency
w0 = f*2*pi;            
T = 1/f;                    % Signal Period
n = 500;                    % Period Points
dt = T/n;
t = 0:dt:1;                 % Time Axis
x = sin(w0*t);              % Original Signal

% Sampling
ratio = 2;                  % ratio = ws/w0
ws = w0*ratio;              % Sampling frequency
fs = floor(ws/2/pi); 

dts = 1/fs;                   % Time Interval
ts = 0:dts:1;                 % Time Axis

xs = sin(2*pi*f*ts);          % Sampling Signal

% Interp
ts_inter = 0:dts/10:1;
xs_inter = interp1(ts,xs,ts_inter,'spline');

%% Plot
figure,hold on
plot(t,x)
plot(ts_inter,xs_inter,'--')
scatter(ts,xs)

xlim([0,5*T])
ylim([-1.5,1.5])
xlabel('Time /s')
legend('Original Signal','Sampled Signal')

%% Play
% sound(xs,fs)                % Play the sound (fs>1000 Hz)

