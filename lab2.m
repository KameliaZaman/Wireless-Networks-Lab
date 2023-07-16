%Simulation of probability of false alarm and probability of detection
%# for H0 
clc; 
clear all; 
close all; 
%% 
var =5; 
N=10; 
M=100; 
T= zeros(M,1); 
for i=1:M 
    x=sqrt(var)*randn(N,1); 
    T(i)=mean(x); 
end 
gamma=0:0.25:6; 
P=zeros(length(gamma),1); 
for i=1:length(gamma) 
    clear Mgain; 
    Mgam=find(T>gamma(i)); 
    PFA_sim(i)=length(Mgam)/M; 
end 
PFA_th=qfunc(gamma/(sqrt(var/N))); 
figure(1) 
plot(gamma,PFA_sim,'--*r',gamma,PFA_th,':bd') 
xlabel("Gamma") 
ylabel("Probablility of False Alarm(PFA)") 
grid on 
title("Comparison of Experimental PFA & Theoretical PFA")
%% 
%# for H1 
A=2; 
T= zeros(M,1);
for i=1:M 
    x=sqrt(var)*randn(N,1)+A; 
    T(i)=mean(x); 
end 
P=zeros(length(gamma),1); 
for i=1:length(gamma) 
    clear Mgain; 
    Mgam=find(T>gamma(i)); 
    PD_sim(i)=length(Mgam)/M; 
end 
PD_th=qfunc((gamma-A)/(sqrt(var/N))); 
figure(2) 
plot(gamma,PD_sim,'--r*',gamma,PD_th,':bd') 
xlabel("Gamma") 
ylabel("Probability of Detection(PD)") 
grid on 
title("Comparison of Experimental PD & Theoretical PD") 
%% 
figure(3) 
plot(gamma,PD_sim,'--r*',gamma,PD_th,':bd',gamma,PFA_sim,'--gp',gamma,PFA_th,':mh')
legend('Simulation PD','Analytical PD','Simulation PF','Analytical PF') 
xlabel('gamma') 
ylabel('PF and PD') 
title("Comparison Between PF and PD") 
grid on
