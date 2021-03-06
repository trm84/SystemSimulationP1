%Tyler Matthews
%System Simulation Final
%P4

clear all; clc; close all;
% R''' + alpha * R'' + beta*(1 - R^2)R' + R = 0

alpha = 0.5;
beta = -5.6;
T=0.1;

t0plot=10;
startTime = 0;
stopTime = 80;

t = linspace(startTime, stopTime, stopTime/T);
N=length(t);

rk0=1+floor(t0plot/T);
N2=15;

x = zeros(3,N);
midrk1 = zeros(3,N);
midrk2 = zeros(3,N);

rk1 = zeros(3,N);
rk2 = zeros(3,N);
rk3 = zeros(3,N);

x(:,1)=[1 1 1]';

%% Simulation
for k=1:N-1    
    rk1(1,k)=x(2,k);
    rk1(2,k)=-(alpha*x(3,k) + beta*(1-(x(1,k))^2)*x(2,k) + x(1,k)); 
    midrk1(:,k)=x(:,k)+(T/2)*rk1(:,k);
    
    rk2(1,k)=midrk1(2,k);
    rk2(2,k)=-(alpha*midrk1(3,k)+ beta*(1-(midrk1(1,k))^2)*midrk1(2,k) + midrk1(1,k));   
    midrk2(:,k)=x(:,k)-T*rk1(:,k)+2*T*rk2(:,k);
    
    rk3(1,k)=midrk2(2,k);
    rk3(2,k)=-(alpha*midrk2(3,k) + beta*(1-(midrk2(1,k))^2)*midrk2(2,k) + midrk2(1,k));   
    x(:,k+1)=x(:,k)+(T/6)*(rk1(:,k)+4*rk2(:,k)+rk3(:,k));
end

%% Plot Love & Happiness vs Time
figure;
subplot(2,1,1)
plot(t(rk0:N),x(1,rk0:N))
xlabel('t')
ylabel('R')
title('Love Over Time')

subplot(2,1,2)
plot(t(rk0:N),x(2,rk0:N))
xlabel('t')
ylabel('H')
title('Happiness Over Time')

%% Plot Love vs Happiness
figure;
plot(x(1,rk0:N),x(2,rk0:N))
xlabel('R')
ylabel('H')
title('Romeos Love vs. Happiness')