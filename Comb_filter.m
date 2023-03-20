clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/10/11
% Function : Example of Comb Filter

%% Parameters
wn1 = 0.3*pi;
wn2 = 0.4*pi;

delta = 0.98;
rp = 0.99;
rz = rp-delta;

z1 = rz*exp(1j*wn1);
p1 = rp*exp(1j*wn1);
z2 = rz*exp(1j*wn2);
p2 = rp*exp(1j*wn2);

dw = 0.001;
w = 0:dw:2*pi-dw;


%% My comb filter
z = exp(1j*w);
K = 1;

% Hz =  K*(z-z1).*(z-conj(z1))./ ( (z-p1).*(z-conj(p1)) );
Hz =  K*(z-z1).*(z-conj(z1)).*(z-z2).*(z-conj(z2))...
      ./ ((z-p1).*(z-conj(p1)).*(z-p2).*(z-conj(p2)) );

figure
subplot(211)
plot(w/pi,abs(Hz),'Linewidth',1.5);
xlabel('Frequency')
ylabel('Amplitude')
title('Spectra of Notch Filter');
subplot(212)
plot(w/pi,unwrap(angle((Hz))),'Linewidth',1.5);
xlabel('Frequency')
ylabel('Phase')


%% Comb filter
K = 1;
% Zeros = [z1,conj(z1)];
% Poles = [p1,conj(p1)];
Zeros = [z1,conj(z1),z2,conj(z2)];
Poles = [p1,conj(p1),p2,conj(p2)];

[bz,az] = zp2tf(Zeros',Poles',K);

figure
subplot(211)
freqz(bz,az);
title('Spectrum of Comb Filter')
subplot(212)
pzmap(tf(bz,az,-1))
title('Zeros and Poles of Comb Filter')

%% Signal
nn = 0:999;
w1 = 0.27*pi;   w2 = 0.3*pi;  w3 = 0.33*pi;  w4 = 0.4*pi;

xn = sin(w1*nn)+sin(w2*nn)+sin(w3*nn)+sin(w4*nn);

df = 1/length(xn);
f = 0:df:1-df;

figure
subplot(221)
plot(nn,xn,'Linewidth',1.5);
title('Original Signal x[n]')
subplot(223)
plot(f,abs(fft(xn)),'Linewidth',1.5);
title('Spectrum of Original Signal x[n]')

%% Filter
y = filter(bz,az,xn);

subplot(222)
plot(nn,y,'Linewidth',1.5)
title('Filtered Signal y[n]')

subplot(224);
plot(f,abs(fft(y)),'Linewidth',1.5)
title('Spectrum of Filtered Signal y[n]')

%% Transform
y2 = y(600:999);
x2 = xn(600:999);

Y2 = fft(y2);
X = fft(x2);

df = 1/length(Y2);

f = 0:df:1-df;

figure
subplot(211)
plot(f,abs(Y2));
subplot(212)
plot(f,abs(X));

