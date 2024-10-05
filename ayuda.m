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
        h=n/L;
        a=1;
        b=2;
        c=3;
        
%-------------------------------------------



        A=zeros(n,n)
%Ciclo para llenado de coeficientes de una matriz
        for i=1:n
            if  i==1
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
            if i==(n/2)+1
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
      disp(A)