clear
clc

k=0;
x0=[];
syms x h k
%Ciclo for para llenar medio vector de datos y el resto con ceros
%n=4; %Numero de puntos
%l=0;
%L=1; %Longitud de la barra
%h=L/10;
%x0=zeros([2, n]);
%for i=1:n %Vector de condiciones iniciales de U1(0)
 %   l=l+h;
  %  x0(1,i)=1;
%end

%-------------------------------------------
%Coeficientes
        L=1;
        n=8; %n debe ser par
        k=10;
        h=L/n;
        a=1;
        b=2;
        c=3;
        carry=0;
%-------------------------------------------

        u=zeros(1,n);
        for i=1:n
            u(1,i)=1;
        end
        u
        A=zeros(n,n);
%Ciclo para llenado de coeficientes de una matriz
        for i=1:n
            if  i<(n/2)+1
                if i==1
                    A(i,i)   = -k;
                    A(i,i+1) = a;
                    A(i,i+4) = k;
                elseif i==4
                    A(i,i-1)   = -a;
                    A(i,i)   =  -k;
                    A(i,i+4) = k;
                elseif i<4
                    A(i,i-1) = -a;
                    A(i,i)   = -k;
                    A(i,i+1) = a;
                    A(i,i+4) = k;
                end
            else
                if  i==(n/2)+1
                    A(i,1)   = k;
                    A(i,i) = -c;
                    A(i,i+1) = b;
                elseif i==n
                    A(i,i-1)   = b;
                    A(i,i)   =  -c;
                    A(i,n/2) = k;
                elseif i>(n/2)+1
                    A(i,i-1) = b;
                    A(i,i)   = -c;
                    A(i,i+1) = b;
                    A(i,i-4) = k;
                end    
            end
        end
A
%
m=20;
x=ones(1,m);
for i=1:m
            
                if i ==1
                    U(1,i)  = a*x(i+1)  - k*x(i)            + k*x((m/2)+1);   %Cuando i=1 para U1 y se aplican las condiciones de frontera
                elseif i<m/2
                    U(1,i) =  a*x(i+1)  - k*x(i) - a*x(i-1) + k*x((m/2)+1);
                elseif i==m/2
                    U(1,i) =            - k*x(i) - a*x(i-1) + k*x((m/2)+1);
                elseif i==(m/2)+1
                    U(1,i)=             - c*x(i) + b*x(i+1) + k*x(i-(m/2));
                elseif i==m
                    U(1,i)=    b*x(i-1) - c*x(i)            + k*x(m/2);
                elseif i<m
                    U(1,i)=    b*x(i-1) - c*x(i) + b*x(i+1) + k*x(i-(m/2));
                end
end
U