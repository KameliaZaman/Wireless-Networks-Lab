%Task1
clc;
clear all;
close all;
A=[-1 0 0; 1 -2 3; 0 2 -3];
Q=A*A';
[U, D] = eigs(Q);
U*D*U';

%Task2
clc;
clear all;
close all;
x=[0.2+0.4i; 1.1-0.6i; 0.45-0.34i; 1.2+1.4i];
n=[0.001+0.02i; 0.003-0.005i; 0.04-0.003i; 0.0012-0.003i];
H=[0.23-0.12i -0.612+0.09i -0.71+0.12i 0.32+0.11i;
0.112-0.098i 0.16+0.23i 0.154-0.22i 0.32-0.23i;
-0.53-0.12i 0.321-0.25i 0.56-0.076i 0.71-0.22i;
0.86-0.23i -0.887-0.099i 0.23+.76i 0.45-0.42i];
r=H*x+n; %Received signal vector
Q1=H*ctranspose(H); %HHH matrix
[U, D1]=eigs(Q1);
D=sqrt(D1);
np= ctranspose(U)*n; %ń=U^Hn
xp= ctranspose(U)*x; % x=U^Hx;
disp("Value of rp :")
rp= D*xp +np;

%Task3
% Channel capacity of four antenna case
clc;
clear all;
close all;
nT=4;
H4=[0.23-0.12i -0.612+0.09i -0.71+0.12i 0.32+0.11i;
0.112-0.098i 0.16+0.23i 0.154-0.22i 0.32-0.23i;
-0.53-0.12i 0.321-0.25i 0.56-0.076i 0.71-0.22i;
0.86-0.23i -0.887-0.099i 0.23+.76i 0.45-0.42i];
Q4 = H4*ctranspose(H4);
for i=1:10
    SNR(i)=1+3*i;
    Im4 = [1 0 0 0; 0 1 0 0; 0 0 1 0;0 0 0 1];
    CW4(i) = log2(det(Im4+(Q4/nT)*SNR(i)));
    CW(i) = log2(1+SNR(i));
end
plot(SNR,CW4, ':r*', SNR,CW, '--bp');
hold on
xlabel('SNR')
ylabel('Channel Capacity/Hz')
title('Channel Capacity of MIMO Link')
grid on
legend('MIMO', 'Single Antenna')