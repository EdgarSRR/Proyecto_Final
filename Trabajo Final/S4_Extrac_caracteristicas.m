%% Extracción de características texturales: 
%Matrices de coocurrencia.

%% Limpiando el espacio de trabajo
close all; clc; clear all;

%% Lectura de imagen RGB y transformación a escala de gris.
% Imagen en RGB
addpath('/MATLAB Drive/Train_data')
I_rgb = imread('Arborio(5).jpg');

% Imagen a escalas de grises.
I = rgb2gray(I_rgb);
% Visualización de la imagen en escalas de grises y original
figure(1), subplot(2,1,1), imshow(I_rgb), title('Imagen original RGB')
figure(1), subplot(2,1,2), imshow(I), title('Imagen en blanco y negro')

%% Binarización
thresh = graythresh(I)
binh = imbinarize(I, thresh);

%% Regionprops - Tabla de valores
% Visualización
figure(1), imshow(binh), title('Binarización de la imagen')
% Etiquetado de la imagen
[I_label, num] = bwlabel(binh,8);
% Presentación de la imagen con cada objeto enmarcado - BoundingBox
I_cdes = regionprops(I_label, 'all');
% I_cdes(1,1).Eccentricity % ejemplo para acceder
I_conect_comp = bwconncomp(I_label);

figure(3), imshow(I), title('Imagen etiquetada'), hold on
for i=1:1:num
    rectangle('Position', I_cdes(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth',1)
    x = I_cdes(i).BoundingBox(1);
    y = I_cdes(i).BoundingBox(2);
    num_et = num2str(i);
    text(x, y, num_et, 'Color', 'g')
end
hold off
region_props_metrics = regionprops(I_label, 'All');
%Calcula diferentes características para cada objeto de la imagen

%% Matriz de co-ocurrencia de niveles de gris
% Es la distribución de valores de píxel concurrentes (valores de escala de grises o colores) en un offset dado.
glcm = graycomatrix(I,'Offset',[2 0]);
%Cálculo de las propiedades estadísticas de la matriz GLCM:
%Contraste, correlación, energía, homogeneidad.
stats = graycoprops(glcm);
Contraste = stats.Contrast
Correlacion = stats.Correlation
Energia = stats.Energy
Homegeneidad = stats.Homogeneity

%% Gráfica --- Correlación de textura como una función del offset
offsets0 = [zeros(30,1) (1:30)'];
glcms = graycomatrix(I,'Offset',offsets0);
stats2 = graycoprops(glcms,'Contrast Correlation');
figure (2), plot([stats2.Correlation]);
title('Correlación de textura como una función del offset');
xlabel('Offset Horizontal')
ylabel('Correlación')

%% Entropía de una imagen en niveles de gris
%La entropía se define como -sum(p.*log2(p)), donde p contiene los recuentos
%de histograma normalizados devueltos de imhist.
e = entropy(I);