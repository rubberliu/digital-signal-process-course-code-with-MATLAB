clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/21
% Function : FS and FT of cos signal and gate function.

%% Parameters
% cos
A = 2;              % Amplitude of signal
f0 = 10;            % Frequency of cos signal
Tc = 1/f0;          % Period of cos signal

% gate
H = 2;              % Height of the gate
B = 4;              % Width of the gate
Tg = 2*B;           % Period of gate function

fs = 1000;          % Sampling frequency
dt = 1/fs;          % Time interval

tc = -0.5*Tc:dt:0.5*Tc;        % Time axis for the sin funciton
tg = -1.5*Tg:dt:1.5*Tg;        % Time axis for the gate function
nc = length(tc);       
ng = length(tg);         

%% Create signal
x_cos = A*sin(2*pi*f0*tc);

indx_g = find(tg>=-B/2 & tg<=B/2);
indx_g1 = indx_g+Tg/dt;
indx_g2 = indx_g-Tg/dt;

x_gate = zeros(1,ng);
x_gate([indx_g2,indx_g,indx_g1]) = H;

%% FS
k = 20;                             % Order
kk = -k:1:k;

ak_c = my_FS(tc,x_cos,kk,Tc);
ak_g = my_FS(tg,x_gate,kk,Tg);

Xc = zeros(1,nc);
Xg = zeros(1,ng);

% for ii = 1:length(Xc)
%     Xc(ii) =sum(ak_c.*exp(1j*kk*2*pi/Tc*tc(ii)));        % another way of IFS
% end
% for ii = 1:length(Xg)
%     Xg(ii) =sum(ak_g.*exp(1j*kk*2*pi/Tg*tg(ii)));
% end
for ii = 1:2*k+1
    Xc = Xc+ak_c(ii).*exp(1j*kk(ii)*2*pi/Tc*tc);
    Xg = Xg+ak_g(ii).*exp(1j*kk(ii)*2*pi/Tg*tg);
end

%% Plot
figure
subplot(211)
hold on
plot(tc,x_cos,'Linewidth',2);
plot(tc,real(Xc),'Linewidth',2)
xlabel('Time /s');
ylabel('Amplitude');
title('Cos and its FS');

subplot(212)
hold on
plot(tg,x_gate,'Linewidth',2);
plot(tg,real(Xg),'Linewidth',2)
xlabel('Time /s');
ylabel('Amplitude');
title('Gate and its FS');

%% FT
df = 0.01;
f = -50:df:50;
Hc = my_CTFT(tc,x_cos,f,'R-I');
Hg = my_CTFT(tg,x_gate,f,'R-I');

%% Parseval's Theorem
% --------FS--------
% Time domain integration
power_x = sum(x_gate.^2*dt)/(max(tg)-min(tg))

% FS integration
power_ak = sum(abs(ak_g).^2)

% --------FT--------
% Time domain integration
energy_x = sum(x_gate.^2*dt)

% Frequency domain integration
df = f(2)-f(1);
energy_X = sum(abs(Hg).^2*df)


