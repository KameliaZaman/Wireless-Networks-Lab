%Ques1: Determine B(n,A) using Erlang’s formula taking A=12 Erls and n=15 
A=12; 
n=15; 

s=1; 
for i=1:n 
    s=s+(A^i)/factorial(i); 
end 

B=((A^n)./factorial(n))/s; 
fprintf("B(n,A) is: \n") 
disp(B) 

%RECURRENCE RELATION 
%Ques2: proof this using recurrence relation 
clc; 
clear all 
close all 
A=12; 
n=15;
BO=1; 
B(1)=(A*BO)/(1+A*BO); 
for i=2:n 
    B(i)=(A*B(i-1))/(i+A*B(i-1)); 
end 
B(n) 
plot(1:n,B,'--ob','LineWidth',3); 
xlabel('n'); 
ylabel('B'); 
grid on; 
title("B vs n Plot Using Recurrence Relation") 

%Ques 3: Determine offered traffic A taking n=15 and B=0.05 
clc 
clear all 
close all 
n=15; 
Bexp=0.05;
A=8; 
e=2; 
while e>0.0001 
    s=1; 
    for i=1:n; 
        s=s+(A^i)/factorial(i); 
    end 
    B=((A^n)./factorial(n))/s; 
    e=abs(B-Bexp); 
    A=A+0.001; 
    fprintf("%.4f\n", A) 
end

A1=1; 
A2=2; 
x1=2; 
x2=3; 
BW = 9; 
M =ceil(BW/x1); %size of the matrix is M by M 
for i=1:M 
    for j=1:M 
        e = (i-1)*x1+(j-1)*x2; 
        if e <= 9 
            S(i, j)= ((A1^(i-1))/factorial(i-1))* ((A2^(j-1))/factorial(j-1)); 
        else 
            S(i, j)=0; 
        end 
    end 
end 
% rows should be made reversed to cope with Cartesian co-ordinate system 
for i=1:M 
    for j=1:M 
        k=M-i+1; 
        S1(i, j)=S(k, j); %states are now S1(x,y) 
    end 
end
T=sum(sum(S1)); 
Sn=S1/T; 
B2 = 0; 
for i =1:M 
    for j =1:M 
        k=j+1; 
        if Sn(i, j) > 0 && Sn(i, k)==0 
            B2 = B2+Sn(i, j); 
        end 
    end 
end 
% open states of roof 
B1= 0; 
for i = 2:M %start with 2nd row 
    for j=1:M 
        k=i-1; 
        if Sn(i, j)>0 && Sn(k, j)==0 
            B1= B1+Sn(i, j); 
        end 
    end 
end 
B1=B1+Sn(1,1);
