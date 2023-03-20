clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/10/11
% Function : Filter Comparison

%% Parameters
wc = 0.4*pi;

load('fir_iir_num_and_den.mat');

%% Signal
nn = 0:199;
w1 = 0.28*pi;  w2 = 0.4*pi;

xn = sin(w1*nn)+sin(w2*nn);


X = fft(xn);

%% Notch Filter
delta = 0.1;
rz = 1;
rp = 1-delta;

% zeros and poles
z1 = rz*exp(1j*wc);
p1 = rp*exp(1j*wc);

K = 1;
Zeros = [z1,conj(z1)];
Poles = [p1,conj(p1)];
[bz,az] = zp2tf(Zeros',Poles',K);

y1 = filter(bz,az,xn);
Y1 = fft(y1);

figure
freqz(bz,az)
title('Notch Fliter')

%% FIR Filter
y2 = filter(num_fir,1,xn);
Y2 = fft(y2);

figure
freqz(num_fir,1)
title('FIR Filter')

%% IIR Filter
y3 = filter(num_iir,den_iir,xn);
Y3 = fft(y3);

figure
freqz(num_iir,den_iir)
title('IIR Filter')
%% Plot
df = 1/length(xn);
f = 0:df:1-df;

figure
subplot(421)
plot(f,abs(X));
xlim([0,0.5]);
title('Spectra of Original Signal xn')

subplot(423)
plot(f,abs(Y1));
xlim([0,0.5]);
title('Spectra of Filtered Signal y1 [Notch]')

subplot(425)
plot(f,abs(Y2));
xlim([0,0.5]);
title('Spectra of Filtered Signal y2 [FIR]')

subplot(427)
plot(f,abs(Y3));
xlim([0,0.5]);
title('Spectra of Filtered Signal y3 [IIR]')

subplot(422)
plot(xn);
ylim([-2,2])
title('Original Signal xn')

subplot(424)
plot(y1);
ylim([-2,2])
title('Filtered Signal y1 [Notch]')

subplot(426)
plot(y2);
ylim([-2,2])
title('Filtered Signal y2 [FIR]')

subplot(428)
plot(y3);
ylim([-2,2])
title('Filtered Signal y3 [IIR]')



