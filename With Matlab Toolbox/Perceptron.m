clc; clear; close all;
%1. Fijar pesos aleatorios
Wn=rand(2,1);
%2. Establecer los valores de entrada
X=[0 0; 0 1;1 0;1 1];
yd=[0;0;0;1];
Th=0.1; %Bias o referencia del Perceptrón %3. Calcular la salida de la neurona yd=[0;0;0;1];
y=hardlim((X*Wn)-Th);
plot(X,y),grid on, hold on
e=yd-y; %Se calcula el error al restar la salida deseada de la salida obtenida.
ed=0.1;% Se establece el error aceptado, en éste caso 0.1
N=2; %se establecen las iteraciones, pueden ser definidas por la velocidad de aprendizaje
%Aquí empieza el entrenamiento de la neurona, se hace de manera recursiva %W(i,j) i=fila; j= Columna
n=0.9; %Factor de ganancia en el rango de 0.0 a 1.0
ent=2;
r=0;
% Se inician los nuevos pesos
for T=1:N %Ciclo for correspondiente a las iteraciones del aprendizaje por refuerzo
    if e==0 break
    else
        for i=1:4 %Ciclo for correspondiente alas filas según no de entradas i=filas
            for k=1:ent %Ciclo for para actualizar pesos. k=columnas
                  Wn(k,1)=Wn(k,1)+(n*(X(i,k)*e(i,1)))
            end
        yn(i,1)=(hardlim((X(i,1)*(Wn(1,1)- Th))+((X(i,2)*Wn(2,1)-Th)))) %Función para calcular las nuevas salidas.
        end
    e=yd-yn
    M=e-ed
    T %si el error es mayor que la tolerancia continua haciendo el proceso se define la velocidad de aprendizaje para aplicar la forma de calcular nuevos peso
    end
end
%5. Continua hasta que el error sea menor que la tolerancia