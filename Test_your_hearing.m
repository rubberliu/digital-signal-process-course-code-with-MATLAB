clc;clear;
close all;

%% Information
% Author : Limin Gu
% Date   : 2021/09/14
% Function : Create sin with different frequencies.
%            Test your hearing.
% !!!!Turn down the sound volume of your computer at first.!!!!


%% Input
% -------Input Signal information------
prompt1 = {'Frequency / Hz:','Time /s','Sampling Frequency'};
title1 = 'Input parameters';
dims1 = [1 35];
definput1 = {'800','2',''};

answer1 = inputdlg(prompt1,title1,dims1,definput1);

% Parameters
f = str2num(answer1{1});
Time = str2num(answer1{2});

%% Create a Signal
T = 1/f;
fs = 5*f;
dt = 1/fs;
t = 0:dt:Time;

x = 0.7*sin(2*pi*f*t);

%% Plot
figure
plot(t,x)

xlim([0,5*T])
xlabel('Time /s')

%% Play
sound(x,fs)             % Play the sound (fs > 1000 Hz)

