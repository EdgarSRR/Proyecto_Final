%% 9. Convolución 2D 
clc; clear all; close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Jasmine(5).jpg');
addpath('/MATLAB Drive/Train_data')
b= imread('Arborio(5).jpg');

%% Extracción de los planos
ar = double(a(:,:,2));
s = size(a);
arc = ar*0;  %reserva de memoria

br = double(b(:,:,2));
s1 = size(b);
brc = br*0;  %reserva de memoria

%% Convolucion 
kernel = [1 1 1; 1 1 1; 1 1 1]/9;   % filtro de promedio- eliminando frecuencias altas
kernelgauss = [1 2 1; 2 4 2; 1 2 1]/16;  % filtro gaussiano

%% Jasmine
for i= 2:s(1)-1
    for j= 2:s(2)-1
        ventana = ar(i-1:i+1, j-1:j+1);
        prod = ventana .* kernel;
        pix = sum(sum(prod));   %f[x,y]*g[x,y]
        arc(i,j) = pix;
    end
end

%% Arborio
for i= 2:s(1)-1
    for j= 2:s(2)-1
        ventana2 = br(i-1:i+1, j-1:j+1);
        prod2 = ventana2 .* kernel;
        pix2 = sum(sum(prod2));   %f[x,y]*g[x,y]
        brc(i,j) = pix2;
    end
end

%% Despliegue
figure(1);
subplot(2,2,1), imshow(uint8(ar)), title('Imagen Original: Jasmine');
subplot(2,2,2), imshow(uint8(arc)), title('Convolución 2D: Jasmine');
subplot(2,2,3), imshow(uint8(br)), title('Imagen Original: Arborio');
subplot(2,2,4), imshow(uint8(brc)), title('Convolución 2D: Arborio');

%% filtro altas frecuencias
altasf = ar-arc;
altasf2 = br-brc;

figure(2);
subplot(1,2,1), imshow(uint8(altasf)); title('Jasmine')
subplot(1,2,2), imshow(uint8(altasf2)); title('Arborio')
sgtitle('Filtro de Altas frecuencias');