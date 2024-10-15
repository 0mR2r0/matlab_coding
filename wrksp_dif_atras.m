clear
clc
%Diferencias finitas hacia atras para el ejemplo del Salehi
n=20;
m=n/2;
L=1; %Longitud de la barra
h=L/(m-1);
k=10;
a=1/h;
b=(1-k*h);
c=1/(h^2);
d=(1-k*h^2)/(h^2);
%Se define la matriz de coeficientes
A=zeros(n,n);
for i=1:n
    if i<=m                         %Coeficientes para U1
        if i==1
            A(i , i)   = -a;
            A(i , i+1)   =  b;              %Posicion central
            A(i , m+2) =  k;
        elseif i==m
            A(i , i) = -a;
          
        elseif i<m
            A(i   , i) = -a;
            A(i   , i+1)   =  b;              
            A(i   , m+i+1) =  k;
        end
    elseif i>m
        if i==m+1
            A(i , i)   = -2*c;
            A(i , i+1)   =  d;              
            A(i , i-m+1) =  k;
        elseif i==n
            A(i , i) = -2*c;
        else
            A(i , i)   = -2*c;
            A(i , i+1)   =  d;              
            A(i , i-m+1) =  k;
        end
    end    
end
disp(A)
count=0;
x0_1=zeros(1,m);
x0_2=zeros(1,m);
        for i=1:m  %Vector de condiciones iniciales para U1(0)
            count=count+h;
            x0_1(1,i)=exp(-100*(count-0.5)^2);
        end   
        for i=1:m  %Vector de condiciones iniciales para U2(0)
            x0_2(1,i)=0;
        end
        ci=[x0_1,x0_2];
        x0=ci;
        disp(x0)