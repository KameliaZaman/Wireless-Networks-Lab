%QAM Digital Communication System under AWGN
M = 16; %M=16 is taken for 16-QAM modulator
Fd = 1; %symbol rate 
Fs = 10; %sampling rate
D = 1000; % Number random data [0, 15]
msg_d = randi([0 M-1],D,1); % Random signal
% Modulate using 16 points constellation QASK method.
msg_a = qammod(msg_d,M);
N = Fs/Fd; %number of sample per trace, N>=1
W=0.5; %transition BW of the filter
period=1/Fd; %Range of horizontal axis 
delay = 3; % Delay of the raised cosine filter
offset = 0;
rcv = rcosflt(msg_a,Fd,Fs,'fir/normal',W,delay);
%received signal
%communication channel is equivalent to a rising cosine filter
h1 = eyediagram(rcv, N, period, offset);%eye diagram
h2 = scatterplot(rcv, N, offset, 'k*');%scattered plot 
%let us add some noise with signal
rcv1=awgn(rcv, 4); % 4 dB AWGN noise with rcv
h3 = eyediagram(rcv1, N,period, offset);
h4 = scatterplot(rcv1, N, offset, 'k*');
%Detection of symbol Error
Re= qamdemod(rcv1,M);
k=1;
L=length(rcv1)/N; 
%here N = 10 samples per rcv symbols are used so 
%length is reduced by N
for j=1:L
    Re_s(j) = Re(k); 
    %every 10th or Nth sample is considered as the 
    %received symbol
    k = k+N;
end
%similariry is found from 7th symbol of Re_s and 4th
%symbol of msg_d
e = symerr(Re_s(7:1003), msg_d(4:1000)');