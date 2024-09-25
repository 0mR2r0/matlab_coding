%Ejem 6.1 libro gockenbach
function [sys, x0, str, ts] = s_fun_simultaneo(t,x,u,flag)%Se retiro de las entradas x0 que corresponde a las condiones iniciales
switch flag
    case 0
        s=simsizes;
        %Variables de estado 
        s.NumContStates=6;
        %Variables de estado discreto
        s.NumDiscStates=0;
        %Variables de Salida
        s.NumOutputs=6;
        %Variables de entrada
        s.NumInputs=2;
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
        l=[0.25,0.5,0.75];
        x0=[exp(-100*(l(1)-0.5)^2),exp(-100*(l(2)-0.5)^2) , exp(-100*(l(3)-0.5)^2) ,0,0,0];
        
    case 1
        %Coeficientes
        k=10;
        h= 0.25;
        %Definir ecuaciones diferenciales(1)
        dU=[];
        %Ecuacion diferencial 1
        dU(1) = ((1-k*h)/h)*x(1)+k*x(4);
        %Ecuacion diferencial 2
        dU(2) = ((1-k*h)/h)*x(2)-(1/h)*x(1)+k*x(5);
        %Ecuacion diferencial 3
        dU(3) =((1-k*h)/h)*x(3)-(1/h)*x(2)+k*x(6);
        %Definir ecuaciones diferenciales(2)
        %Ecuacion diferencial 1
        dU(4) = -((2+k*h^2)/h^2)*x(4)+(1/h^2)*x(5)+k*x(1);
        %Ecuacion diferencial 2
        dU(5) = (1/(h^2))*x(4) -((2+k*h^2)/h^2)*x(5)+(1/h^2)*x(6)+k*x(2);
        %Ecuacion diferencial 3
        dU(6) = (1/(h^2))*x(5) -((2+k*h^2)/h^2)*x(6)+k*x(3);
        %Vector de derivadas
        sys=dU;
    case 3
        %Ecuaciones de salida
        %Vector de variables de salida
        sys=x;
    case {2 4 9}
        sys=[];
        otherwise
            error(['unhandled flag =',num2str(flag)])
end
