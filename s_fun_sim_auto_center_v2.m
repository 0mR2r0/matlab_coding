%Ejem 6.1 libro gockenbach

function [sys, x0, str, ts] = s_fun_sim_auto_center_v2(t,x1,x2,u,flag)%Se retiro de las entradas x0 que corresponde a las condiones iniciales
switch flag
    case 0
        s=simsizes;
        %Variables de estado 
        s.NumContStates=8;
        %Variables de estado discreto
        s.NumDiscStates=0;
        %Variables de Salida
        s.NumOutputs=8;
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
        L=1; %Longitud de la barra
        n=4; %Numero de puntos
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
        L=1;
        n=4; %n debe ser par
        k=10;
        h=n/L;
        a=1/(2*h);
        b=1/(h^2);
        c=(2+k*h^2)/(h^2);
        %Definir vector de ecuaciones diferenciales
        U1=zeros(1,n);
        U2=zeros(1,n);
        x1=zeros(1,n);
        x2=zeros(1,n);
        %Ciclo para llenado de ecuaciones en un vector de derivadas de U1
        for i=1:n
            if i ==1
               U1(1,i)=a*x1(i+1) - k*x1(i) + k*x2(i); %Cuando i=1 para U1 y se aplican las condiciones de frontera
            elseif i==n
                U1(1,i) = - k*x1(i) - a*x1(i-1) + k*x2(i);
            else
                U1(1,i) = a*x1(i+1) - k*x1(i) - a*x1(i-1) + k*x2(i);
            end
        end
        %Ciclo para llenado de ecuaciones diferenciales para U2 en un
        %vector
        for i=1:n
            if i==1
                U2(1,i)= - c*x2(i) + b*x2(i+1) + k*x1(i);
            elseif i==n
                U2(1,i)= b*x2(i-1) - c*x2(i) + k*x1(i);
            else
                U2(1,i)= b*x2(i-1) - c*x2(i) + b*x2(i+1) + k*x1(i);
            end
        end
        %Vector de derivada
        dU=[U1,U2];
        sys=dU;
    case 3
        %Ecuaciones de salida
        
        %Vector de variables de salida
        sys=[x1,x2];
    case {2 4 9}
        sys=[];
        otherwise
            error(['unhandled flag =',num2str(flag)])
end
