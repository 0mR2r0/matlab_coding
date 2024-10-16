%Ejem 6.1 libro gockenbach

function [sys, x0, str, ts] = s_fun_sim_auto_center_v2(t,x,u,flag)%Se retiro de las entradas x0 que corresponde a las condiones iniciales
switch flag
    case 0
        s=simsizes;
        %Variables de estado 
        s.NumContStates=20;
        %Variables de estado discreto
        s.NumDiscStates=0;
        %Variables de Salida
        s.NumOutputs=20;
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
       
        L=1;
        n=10; %Numero de puntos y par
        ct=0;
        h=L/n;% Paso de discretizacion espacial
        x0_1=zeros(1,n);
        x0_2=zeros(1,n);
        for i=1:n  %Vector de condiciones iniciales para U1(0)
            ct=ct+h;
            x0_1(1,i)=exp(-100*(ct-0.5)^2);
        end   
        for i=1:n  %Vector de condiciones iniciales para U2(0)
            x0_2(1,i)=0;
        end
        x0=[x0_1,x0_2];
    case 1
        %Coeficientes
        L= 1;
        n= 10;
        k= 10;
        h= L/n;
        a= 1/(2*h);
        b= 1/(h^2);
        c=(2+k*h^2)/(h^2);
        %Definir vector de ecuaciones diferenciales
        m=2*n;
        U=zeros(1,m);
        
        %Ciclo para llenado de ecuaciones en un vector de derivadas de U
        
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
        disp(U)
        %Vector de derivada
        
        sys=U;
    case 3
        %Ecuaciones de salida
        
        %Vector de variables de salida
        sys=x;
    case {2 4 9}
        sys=[];
        otherwise
            error(['unhandled flag =',num2str(flag)])
end
