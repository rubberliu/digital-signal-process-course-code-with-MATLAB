clc;clear;
% close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/21
% Function : CTFT and DTFT of different cos signal with windows.
% update: 2022/03/02 update hamming window
%% Input
% -------Input Signal information------
prompt1 = {'f1 / Hz','f2 / Hz','A1','A2','Width of the window /s',...
           'Type of the window [rect,hanning,hamming,blackman]','CTFT or DTFT'};
title1 = 'Input parameters';
dims1 = [1 35];
definput1 = {'17','18.5','1.2','1.2','4','rect','CTFT'};

answer1 = inputdlg(prompt1,title1,dims1,definput1);

f1 = str2num(answer1{1});
f2 = str2num(answer1{2});
A1 = str2num(answer1{3});
A2 = str2num(answer1{4});
T = str2num(answer1{5});
type_w = answer1{6};
type_f = answer1{7};

fs = 200;
dt = 1/fs;
t = 0:dt:2*T;

%% Create a cos signal
x1 = A1*cos(2*pi*f1*t);
x2 = A2*cos(2*pi*f2*t);
x = x1+x2;

%% Create the window
N = length(t);
win = zeros(1,N);
win_m = zeros(1,N);

indx = find(t>=0 & t<=T);

switch (type_w)
    case 'rect'
        win(indx) = 1;
        win_m(indx) = rectwin(T/dt+1);
        
    case 'hanning'
        win(indx) = 0.5*( 1-cos(2*pi*t(indx)/(T+dt)) );
        win_m(indx) = hann(T/dt+1);
    case 'blackman'
        win(indx) = 0.42-0.5*cos(2*pi*t(indx)/T)+0.08*cos(4*pi*t(indx)/T);
        win_m(indx) = blackman(T/dt+1);
    case 'hamming'
        win(indx) = 0.53836-(1-0.53836)*cos(2*pi*t(indx)/(T+dt));
        win_m(indx) = hamming(T/dt+1);
end

tm = 0:dt:dt*(length(win_m)-1);

%% Multiply the window and cos
xw = x.*win/(sum(win)*dt);


%% Plot
figure
subplot(311)
hold on
plot(t,win,'-*','Linewidth',1.5);
plot(tm,win_m,'--','Linewidth',1.5);
legend('My win','Matlab')
xlabel('Time /s')
title([type_w,' window'])

subplot(312)
plot(t,x)
title('Original signal x')
xlabel('Time /s')
ylim([-10,10])

subplot(313)
plot(t,xw)
title('Windowing signal xw')
xlabel('Time /s')
ylim([-10,10])

%% CTFT / DTFT
n = t/dt;
f = -fs/2:0.01:fs/2;

switch (type_f)
    case 'CTFT'
        XW = my_CTFT(t,xw,f,'None');
        W = my_CTFT(t,win,f,'None');
        
    case 'DTFT'
        f = f*dt;
        XW = my_DTFT(n,xw,f,'None');
        W = my_DTFT(n,win,f,'None');
end

%% Plot
figure
subplot(211)
plot(f,abs(W));
title(['Amplitude of ',type_f,'(w)']);
xlabel('Frequency /Hz');
ylabel('Amplitude')

subplot(212)
plot(f,abs(XW));
title(['Amplitude of ',type_f,'(xw)']);
xlabel('Frequency /Hz');
ylabel('Amplitude')
