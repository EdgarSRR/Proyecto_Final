%% 10. Filtrado no-espacial
clc; clear all; close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Arborio(25).jpg');

%% Extracción de los planos
ar = double(a(:,:,2));
s = size(a);
arc=ar*0;
armediana = ar*0;  %reserva de memoria
armin = ar*0;
armax = ar*0;

%% Convolucion 
kernel = [1 1 1; 1 1 1; 1 1 1]/9;   % filtro de promedio- eliminando frecuencias altas
kernelgauss = [1 2 1; 2 4 2; 1 2 1]/16;  % filtro gaussiano

for i= 2:s(1)-1
    for j= 2:s(2)-1
        ventana = ar(i-1:i+1, j-1:j+1);
        producto = ventana .* kernel;
        pix = sum(sum(producto));   %f[x,y]*g[x,y]
        arc(i,j) = pix;
        %mediana
        vector= ventana(:);
        vector = sort(vector);
        armediana(i,j) = vector(5);
        armin(i,j) = vector(1);
        armax(i,j) = vector(9);
    end
end

%% Despliege
figure(1);
subplot(2,2,1), imshow(uint8(ar)), title('Imagen Original');
subplot(2,2,2), imshow(uint8(armediana)), title('Mediana');
subplot(2,2,3), imshow(uint8(armin)), title('Mínimo');
subplot(2,2,4), imshow(uint8(armax)), title('Máximo');
sgtitle('Frecuencia Espacial: Arborio');

