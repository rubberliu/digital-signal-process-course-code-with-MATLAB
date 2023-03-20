%% Information
% Author : lpx
% Date   : 2022/03/23
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
% figure(10)
% p=plot(n,abs(hl));p.LineWidth = 1.5;
% xlabel('n')
% ylabel('amplitude')
% title('FIR filter hl')
win = window(@hann,length(n));
% win = window(@rectwin,length(n));

hl = hl.*win';


% z=exp(1j*w);
% Hl2 = zeros(1,length(w2));
% for ii = 1:length(hl)
%     Hl2 = Hl2+hl(ii)*z.^(1-ii);
% end
% figure
% plot(w2,Hl2)
% hold on
% plot(wh,Hh)

f = 0:1/length(hl):1-1/length(hl);
Hl2 = fft(hl);


%% Plot Spectra 
% figure,hold on
% % subplot(311)
% % plot(w/pi,Hl,'Linewidth',1.5)
% % xlabel('\omega (\times \pi rad/sample)'); 
% % ylabel('Modulus'); ylim([-0.5,1.5])
% % title('Modulus of ideal filter')
% % set(gca,'Fontsize',10)
% 
% subplot(312),hold on
% plot(w2/pi,abs(Hl2),'Linewidth',1.5);
% % plot(wh/pi,abs(Hh),'Linewidth',1.5)
% xlabel('\omega (\times \pi rad/sample)'); 
% ylabel('Modulus'); 
% title('Modulus of FIR filter')
% % legend('Low-pass','High-pass')
% set(gca,'Fontsize',10)
% 
% subplot(313)
% hold on
% plot(w2/pi,unwrap(angle(Hl2))/pi,'Linewidth',1.5);
% % plot(wh/pi,unwrap(angle(Hh))/pi,'Linewidth',1.5)
% xlabel('\omega (\times \pi rad/sample)'); 
% ylabel('Phase (\times \pi rad)');
% title('Phase of FIR filter')
% % legend('Low-pass','High-pass')
% set(gca,'Fontsize',10)

% %% Plot Sequence
% figure,hold on
% stem(n,real(hl),'*','Linewidth',1.5)
% stem(n,real(hh),'*','Linewidth',1.5)
% xlabel('n');
% title('Sequence of ideal filter')
% set(gca,'Fontsize',14)
% legend('Low-pass','High-pass')

%% signal
N = 500;
nn = 1:N;
w1 = 0.1*pi; w2 = 0.5*pi;
xn = sin(w1*nn)+2*sin(w2*nn);
L=100;    %每100个点输出一次结果
temp=zeros(1,length(hl)-1);
for ii =1:N/L
    y = conv(xn((ii-1)*L+1:ii*L),hl);
    figure(1)
    hold on
    y(1:length(hl)-1)=y(1:length(hl)-1)+temp;
    plot(nn((ii-1)*L+1:ii*L),real(y(1:L)))
    temp=y(L+1:end);
end
% y = filter(hl,[1],xn);     
y=conv(hl,xn);
ny=1:length(y);
figure(2)
hold on
plot(nn,xn,'Linewidth',1.5)
plot(ny, real(y),'Linewidth',1.5)
xlabel('n');
title('Sequence of xn')
set(gca,'Fontsize',14)

