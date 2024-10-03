%Ejem 6.1 libro gockenbach
function [sys, x0, str, ts] = s_fun_simultaneo_v2(t,x1,x2,u,flag)%Se retiro de las entradas x0 que corresponde a las condiones iniciales
switch flag
    case 0
        s=simsizes;
        %Variables de estado 
        s.NumContStates=10;
        %Variables de estado discreto
        s.NumDiscStates=0;
        %Variables de Salida
        s.NumOutputs=10;
        %Variables de entrada
        s.NumInputs=5;
        %Si las salidas dependen alegabraicamente de las entradas es 1, sino hay
        %entradas aqui es 0
        s.DirFeedthrough=0;
        %Numero de muestras de tiempo
        s.NumSampleTimes=1;
        sys=simsizes(s);
        %Vector vacio
        str=[];
        ts=[0 0];
        %Condiciones iniciales (Las condiciones iniciales se estan indicando por cada punto)
        global n h
        L=1; %Longitud de la barra
        n=5; %Numero de puntos y par
        l=0;
        h=L/n;% Paso de discretizacion espacial
        x0_1=zeros(1,n);
        x0_2=zeros(1,n);
        for i=1:n  %Vector de condiciones iniciales para U1(0)
            l=l+h;
            x0_1(1,i)=exp(-100*(l-0.5)^2);
        end   
        for i=1:n  %Vector de condiciones iniciales para U2(0)
            x0_2(2,i)=0;
        end
        x0=[x0_1,x0_2];
    case 1
        %Coeficientes
        k=10;
        a=1/2*h;
        b=1/h^2;
        c=(2+k*h^2)/(h^2);
        %Definir ecuaciones diferenciales(1)
        dU1=[];
        dU2=[];
        %Ecuacion diferencial 1
        dU1(1) = -k*x1(1) + a*x1(2) + k*x2(1);
        %Ecuacion diferencial 2
        dU1(2) = -a*x1(1) - k*x1(2) + a*x1(3) + k*x2(2);
        %Ecuacion diferencial 3
        dU1(3) = -a*x1(2) - k*x1(3) + a*x1(4) + k*x2(3);
        %Ecuacion diferencial 4
        dU1(4) = -a*x1(3) - k*x1(4) + a*x1(5) + k*x2(4);
        %Ecuacion diferencial 5
        dU1(5) = -a*x1(4) - k*x1(5) + k*x2(2);
        %Definir ecuaciones diferenciales(2)
        dU2(1) = -c*x2(1) + b*x2(2) - k*x1(1) ;
        %Ecuacion diferencial 2
        dU2(2) =  b*x2(1) - c*x2(2) + b*x2(3) - k*x1(2);
        %Ecuacion diferencial 3
        dU2(3) =  b*x2(2) - c*x2(3) + b*x2(4) - k*x1(3);
        %Ecuacion diferencial 4
        dU2(4) =  b*x2(3) - c*x2(4) + b*x2(5) - k*x1(4);
        %Ecuacion diferencial 5
        dU2(5) =  b*x2(4) - c*x2(5)  - k*x1(2);
        %Vector de derivadas
        sys=[dU1,dU2];
    case 3
        %Ecuaciones de salida
        %Vector de variables de salida
        sys=[x1,x2];
    case {2 4 9}
        sys=[];
        otherwise
            error(['unhandled flag =',num2str(flag)])
end
