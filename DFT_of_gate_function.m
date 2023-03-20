clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/28
% Function : DFT of gate function

%% Parameters
H = 2;                  % Height of gate funciton
Lx = 128;                % Points of signal x

Nf = 128;                % Points of f aixs;

%% Create signal x
if Nf >= Lx
    % Zero-padding
    N0 = Nf-Lx;
    n = 1:1:Nf;
    x = zeros(1,Nf);
    x(1:Lx) = H;
    x(1:Lx) = H*cos(2*pi*0.1*(1:1:Lx));
    
elseif Nf < Lx
    % Wrapping
    NN = ceil(Lx/Nf);
    n = 1:1:Nf*NN;
    x = zeros(1,Nf*NN);
    x(1:Lx) = H;
    x(1:Lx) = H*cos(2*pi*0.1*(1:1:Lx));

end

figure
subplot(211)
stem(n,x,'-.','lineWidth',2)
title('Sequence of x')
xlabel('n')
% xlim([1,100])
ylim([-H-1,H+1])
set(gca,'FontSize',14);
grid on

%% DFT
if Nf >= Lx
    X = my_DFT(n,x,Nf);
elseif Nf < Lx
   x1 = zeros(1,Nf);
   for ii = 0:1:NN-1
       x1 = x1+x(ii*Nf+1:(ii+1)*Nf);
   end
   n1 = 1:1:Nf;
   X = my_DFT(n1,x1,Nf);
end

X = fftshift(X);
f = -0.5:1/Nf:0.5-1/Nf;
f_2 = -0.5:1/1000:0.5;
X_2 = my_DTFT(n,x,f_2,'None');

%% FFT
X2 = fft(x,Nf);
X2 = fftshift(X2);

%% Plot
subplot(212)
hold on
stem(f,abs(X),'Linewidth',3)
plot(f_2,abs(X_2),'Linewidth',3)
stem(f,abs(X2),'Linewidth',3)
ylim([0,max(abs(X))+10])
legend('DFT','DTFT','FFT')
title('DFT of x')
xlabel('f')
ylabel('Amplitude')

set(gca,'FontSize',14);
grid on



%% DFT
function X = my_DFT(n,x,Nf)
    df = 1/Nf;
    f = 0:df:1-df;
    X = zeros(1,length(f));

    for jj = 1:length(f)
        X(jj) = sum(x.*exp(-1j*2*pi*f(jj)*n));
    end
end


