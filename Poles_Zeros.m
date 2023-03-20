clc;clear;
close all;
%% 
% rz = 0.998;
rz = 1;
rp = 0.9;
% wc = [pi/3,pi/2]';  
wc = [pi/3,pi/2,-pi/3,-pi/2]';  
w = 0:0.001:pi;
% w = 0:0.001:2*pi;
k = 1;
zz = rz*exp(1j*wc);
pp = rp*exp(1j*wc);
figure
zplane(zz,pp)
%% Hw 
Hw = k*ones(1,length(w));
for ii =1:length(w)
    for jj = 1:length(zz)
       Hw(ii)=Hw(ii)*(exp(1j*w(ii))-zz(jj)); 
    end
    for kk = 1:length(pp)
       Hw(ii)=Hw(ii)/(exp(1j*w(ii))-pp(kk)); 
    end
end
figure
subplot(211)
plot(w/pi,20*log10(abs(Hw)),'Linewidth',1.5);
xlabel('Normal Frequency (×\pi rad/sample)')
ylabel('Amplitude /dB')
grid on
ylim([-15,6]);
subplot(212)
plot(w/pi,angle(Hw),'Linewidth',1.5)
xlabel('Normal Frequency (×\pi rad/sample)')
ylabel('Phase')
grid on
%% 
[bz,az] = zp2tf(zz,pp,k);
figure
freqz(bz,az)
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

