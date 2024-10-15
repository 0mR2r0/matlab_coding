clear
clc
%Diferencias finitas hacia atras para el ejemplo del Salehi
n=20;
m=n/2;
L=1; %Longitud de la barra
h=L/(m-1);
k=10;
a=(3-2*k*h)/(2*k);
b=(-2/h);
c=1/(2*h);
D=(2-k*h^2)/(h^2);
E=(-5/h^2);
F=4/h^2;
G=(-1/h^2);
%Se define la matriz de coeficientes
A=zeros(n,n);
for i=1:n
    if i<=m                         %Coeficientes para U1
        if i==1
            A(i , i)     =  c;
            A(i , i+1)   =  b;             
            A(i , i+2)   =  a;
            A(i , m+3)   =  k;
        elseif i==m
            A(i , i)     =  c;
            A(i , i+1)   =  b;
            A(i , i+2)   =  a;
        elseif i<m
            A(i , i)     =  c;
            A(i , i+1)   =  b;             
            A(i , i+2)   =  a;
            A(i , i+m+2)   =  k;
        end
    elseif i>m
        if i==m+1
            A(i , i)       =  F;
            A(i , i+1)     =  E;             
            A(i , i+2)     =  D;
            A(i , i-m+2)   =  k;
        elseif i==n
            A(i , i-1)     =  G;
            A(i , i)       =  F;
            A(i , i+1)     =  E;
            A(i , i+2)     =  D;
        elseif i>m
            A(i , i-1)     =  G;
            A(i , i)       =  F;
            A(i , i+1)     =  E;             
            A(i , i+2)     =  D;
            A(i , i-m+2)   =  k;
        end
    end    
end
disp(A)
count=0;
x0_1=zeros(1,m+1);
x0_2=zeros(1,m+1);
        for i=1:m+1  %Vector de condiciones iniciales para U1(0)
            count=count+h;
            x0_1(1,i)=exp(-100*(count-0.5)^2);
        end   
        for i=1:m+1 %Vector de condiciones iniciales para U2(0)
            x0_2(1,i)=0;
        end
        ci=[x0_1,x0_2];
        x0=ci;
      