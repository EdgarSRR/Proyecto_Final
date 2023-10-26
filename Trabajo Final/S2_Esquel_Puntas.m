%% Morfología matemática: 
% Esqueletización y conteo de puntas.

%% Limpiando el espacio de trabajo
close all; clc; clear all;

%% Lectura de imagen RGB y transformación a escala de gris.
% Imagen en RGB
addpath('/MATLAB Drive/Train_data')
I_rgb = imread('Arborio(15).jpg');
I_rgb4 = imread('Jasmine(15).jpg');
I_rgb2 = imread('basmati(15).jpg');
I_rgb3 = imread('Ipsala(15).jpg');
I_rgb5 = imread('Karacadag(15).jpg');

%% Imagen a escalas de grises.
I = rgb2gray(I_rgb);
I2 = rgb2gray(I_rgb2);
I3 = rgb2gray(I_rgb3);
I4 = rgb2gray(I_rgb4);
I5 = rgb2gray(I_rgb5);

%% Binarización de la imagen
thresh = graythresh(I); binh = imbinarize(I, thresh); bin=uint8(binh)*255;
thresh2 = graythresh(I2); binh2 = imbinarize(I2, thresh2); bin2 = uint8(binh2)*255;
thresh3 = graythresh(I3); binh3 = imbinarize(I3, thresh3); bin3 = uint8(binh3)*255;
thresh4 = graythresh(I4); binh4 = imbinarize(I4, thresh4);bin4 = uint8(binh4)*255;
thresh5 = graythresh(I5); binh5 = imbinarize(I5, thresh5); bin5 = uint8(binh5)*255;

%% Esqueletización
BW_esquel = bwmorph(binh,'skel',Inf);
BW_esquel2 = bwmorph(binh2,'skel',Inf);
BW_esquel3 = bwmorph(binh3,'skel',Inf);
BW_esquel4 = bwmorph(binh4,'skel',Inf);
BW_esquel5 = bwmorph(binh5,'skel',Inf);

%% Visualización
figure(1); 
subplot(1,2,1), imshow(BW_esquel), title('Arborio');
subplot(1,2,2), imshow(BW_esquel2), title('Basmati'); 
sgtitle('Esqueletización de tipos de arroz')
figure(2)
subplot(1,2,1), imshow(BW_esquel3), title('Ipsala');
subplot(1,2,2), imshow(BW_esquel4), title('Jasmine');
sgtitle('Esqueletización de tipos de arroz')
figure(3)
subplot(1,1,1), imshow(BW_esquel5), title('Karacadag')
sgtitle('Esqueletización de tipos de arroz')

%% Conteo de Puntas #2
% Carga la imagen
% Detecta las esquinas utilizando la función corner
corners = corner(binh);
corners2 = corner(binh2);
corners3 = corner(binh3);
corners4 = corner(binh4);
corners5 = corner(binh5);

% Cuenta las esquinas detectadas
num_corners = size(corners, 1);
num_corners2 = size(corners2, 1);
num_corners3 = size(corners3, 1);
num_corners4 = size(corners4, 1);
num_corners5 = size(corners5, 1);

figure(4)
imshow(I);
hold on;
plot(corners(:,1), corners(:,2), 'r*');
title(['No de Esquinas detectadas para Arborio: ' num2str(num_corners)]);
hold off;

figure(5)
imshow(I2);
hold on;
plot(corners2(:,1), corners2(:,2), 'r*');
title(['No de Esquinas detectadas para Bastamí: ' num2str(num_corners2)]);
hold off;

figure(6)
imshow(I3);
hold on;
plot(corners3(:,1), corners3(:,2), 'r*');
title(['No de Esquinas detectadas para Ipsala: ' num2str(num_corners3)]);
hold off;

figure(7)
imshow(I4);
hold on;
plot(corners4(:,1), corners4(:,2), 'r*');
title(['No de Esquinas detectadas para Jasmine: ' num2str(num_corners4)]);
hold off;

figure(8)
imshow(I5);
hold on;
plot(corners5(:,1), corners5(:,2), 'r*');
title(['No de Esquinas detectadas para Karacadag: ' num2str(num_corners5)]);
hold off;
