clc;clear;
close all;
%% R-L-C circuit
L = 0.001;
C = 0.05;
R = 1;
fs=1000;
fc = sqrt(1/L/C)/2/pi
f = 0:0.001:1000;
w = 2*pi*f;
s = 1j*w;
Ts = 1./(L*C*s.^2+R*C*s+1);
%% digital filter
as = [1,R/L,1/L/C];
bs = [1/L/C];
[bz,az] = bilinear(bs,as,fs); % matlab function
Hz2 = freqz(bz,az,f,fs);
% freqz(bz,az,f,fs)
figure
p=semilogx(f,20*log10(abs(Ts)));p.LineWidth=1.5;
% p=plot(f,20*log10(abs(Ts)));p.LineWidth=1.5;
hold on
p=semilogx(f,20*log10(abs(Hz2)));p.LineWidth=1.5;p.LineStyle=':';
grid on
xlabel('Frequency /Hz')
ylabel('Amplitude /dB')
legend('Analog','Digital')
%% filter signal ...

