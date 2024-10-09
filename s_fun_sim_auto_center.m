%Ejem 6.1 libro gockenbach

function [sys, x0, str, ts] = s_fun_sim_auto_center(t,x,u,flag)%Se retiro de las entradas x0 que corresponde a las condiones iniciales
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
        
        n=10;
        l=0;
        x0=zeros(1,n);
        for i=1:n
            if i<=(n/2) %Se inicia con las condiones iniciales f(1)= exp(-100*(x-0.5)^2)
                l=l+0.1;
                x0(1,i)=exp(-100*(l-0.5)^2);
            else  %Se rellena el vector con ceros f(2)=0
                l=0;
                x0(1,i)=l;
            end
        end   
        
    case 1
        %Coeficientes
        L=1;
        n=10; %n debe ser par
        k=10;
        h=n/L;
        a=1/(2*h);
        b=1/(h^2);
        c=(2+k*h^2)/(h^2);
        %Definir vector de ecuaciones diferenciales
        dU=zeros(1,n);
        %Ciclo para llenado de ecuaciones en un vector de derivadas
        for i=1:n
            if i<=(n/2)
                if i==1
                    dU(1,i)=a*x(i+1) - k*x(i) + k*x((n/2)+1); %Cuando i=1 para U1 y se aplican las condiciones de frontera
                else
                    dU(1,i) = a*x(i+1) - k*x(i) - a*x(i-1) + k*x((n/2)+1);
                end
            else
                if i==(n/2)+1  %Cuando i=1 para U2 y se aplican las condiciones de frontera
                    dU(1,i)= - c*x(i) + b*x(i+1) + k*x(i-(n/2));
                elseif i==10
                    dU(1,i)= b*x(i-1) - c*x(i) + k*x(i-(n/2));
                else
                    dU(1,i)= b*x(i-1) - c*x(i) + b*x(i+1) + k*x(i-(n/2));
                end    
            end
        end
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
