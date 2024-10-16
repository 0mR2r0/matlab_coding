clc
clear
%Workspace para integrar con simulink, sistema de ecuaciones discretas con
%diferencias finitas Salehi 
L=1;

n=18;
m=n/2;
k=10;
h=1/10;
a=1/(2*h);
b=1/(h^2);
c=(2+k*h^2)/(h^2);
A=zeros(n,n);
%Ciclo para llenado de coeficientes de una matriz
        for i=1:n
            if  i<(n/2)+1
                if i==1
                    A(i,i)      = -k;
                    A(i,i+1)    = a;
                    A(i,m+i)    = k;
                elseif i==m
                    A(i,i-1)    = -a;
                    A(i,i)      =  -k;
                    A(i,m+i)    = k;
                elseif i<m
                    A(i,i-1)    = -a;
                    A(i,i)      = -k;
                    A(i,i+1)    = a;
                    A(i,m+i)    = k;
                end
            else
                if  i==(n/2)+1
                    A(i,1)      = k;
                    A(i,i)      = -c;
                    A(i,i+1)    = b;
                elseif i==n
                    A(i,i-1)    = b;
                    A(i,i)      =  -c;
                    A(i,m)      = k;
                elseif i>(n/2)+1
                    A(i,i-1)    = b;
                    A(i,i)      = -c;
                    A(i,i+1)    = b;
                    A(i,i-m)    = k;
                end    
            end
        end
x0_1=zeros(1,m);
x0_2=zeros(1,m);
        count=0;
        for i=1:n/2  %Vector de condiciones iniciales para U1(0)
            count=count+h;
            x0_1(1,i)=exp(-100*(count-0.5)^2);
        end   
        for i=1:n/2  %Vector de condiciones iniciales para U2(0)
            x0_2(1,i)=0;
        end
        ci=[x0_1,x0_2];
        x0=ci;
 tiempo=out.simout.time;
 solucion=out.simout.signals.values;
plot(solucion(:,5),tiempo)