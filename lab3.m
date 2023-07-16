%Plot PDF of exponential distribution with λ=0.5 
t = 0:0.01:10; 
Lambda=0.5; 
x = exppdf(t,1/Lambda); 
plot(t,x)
xlabel('t')
ylabel('f(t)') 
title('Exponential PDF')

%Plot CDF of exponential distribution with λ=0.5
t = 0:0.001:10;
Lambda=0.5;
P = expcdf(t,1/Lambda); 
plot(t,P)
xlabel('t')
ylabel('F(t)') 
title('Exponential CDF')


M=200000; %Number of bits used for simulation against each SNR
for k=1:8 % loop for SNR
    SNR=2+k*2; %The value of SNR in dB
    tx=randi(2, M, 1)-1; %Sequence of 0 and 1
    rx=awgn(tx,SNR);
    e(k)=0; %initialization of error 
    for i=1:M %for loop of error
        if tx(i)==1 
            if rx(i)<=0.5 
                e(k)=e(k)+1;
            end
        end
        if tx(i)==0
            if rx (i)>=0.5
                e(k)=e(k)+1; 
            end
        end
    end %for loop of error
end %loop for SNR

pe=e/M; %probability of error
SNR=4:2:18;
SNR_a=10.^(SNR/10); %absolute value of SNR
pb=qfunc(sqrt(SNR_a/4)); %Theoretical Pb
plot(SNR,pe,'r>:',SNR,pb,'bs:')
legend('simulation','theory')
xlabel('SNR')
ylabel('Pe\Pb')
disp('Error between simulation & theory: ')
disp(abs((pe-pb)/pb)*100)
grid on;
