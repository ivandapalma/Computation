%% Ejercicio 1 PROFESOR
datos=imaqhwinfo('winvideo');
%Video de la camara, dispositivo 1, modo YUY2_640x360
video=videoinput('winvideo',1,'YUY2_640x360'); 
video.ReturnedColorSpace='rgb'; % Video en modo RGB
preview(video); %Previsualiza antes de la foto
Iv = getsnapshot(video); % Toma una foto

%Media de las tres matrices RGB
I = uint8(double(Iv(:,:,1))+double(Iv(:,:,2))+double(Iv(:,:,3)))/3;


umbrales = [50 130 160];

[N M] = size(OI);

% NumPixFilt = round

% subplot

Ib = (I>Umbral); % Binarizacion

[Ietiq M] = bwlabel(Ib);

if N>5
    stats = regionprops(Ietiq,'Area');
    areas = cat(1,stats,Area);
    areas_ord = sort(areas,'descend'); % Ordena mayor a menos
    NumPix = areas_ord(5); % Quinto objeto mayor
    % para que kite todo aquello que no tenga un numero
    % mayor que ese (para coger los 5 primeros)
    
    % Imagen filtrada quedandose
    %con los 5 mas altos
    Ib_filt = bwareaopen(Ib,NumPix); 
    
else
    Ib_filt = Ib;
end

[Ietiq M ] = bwlabel(Ib_filt);
stats = regionprops(Ietiq,'Area','Centroid');
%%



%% Ejercicio 1
clc
close all
clear all

datos = imaqhwinfo('winvideo');
video = videoinput('winvideo',1,'YUY2_640x360');
video.ReturnedColorSpace = 'RGB';
preview(video); % Previsualizamos
Iv = getsnapshot(video); % Obtenemos imagen

%Hacemos la media de las imagenes
I = uint8((double(Iv(:,:,1))+double(Iv(:,:,2))+double(Iv(:,:,3)))/3);
imshow(I);

% Umbrales para las imagenes
umbrales = [50 150 200];

% Imagen 1. ORIGINAL
subplot(2,2,1); 
imshow(I)

% Imagen 2. Umbral 1
subplot(2,2,2);
Im = I > umbrales(1);
[F C] = find(Im==1);
subimage(I),hold on
plot(C,F,'.b')

subplot(2,2,3); % Imagen 3. Umbral 2
Im = I > umbrales(2);
[F C] = find(Im==1);
subimage(I),hold on
plot(C,F,'.b')

subplot(2,2,4); % Imagen 4. Umbral 3
Im = I > umbrales(3);
[F C] = find(Im==1);
subimage(I),hold on
plot(C,F,'.b')
%%



%% Ejercicio 2
path(path,'Funciones');

I=imread('0.tif');
I2=I>75;
I3=I>125;
I4=I>190;

[ME1 N1]=Funcion_Etiquetar(I);
[ME2 N2]=Funcion_Etiquetar(I2);
[ME3 N3]=Funcion_Etiquetar(I3);
[ME4 N4]=Funcion_Etiquetar(I4);

A1=Calcula_Areas(ME1);
A2=Calcula_Areas(ME2);
A3=Calcula_Areas(ME3);
A4=Calcula_Areas(ME4);

centroides1=Calcula_Centroides(ME1,N1);
centroides2=Calcula_Centroides(ME2,N2);
centroides3=Calcula_Centroides(ME3,N3);
centroides4=Calcula_Centroides(ME4,N4);

Amax1=find(A1==max(A1));
Amax2=find(A2==max(A2));
Amax3=find(A3==max(A3));
Amax4=find(A4==max(A4));

subplot(2,2,1)
imshow(I),hold on
plot(centroides1(:,2),centroides1(:,1),'*b')
plot(centroides1(Amax1,2),centroides1(Amax1,1),'*r')

subplot(2,2,2)
imshow(I2),hold on
plot(centroides2(:,2),centroides2(:,1),'*b')
plot(centroides2(Amax2,2),centroides2(Amax2,1),'*r')

