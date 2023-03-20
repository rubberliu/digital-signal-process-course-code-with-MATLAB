clc;clear;close all
%% 
% I/O method
%%
n = -20:20;
x = zeros(1,length(n));
tmp = [1,2,3];
indx = find(n>=0 & n<=2);
% x(indx) = tmp;
x(n==0)=1;
figure
stem(n,x)
%%
y = zeros(1,length(n));
ind2 = find(n == -1);
y(ind2) = 0;
w1 = y(ind2);
v1 = x(ind2);
nn = 0:max(n);
for ii = 1:length(nn)
    tmp = find(n == nn(ii));
    y(tmp)= 0.5*w1+2*x(tmp)+3*v1;
    w1 = y(tmp);
    v1 = x(tmp);
end

%% matlab function
az = [1,-0.5];
bz = [2,3];

yy = filter(bz,az,x);

figure
hold on
stem(n,y)
stem(n,yy,'--')
legend('y','yy')