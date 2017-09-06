function m = Funcion_Calcula_Hu(Ima)

% Calculo de momentos Hu.
% Devuelve un vector columna con los 4 momentos de Hu calculados sobre la imagen Ima.

Ima = double(Ima);

[F C] = size(Ima);
nFila = F*C;

% Para poder hacer las multiplicaciones tenemos
% que convertir los vectores en columnas
x = zeros(nFila,1);
y = zeros(nFila,1);

% Cálculo de x e y
k=1;
for j=1:C
    for i=1:F
         x(k) = j;
         y(k)=i;
         k = k + 1;         
    end
end

% Convertimos la imagen a vector columna
Ima = Ima(:);

mo.m00 = sum(Ima); % Objeto m

% OJO con el . que son multiplicaciones de vectores
% Momentos ordinarios de orden:
mo.m11 = sum(x .* y .* Ima);
mo.m10 = sum(x .* Ima);
mo.m01 = sum(y .* Ima);
mo.m20 = sum(x.^2 .* Ima);
mo.m02 = sum(y.^2 .* Ima);
mo.m30 = sum(x.^3 .* Ima);
mo.m03 = sum(y.^3 .* Ima);
mo.m12 = sum(x .* y.^2 .* Ima);
mo.m21 = sum(x.^2 .* y .* Ima);

% Coordenadas X e Y del centroide
xmedio = mo.m10 / mo.m00;
ymedio = mo.m01 / mo.m00;

w00 = mo.m00; 
w20 = mo.m20 - xmedio*mo.m10;
w02 = mo.m02 - ymedio*mo.m01;
w11 = mo.m11 - ymedio*mo.m10;
w30 = mo.m30 - 3 *xmedio*mo.m20 + 2*xmedio^2 * mo.m10;
w03 = mo.m03 - 3*ymedio*mo.m02 + 2*ymedio^2 * mo.m01;
w12 = mo.m12 - 2*ymedio*mo.m11 - xmedio * mo.m02 + 2 * ymedio^2 * mo.m10;
w21 = mo.m21 - 2*xmedio*mo.m11 - ymedio * mo.m20 + 2 * xmedio^2 * mo.m01;

% Momentos centrales normalizados necesarios: 02,20,11,30,12,21 y 03
gamma = 2; % 2/2 + 1 = 2
n02 = w02 / w00^gamma;
n20 = w20 / w00^gamma;
n11 = w11 / w00^gamma;
gamma = 2.5;
n30 = w30 / w00^gamma;
n12 = w12 / w00^gamma;
n21 = w21 / w00^gamma;
n03 = w03 / w00^gamma;

 % Fi necesarios:  1 al 7
fi(1) = n20 + n02;
fi(2) = ((n20 - n02)^2) + 4 * n11^2;
fi(3) = (n30 - 3 * n12)^2 + (3 * n21 - n03)^2;
fi(4) = (n30 - n12)^2 + (n21 - n03)^2;
fi(5) = (n30 - 3 * n12) * (n30 + n12) * ( (n30 + n12)^2 -  3 * (n21 + n03)^2 ) + (3 * n21 - n03) * (n21 + n03) * ( 3 * (n30 + n12)^2 -  (n21 + n03)^2 );
fi(6) = (n20 - n02) * ( (n30 + n12)^2 - (n21 + n03)^2 ) + 4 * n11 * (n30 + n12) * (n21 + n03);
fi(7) = ( 3 * n21 - n30) * (n30 + n12) * ( (n30 + n12)^2 - 3 * (n21 + n03)^2) +(3 * n21 - n03) * (n21 + n03) * (3 * (n30 + n12)^2 - (n21 + n03)^2 );


for k=1:7     % Al final calcular los 7, no los 4            
   if (fi(k) == 0)
      fi(k) = 1e-100;
   end
end
            
m = abs(log(abs(fi)));
m = m(:); % Vector columna. sale como vector fila