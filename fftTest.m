clc;clear;close all;
%%
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
figure
plot(1000*t(1:50),S(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('S(t)')
%% FFT
Yjf = fftshift(fft(S));
f=-length(Yjf)/2:1:length(Yjf)/2-1;
f=f/length(Yjf)*Fs;
figure
plot(f,abs(Yjf)/L*2)