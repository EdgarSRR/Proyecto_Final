%% Morfología matemática: 
%Erosión, dilatación, apertura, cierre.

%% Limpiando el espacio de trabajo
close all; clc; clear all;

%% Lectura de imagen RGB y transformación a escala de gris.
%Imagen en RGB
addpath('/MATLAB Drive/Train_data')
I_rgb = imread('Arborio(5).jpg');
I_rgb4 = imread('Jasmine(5).jpg');
I_rgb2 = imread('basmati(5).jpg');
I_rgb3 = imread('Ipsala(5).jpg');
I_rgb5 = imread('Karacadag(5).jpg');

%% Imagen a escalas de grises.
I = rgb2gray(I_rgb);
I4 = rgb2gray(I_rgb4);
I2 = rgb2gray(I_rgb2);
I3 = rgb2gray(I_rgb3);
I5 = rgb2gray(I_rgb5);

%% Binarización de la imagen y llenado de huecos
thresh = graythresh(I); binh = imbinarize(I, thresh); bin=uint8(binh)*255;

thresh2 = graythresh(I2); binh2 = imbinarize(I2, thresh2); bin2 = uint8(binh2)*255;

thresh3 = graythresh(I3); binh3 = imbinarize(I3, thresh3); bin3 = uint8(binh3)*255;

thresh4 = graythresh(I4); binh4 = imbinarize(I4, thresh4); bin4 = uint8(binh4)*255;

thresh5 = graythresh(I5); binh5 = imbinarize(I5, thresh5); bin5 = uint8(binh5)*255;

%% SE = strel(forma, parámetro) 
% Crea un elemento estructurante morfológico plano.
% Vamos a crear 4 formas structurales
se1 = strel('square', 5);    %Cuadrado de lado 5
se2 = strel('line', 10, 30); %Linea de  long 10 y ángulo 30
se3 = strel('disk', 5);     %Disco de radio 15
se4 = strel('ball', 3, 3);  %Circulo/bola de radio 15 y alto 5

%% Otras estructuras Morfologicas
% se5 = strel('diamond',3);
% se7 = strel('octagon',3);
% se8 = strel('rectangle',[3 4]);
% se9 = strel('cube',4);
% se10 = strel('cuboid',[3 4 5]);
% se11 = strel('sphere',5); 

%% Operaciones morfológicas (disco de radio 5)

D = imdilate(bin, se3); %Dilatación
E = imerode(bin, se3);  %Erosión
A = imopen(bin, se3);   %Apertura
C = imclose(bin, se3);  %Cierre

figure(6);
subplot(2,2,1), imshow(D),title('Dilatación');
subplot(2,2,2), imshow(E),title('Erosión');
subplot(2,2,3), imshow(A),title('Apertura');
subplot(2,2,4), imshow(C),title('Cierre');
sgtitle('Operaciones Morfológicas para Arborio');

%% Bastamí
D2 = imdilate(bin2, se3); %Dilatación
E2 = imerode(bin2, se3);  %Erosión
A2 = imopen(bin2, se3);   %Apertura
C2 = imclose(bin2, se3);  %Cierre
% 
figure(7);
subplot(2,2,1), imshow(D2),title('Dilatación'); 
subplot(2,2,2), imshow(E2),title('Erosión');
subplot(2,2,3), imshow(A2),title('Apertura');
subplot(2,2,4), imshow(C2),title('Cierre');
sgtitle('Operaciones Morfológicas para Bastamí')

%% Ipsala
D3 = imdilate(bin3, se3); %Dilatación
E3 = imerode(bin3, se3);  %Erosión
A3 = imopen(bin3, se3);   %Apertura
C3 = imclose(bin3, se3);  %Cierre
% 
figure(8);
subplot(2,2,1), imshow(D3),title('Dilatación'); 
subplot(2,2,2), imshow(E3),title('Erosión');
subplot(2,2,3), imshow(A3),title('Apertura'); 
subplot(2,2,4), imshow(C3),title('Cierre');
sgtitle('Operaciones Morfológicas para Ipsala')

