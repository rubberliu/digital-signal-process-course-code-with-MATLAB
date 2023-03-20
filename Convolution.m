%% 构造离散信号
nx=1:3; x=[1,1,1];
nh=1:3; h=[1,2,3];

figure
subplot(2,1,1);
stem(nx,x);
title("x(n)");
set(gca,'xtick',0:1:3)
axis([0 3 0 2])

subplot(2,1,2);
stem(nh,h)
title("h(n)");
set(gca,'xtick',0:1:4);
axis([0 4 0 4])

%% 离散信号卷积
lx = length(x);
lh = length(h);
ly=lx+lh-1;
y = zeros(1,lx+lh);

figure
for ii = 1:lx
      sum=zeros(1,lx+lh);
      for n=nx(1)+nh(1):ii+lh
          if (n>ii)
            sum(n)=x(ii)*h(n-ii);
          end
      end
       subplot(lx+1,1,ii);
       stem(sum);
       set(gca,'xtick',0:1:6)
       title("x("+ii+")\timesh(n-"+ii+")结果");
       y=y+sum;
end
subplot(lx+1,1,lx+1)
stem(y);
title("x(n)*h(n)结果");
set(gca,'xtick',0:1:6)
%% conv函数
y1=conv(x,h);
figure;
n=2:2+ly-1;
stem(n,y1);
axis([1 6 0 6]);
title("x(n)*h(n)结果");
%% 构造连续信号
H1 = 2;
dt = 0.01;
T1 = 2;
t = -10:dt:10;
H2 = 2;
T2 = -2;
ind1 = find(t>=0 & t<=T1);
ind2 = find(t>=T2 & t<=0);
x1 = zeros(1,length(t));
x2 = zeros(1,length(t));
x1(ind1) = H1;
x2(ind2) = -H2*t(ind2);

figure
subplot(211)
plot(t,x1)
title("x1(t)");
subplot(212)
plot(t,x2)
title("x2(t)");
%% 连续conv函数
t2 = -20:dt:20;
y = conv(x1,x2)*dt;
figure
plot(t2,y)
xlim([-10,10])
title("y(t)=x1(t)*x2(t)")