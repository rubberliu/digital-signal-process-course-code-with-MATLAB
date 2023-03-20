% clc;clear;
close all;

%% Input sound files
[x1,fs] = audioread('Bill Gates.wav');
[x2,fs] = audioread('Melinda Gates.wav');
[mix_x,fs] =audioread('mix_Gates.wav');

X_mix = fft(mix_x);
X1 = fft(x1(:,1));
X2 = fft(x2(:,1));
N = length(mix_x);

df = fs/N;

f = 0:df:fs-df;

y1 = filter([Num,[1],x1(:,1)]);
y2 = filter([Num,[1],x2(:,2)]);

sound(y1,fs);
sound(y2,fs);

%% Plot
figure,hold on
% plot(f,abs(X_mix));
plot(f,20*log10(abs(X1)));
plot(f,20*log10(abs(X2)));
set(gca,'Xscale','log')
xlabel('Frequency / Hz')
legend('Bill Gates','Melinda Gates')
xlim([0,fs/2])
ylim([0,80])