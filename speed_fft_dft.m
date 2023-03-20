clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/28
% Function : Speed comparison of DFT and FFT

%% Signal
H = 2;                   % Height of gate funciton
Lx = 1000;                % Points of signal x == Nf
n = 1:1:Lx;
x(n) = H;

df = 1/Lx;
f = 0:df:1-df;
X = zeros(1,length(f));

%% DFT
% jj = 100;
% 
tic
    for jj = 1:length(f)
        X(jj) = sum(x.*exp(-1j*2*pi*f(jj)*n));
    end
toc

%% FFT
tic
X2 = fft(x);
toc
figure
plot(abs(X))
hold on
plot(abs(X2))


