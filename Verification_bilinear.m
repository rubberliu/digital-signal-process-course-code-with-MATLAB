%% Information
% Author : Limin Gu
% Date   : 2021/10/12
% Function : Verification of bilinear transformation

%% ------ Main------a
clc;clear;
% close all;

%% Parameter
fc = 200;
fs = 1000;
T = 1/fs;
f = 0:0.005:fs;

wc = 2*pi*fc;
w = 2*pi*f;

%% Comparison
% -----Analog-----
n = 16;
s = 1j*w;
Hs = my_butter(wc,s,n);  %theoretical 


[bs,as]=butter(n,wc,'s');   % matlab function
% bs=bs(end:-1:1);
Hs2 = freqs((as-bs)/max(as-bs),as,w); 


% % [bs,as] = lp2hp(bs,as,fc/fs);
% % Hs2 = freqs(bs,as,w); 

% bs = bs(end:-1:1)/as(end);
% as = as(end:-1:1)/as(end);
% Hs2 = freqs(bs,as,w); 

% -----Digital-----
z = exp(1j*w*T);
s2 = 2/T*( (z-1)./(z+1) );
Hz = my_butter(wc,s2,n);     % theoretical bilinear
[bz,az] = bilinear(bs,as,fs); % matlab function
Hz2 = freqz(bz,az,f,fs/2);

% [b,a]=butter(n,2*fc/fs);
% Hz3=freqz(b,a,f,fs);


%% Plot
figure(1),hold on
% plot(f,20*log10((abs(Hs))),'Linewidth',1);
% plot(f,abs(Hz),'--','Linewidth',1);
% plot(f,20*log10((abs(Hs2))),'-*','Linewidth',1);
plot(f,20*log10(abs(Hz2)),'-o','Linewidth',1);
% plot(f,abs(Hz3))

xlim([0,fs]);
xlabel('f / Hz'); 
ylabel('Modulus of filters');
title('Butterworth 2-order lowpass filter')
% legend('Analog','Digital','Analog by Matlab','Digital by Matlab')
% set(gca,'Scale','log','Fontsize',14)




