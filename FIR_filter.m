%% Information
% Author : Limin Gu
% Date   : 2021/10/11
% Function : Example of FIR
% update DTFT method  

%% FIR
% Parameters 
clc;clear;
close all

wc = 0.2*pi;
dw = 0.0001;
w = -pi:dw:pi;
Hl = zeros(1,length(w));

ind = find(w<=wc & w>=-wc);
Hl(ind) = 1;


n_max = 25;
n = -n_max:n_max-1;
hl = zeros(1,length(n));

% Inverse FT
for ii=1:length(n)
    hl(ii)=sum(Hl.*exp(1j*w*n(ii)))*dw/2/pi;
end
figure(10)
p=plot(n,abs(hl));p.LineWidth = 1.5;
xlabel('n')
ylabel('amplitude')
title('FIR filter hl')
win = window(@hann,length(n));
% win = window(@rectwin,length(n));

hl = hl.*win';
hh = -hl;
ind0 = find(n == 0);
hh(ind0) = hh(ind0)+1;
hl2 = zeros(1,200);
% hl2(200-2*n_max+1:200) = hl;
% hl2(1:2*n_max) = hl;
hl2(100-n_max:100+n_max-1) = hl;

% [Hl2,w2] = freqz(hl,[1]);
[Hh,wh] = freqz(hh,[1]);
w2 = -pi:0.01:pi;
Hl2 = zeros(1,length(w2));
n1=n+25;
%% DTFT
for ii = 1:length(w2)
   Hl2(ii) = sum(hl.*exp(-1j*w2(ii)*n1)) ;
end

% z=exp(1j*w);
% Hl2 = zeros(1,length(w2));
% for ii = 1:length(hl)
%     Hl2 = Hl2+hl(ii)*z.^(1-ii);
% end
% figure
% plot(w2,Hl2)
% hold on
% plot(wh,Hh)

% f = 0:1/length(hl):1-1/length(hl);
% Hl2 = fft(hl);


%% Plot Spectra 
figure,hold on
subplot(311)
plot(w/pi,Hl,'Linewidth',1.5)
xlabel('\omega (\times \pi rad/sample)'); 
ylabel('Modulus'); ylim([-0.5,1.5])
title('Modulus of ideal filter')
set(gca,'Fontsize',10)

subplot(312),hold on
plot(w2/pi,abs(Hl2),'Linewidth',1.5);
% plot(wh/pi,abs(Hh),'Linewidth',1.5)
xlabel('\omega (\times \pi rad/sample)'); 
ylabel('Modulus'); 
title('Modulus of FIR filter')
% legend('Low-pass','High-pass')
set(gca,'Fontsize',10)

subplot(313)
hold on
plot(w2/pi,unwrap(angle(Hl2))/pi,'Linewidth',1.5);
% plot(wh/pi,unwrap(angle(Hh))/pi,'Linewidth',1.5)
xlabel('\omega (\times \pi rad/sample)'); 
ylabel('Phase (\times \pi rad)');
title('Phase of FIR filter')
% legend('Low-pass','High-pass')
set(gca,'Fontsize',10)

%% Plot Sequence
figure,hold on
stem(n,real(hl),'*','Linewidth',1.5)
stem(n,real(hh),'*','Linewidth',1.5)
xlabel('n');
title('Sequence of ideal filter')
set(gca,'Fontsize',14)
legend('Low-pass','High-pass')

%% signal
N = 200;
% N2 = N+length(hl)-1;
nn = 1:N;
w1 = 0.1*pi; w2 = 0.5*pi;
xn = sin(w1*nn)+2*sin(w2*nn);

y = filter(hl,[1],xn);
y2 = conv(xn,hl);

f = 0:1/N:1-1/N;
% f2 = 0:1/N2;
X = fft(xn)/N;
Y = fft(y)/N;
Y2 = fft(y2)/N;


figure
subplot(211)
hold on
plot(nn,xn,'Linewidth',1.5)
plot(nn, real(y),'Linewidth',1.5)
xlabel('n');
title('Sequence of xn')
legend('Original','Filtered')
set(gca,'Fontsize',14)

subplot(212)
hold on
plot(f,abs(X),'Linewidth',1.5)
plot(f,abs(Y),'Linewidth',1.5)
xlabel('f'); xlim([0,0.5]);
title('Spectra of filtered signal')
legend('Original','Filtered')
set(gca,'Fontsize',14)
