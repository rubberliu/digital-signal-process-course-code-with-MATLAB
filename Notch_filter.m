clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/10/11
% Function : Example of Notch Filter

%% Parameters
wn1 = pi/3;
wn2 = pi/2;

delta = 0.001;
rz = 1;
rp = 1-delta;

% zeros and poles
z1 = rz*exp(1j*wn1);
p1 = rp*exp(1j*wn1);
z2 = rz*exp(1j*wn2);
p2 = rp*exp(1j*wn2);

dw = 0.002*pi;
w = 0:dw:2*pi-dw;

%% My notch filter
z = exp(1j*w);
K = 1;
% Hz =  (z-z1).*(z-conj(z1))./ ( (z-p1).*(z-conj(p1)) );
Hz = K*(z-z1).*(z-conj(z1)).*(z-z2).*(z-conj(z2))...
      ./ ((z-p1).*(z-conj(p1)).*(z-p2).*(z-conj(p2)) );
% Hz = (z-z1).*(z-z2)...
%       ./ ((z-p1).*(z-p2)) ;


figure
plot(w/pi,20*log10(abs(Hz)),'Linewidth',1.5);
xlabel('Frequency')
ylabel('Amplitude')
title('Spectra of Notch Filter');

%% Notch filter
K = 1;
% Zeros = [z1,conj(z1)];
% Poles = [p1,conj(p1)];
Zeros = [z1,conj(z1),z2,conj(z2)];
Poles = [p1,conj(p1),p2,conj(p2)];

[bz,az] = zp2tf(Zeros',Poles',K);

figure
subplot(211)
hold on
freqz(bz,az);
title('Spectra of Notch Filter')
subplot(212)
% pzmap(tf(bz,az,-1))
zplane(bz,az)
title('Zeros and Poles of Notch Filter')

%% Signal
nn = 0:199;
 w3 = pi/3;  w4 = pi/4;

xn = sin(w3*nn)+sin(w4*nn);

df = 1/length(xn);
f = 0:df:1-df;

figure
subplot(221)
plot(nn,xn,'Linewidth',1.5);
title('Original Signal x[n]')
subplot(223)
plot(f,abs(fft(xn)),'Linewidth',1.5);
title('Spectra of Original Signal x[n]')
%% Filter
y = filter(bz,az,xn);

subplot(222)
plot(nn,y,'Linewidth',1.5)
title('Filtered Signal y[n]')

subplot(224);
plot(f,abs(fft(y)),'Linewidth',1.5)
title('Spectra of Filtered Signal xy[n]')

