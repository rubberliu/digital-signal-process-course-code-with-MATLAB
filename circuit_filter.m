clc;clear;
close all;

%%
L = 5e-3;
% L= 1e-5;
C = 5e-9;
R = 100;
R0 = 1000;
% f0 = sqrt(1/C/L)/2/pi

f = 1e3:10:10e4;
w = 2*pi*f;

% H = 1./(1-1j./(R*(w*C-1./w/L)) );
% H = 1./( (R+R0)/R0 + 1j*w*L./(-w.^2*C*L+1) );
% H = 1./ ( 1/R0*(R+1j*w*L)./(-w.^2*L+1j*w*R*C+1)+1 ); 
H = R0./( (R+1j.*w*L)./(1j.*w*C)./(R+1j.*w*L+1./(1j.*w*C)) +R0);

figure
subplot(211)
plot(f,abs(H),'Linewidth',1.5);
subplot(212)
plot(f,angle(H),'Linewidth',1.5);


