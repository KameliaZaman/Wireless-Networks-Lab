%Rayleigh PDF
clc;
clear all;
close all;
N=200000; x=0:0.1:5; sigma=1; u=rand(1,N);
r=sigma*sqrt(-2*log(u)); %Rayleigh distributed random data
pdf=(x/sigma^2).*exp(-(x/sigma).^2/2); %Theoretical pdf
figure(1)
subplot(2,1,1)
z=hist(r, x);
zn=z/sum(z);
stem(x, zn, 'b')
grid on
title('Simulation')
subplot(2,1,2)
stem(x,pdf/sum(pdf))
grid on
title('Theoritical')


%Comparison of Theoretical and analytical BER vs SNR
%Initialization of parameters
clc
clear all
close all
Eb=1; %energy per bit
Eb_N0_dB=0:1:20; %range of Eb/N0
N0=Eb*10.^(-Eb_N0_dB/10);
%The range of N0
sigma=1;
BER=zeros(1,length(Eb_N0_dB));
%initialization of array
for i=1:length(Eb_N0_dB);
    no_error=0; no_bit=0;
    %taking m = 0 i.e. all 0s are transmitted
    while no_error<=100
        u=rand; x=sigma*sqrt(-2*log(u));
        noise=sqrt(N0(i))*randn;
        %normal pdf with var of No
        y=x*sqrt(Eb)+noise;
        if y<=0
            y_d=1;
        else
            y_d=0;
        end %end of if statement
        no_bit=no_bit+1;
        no_error=no_error+y_d;
    end %end of while loop
    BER(i)=no_error/no_bit;
end %end of for loop
rho=(Eb./N0)* sigma*sigma;
Pb=0.5*(1-sqrt(rho./(1+rho)));
semilogy(Eb_N0_dB, BER, '--b*',Eb_N0_dB, Pb, ':rp')
legend('Simulation','Analytical')
xlabel('Eb/N0')
ylabel('BER')
title("Comparison of Experimental & Theoretical BER vs SNR")
grid on
