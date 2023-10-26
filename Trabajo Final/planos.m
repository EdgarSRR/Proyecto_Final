%% Planos 
clear all, close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Arborio(25).jpg');
x= imread('Jasmine(25).jpg');

%% Extracción de los planos
ar = a(:,:,2);
xr = x(:,:,2);
%ab = a(:,:,3);

%% Recortar imagen y Perfiles de linea
a_recorte = ar(80:180, 50:200,:);
figure (2);
subplot(2,2,1), image(a_recorte), title('Imagen recortada');
pl = a_recorte(:,20);  
subplot(2,2,2), plot(pl), title('Perfil de linea (Arboria)');
x_recorte = xr(75:180, 50:200,:);
subplot(2,2,3), image(x_recorte), title('Imagen recortada');
plt = x_recorte(15,:);  
subplot(2,2,4), plot(plt), title('Perfil de linea (Jasmine)');
sgtitle('Perfiles lineas en el plano Verde');

