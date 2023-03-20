clc;clear;close all;
%% 
fs = 48000;
f1 = 8000;
f2 = 14000;
dt = 1/fs;
D = 0.01;
t = 0:dt:D-dt;
xt = sin(2*pi*f1*t)+2*sin(2*pi*f2*t);
%%
load FIR_lowpass_9600.mat
y1 = filter(Num,[1],xt);
% load IIR_lowpass_9600.mat
% [b,a] = sos2tf(SOS,G);
% y1 = filter(b,a,xt);
figure
plot(t,xt)
hold on
plot(t,y1)
legend('original signal','filtered signal')
xlabel('time /s')
ylabel('amplitude')
%%
Y1 = fftshift(fft(y1));
X1 = fftshift(fft(xt));
f = 1:length(Y1);
f = (f-length(Y1)/2)/(length(Y1))*fs;
figure
p=plot(f,abs(X1)*dt/D);p.LineWidth=1.5;
hold on 
p=plot(f,abs(Y1)*dt/D);p.LineStyle='--';p.LineWidth=1.5;
title('Fourier transform comparision')
legend('original signal','filtered signal')
xlabel('Frequency /Hz')
ylabel('amplitude')
grid on


