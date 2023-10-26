%% Reconocimiento de patrones: 
% Etiquetado, medición de características.

%% Limpiando el espacio de trabajo
close all; clc; clear all;

%% Lectura de imagen RGB y transformación a escala de gris.
% Imagen en RGB
addpath('/MATLAB Drive/Train_data')
I_rgb = imread('Arborio(5).jpg');
%Imagen a escalas de grises.
I = rgb2gray(I_rgb);
%Mostrar imagen
figure(1), subplot(2,1,1), imshow(I_rgb), title('Imagen original RGB')
figure(1), subplot(2,1,2), imshow(I), title('Imagen en blanco y negro')

%% Binarización de la imagen
thresh = graythresh(I)
binh = imbinarize(I, thresh);
%Visualización
figure(2), imshow(binh), title('Binarización de la imagen')

%% Etiquetado de la imagen
[I_label, num] = bwlabel(binh,8);
%% Presentación de la imagen con cada objeto enmarcado - BoundingBox
I_cdes = regionprops(I_label, 'all');%Calcula diferentes características para cada objeto de la imagen
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
%% Medición de características
Area = [I_cdes.Area]';
Perimetro = [I_cdes.Perimeter]';
Orientacion = [I_cdes.Orientation]';
Circularityn = [I_cdes.Circularity]';

%% Otra manera para encontrar el área y el perímetro.
% Obtener los bordes de los objetos
[B,L]=bwboundaries(binh);
perim=[];
for k=1:1:size(B,1)
    perim=[perim size(B{k,:},1)];
end
%Fijando el objeto de interés --> el perímetro más largo, en caso de existir:
h1=figure(4);imshow(I), title('Visualización del perímetro')
ax=gca
B1_cell=B(find(perim==max(perim)),:);
B1=B1_cell{:};
hold(ax,'all');
plot(ax,B1(:,2),B1(:,1),'r','LineWidth',2)

%Longitud del perímetro en pixeles
Perimetro2=size(B1,1)   

%Área ---> Sumando pixeles blancos de la imagen binarizada.
[m,n] = size(binh);
for i =1:m
    for j=1:n
        if(binh(i,j)>0)
            Ithres(i,j) = 1;
            Area2 = sum(sum(Ithres));
        else 
            Ithres(i,j) = 0;
        end
    end
end 