%% 5. Histograma 1D
clear all, close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Arborio(25).jpg');
s=size(a);
% Extracción de los planos
ar = a(:,:,1);
ag = a(:,:,2);
ab = a(:,:,3);

%% Despliegue de planos
figure (1);
subplot(2,2,1),imshow(a), title('Plano original');
subplot(2,2,2),imshow(ar), title('Plano rojo');
subplot(2,2,3),imshow(ag), title('Plano verde');
subplot(2,2,4),imshow(ab), title('Plano azul');
sgtitle('Despliegue de los planos RGB');

%% Obtención del histograma
histR = zeros(1,256);  % un vector fila
histG = zeros(1,256); 
histB = zeros(1,256); 

for f = 1:s(1)      %recorremos las filas 
     for c = 1:s(2) %recorremos las columnas 
     ngR= ar(f,c);           %Nivel de gris del canal rojo
     histR(ngR+1) = histR(ngR+1) + 1;
     ngG= ag(f,c);           %Nivel de gris del canal verde
     histG(ngG+1) = histG(ngG+1) + 1;
     ngB= ab(f,c);           %Nivel de gris del canal azul
     histB(ngB+1) = histB(ngB+1) + 1;
     end
end

%% Visualización del histograma
figure(2);
subplot(2,2,1), plot(histR), title('Plano Rojo');
subplot(2,2,2), plot(histG), title('Plano Verde');
subplot(2,2,3), plot(histB), title('Plano Azul');
sgtitle('Historgrama de los Planos RGB');