%% Jasmine
D4 = imdilate(bin4, se3); %Dilatación
E4 = imerode(bin4, se3);  %Erosión
A4 = imopen(bin4, se3);   %Apertura
C4 = imclose(bin4, se3);  %Cierre

figure(9);
subplot(2,2,1), imshow(D4),title('Dilatación');
subplot(2,2,2), imshow(E4),title('Erosión');
subplot(2,2,3), imshow(A4),title('Apertura');
subplot(2,2,4), imshow(C4),title('Cierre');
sgtitle('Operaciones Morfológicas para Jasmine');

%% Karacadag
D5 = imdilate(bin5, se3); %Dilatación
E5 = imerode(bin5, se3);  %Erosión
A5 = imopen(bin5, se3);   %Apertura
C5 = imclose(bin5, se3);  %Cierre
% 
figure(10); 
subplot(2,2,1), imshow(D5),title('Dilatación');
subplot(2,2,2), imshow(E5),title('Erosión');
subplot(2,2,3), imshow(A5),title('Apertura');
subplot(2,2,4), imshow(C5),title('Cierre');
sgtitle('Operaciones Morfológicas para Karacadag')

%% Binarización de la imagen y llenado de huecos
% thresh = graythresh(I)
% binh = ~imbinarize(I, thresh);
% %Visualización
% figure(3), imshow(binh), title('Binarización de la imagen')

%Llenar huecos, si los hay.
binh_fill = imfill(binh, 'holes');
binh_fill2 = imfill(binh2, 'holes');
binh_fill3 = imfill(binh3, 'holes');
binh_fill4 = imfill(binh4, 'holes');
binh_fill5 = imfill(binh5, 'holes');

%% Vizualización final
figure(1); 
subplot(2,2,1), imshow(I_rgb), title('Original');
subplot(2,2,2), imshow(I), title('Blanco y Negro');
subplot(2,2,3), imshow(binh), title('Binarizada');
subplot(2,2,4), imshow(binh_fill),title('LLenado de Huecos');
sgtitle('Procesamiento de Imagenes Arborio')

figure(2)
subplot(2,2,1), imshow(I_rgb4), title('Original');
subplot(2,2,2), imshow(I4), title('Blanco y Negro');
subplot(2,2,3), imshow(binh4), title('Binarizada');
subplot(2,2,4), imshow(binh_fill4),title('LLenado de Huecos');
sgtitle('Procesamiento de Imagenes: Jasmine');

figure(3);
subplot(2,2,1), imshow(I_rgb2), title('Original');
subplot(2,2,2), imshow(I2), title('Blanco y Negro');
subplot(2,2,3), imshow(binh2), title('Binarizada');
subplot(2,2,4), imshow(binh_fill2),title('LLenado de Huecos');
sgtitle('Procesamiento de Imagenes Bastami');

figure(4);
subplot(2,2,1), imshow(I_rgb3), title('Original');
subplot(2,2,2), imshow(I3), title('Blanco y Negro');
subplot(2,2,3), imshow(binh3), title('Binarizada');
subplot(2,2,4), imshow(binh_fill3),title('LLenado de Huecos');
sgtitle('Procesamiento de Imagenes Ipsala')

figure(5);
subplot(2,2,1), imshow(I_rgb5), title('Original');
subplot(2,2,2), imshow(I5), title('Blanco y Negro');
subplot(2,2,3), imshow(binh5), title('Binarizada');
subplot(2,2,4), imshow(binh_fill5),title('LLenado de Huecos');
sgtitle('Procesamiento de Imagenes: Karacadag')

%% 
% w = D-bin;
% figure(),imshow(w),title('Yeiiii')
% mat = bin-E;
% figure(),imshow(mat)