subplot(2,2,3)
imshow(I3),hold on
plot(centroides3(:,2),centroides3(:,1),'*b')
plot(centroides3(Amax3,2),centroides3(Amax3,1),'*r')

subplot(2,2,4)
imshow(I4),hold on
plot(centroides4(:,2),centroides4(:,1),'*b')
plot(centroides4(Amax4,2),centroides4(Amax4,1),'*r')

%%




%% Ejercicio 3
datos=imaqhwinfo('winvideo');
video=videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace='grayscale';
video.TriggerRepeat=inf;
video.FramesPerTrigger=1; 
video.FrameGrabInterval=5;

gamma = 4;
incremento = 1/9;
% Si GAMMA es menor que 1, el mapeo se pondera hacia valores de salida superiores (brillante)
% Si GAMMA es mayor que 1, el mapeo se pondera hacia (más oscuros)
% Por lo tanto empezamos en un valor mayor que uno (oscuro) y vamos
% decrementando gamma (valores más claros)

start(video)
while (video.FramesAcquired < 50)
    I=getdata(video,1);
    imshow(imadjust(I,[],[],gamma))
    gamma = gamma - incremento;
end
stop(video)
%%


%% Ejercicio 4
datos=imaqhwinfo('winvideo');
video=videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace='grayscale';
video.TriggerRepeat=inf;
video.FramesPerTrigger=1; 
video.FrameGrabInterval=5;

umbral = 0;
incremento=250/50; % Poner mejor 1/3

start(video)
while (video.FramesAcquired < 50)
    I=getdata(video,1);
    imshow(I > umbral)
    umbral = umbral + incremento;
end
stop(video)

%%



%% Ejercicio 5
datos=imaqhwinfo('winvideo');
video=videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace='grayscale'; % Directamente a escala de grises
video.TriggerRepeat=inf;
video.FramesPerTrigger=1; 
video.FrameGrabInterval=5;

umbral = 0;
incremento = 250/50; % Poner mejor 1/3

start(video)
I2=getdata(video,1);
while (video.FramesAcquired<50)
    I = getdata(video,1);
    imshow(imabsdiff(I,I2))
    I2 = I;
end
stop(video)

%%



%% Ejercicio 6

datos=imaqhwinfo('winvideo');
video=videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace='grayscale';
video.TriggerRepeat=inf;
video.FramesPerTrigger=1; 
video.FrameGrabInterval=5;

umbral = 75; %Hay que poner que la imagen sea mayor o menor que un umbral

start(video)
I2=getdata(video,1);
while (video.FramesAcquired < 100)
    I=getdata(video,1);
    ImagDiff = imabsdiff(I,I2);
    imshow(ImagDiff > umbral)
    I2=I;
end
stop(video)
%%



%% Ejercicio 7

datos=imaqhwinfo('winvideo');
video=videoinput('winvideo',1,'YUY2_320x240');
video.ReturnedColorSpace='grayscale';
video.TriggerRepeat=inf;
video.FramesPerTrigger=1; 
video.FrameGrabInterval=5;

umbral = 0;

start(video)

I2=getdata(video,1);
while (video.FramesAcquired<100)
	I=getdata(video,1);
	Idiff = imabsdiff(I,I2) > 100;
	[Ietiq N] = bwlabel(Idiff,8);
	imshow(Idiff),hold on;
	
	if (N > 0)
		stats = regionprops(Ietiq,'Area','Centroid'); % Calculamos areas y centroides
		areas = cat(1,stats.Area); % pasamos a matriz las areas
		centroides = cat(1,stats.Centroid); % pasamos a matriz los centroides
		Amax = find(areas==max(areas)); % Encontramos los índices del área maxima
		plot(centroides(Amax,2),centroides(Amax,1),'*r') % Mostramos su centrodide con un punto rojo
	else
		plot(1,1,'*r') % Sino mostramos un punto en el pixel (1,1)
	end
	I2 = I; % La imagen nueva pasa ahora a ser la antigua, ya que se generará otra nueva en I
end
stop(video)



%%
