%% Operaciones punto - normalización
clear all, close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Arborio(25).jpg');

%% 
ag= a(:,:,2);
figure (1);
subplot(1,2,1),imshow(ag), title('Imagen original');

%% ANTES
% Valores de punto flotante
% Valores normalizados
ag=double(ag);
ag = ag/255; 

% Procesamiento
bg = ag.^0.7;  % El valor debe estar normalizado

%% DESPUÉS: Desnormailización
% % Valores de enteros de 8 bits sin signo - uint8
% bg= bg*255;
% bg= uint8(bg);
% ag= ag*255;
% ag= uint8(ag);
figure (1);
subplot(1,2,2),imshow(bg), title('Imagen procesada');
sgtitle('Visualización: Puntos Normalizados');

%% 
s=size(a);
histag = zeros(1,256);  % un vector fila
histbg = zeros(1,256);

for f = 1:s(1)      % recorremos las filas 
     for c = 1:s(2) % recorremos las columnas 
         ng = round(ag(f,c)); % Redondeamos a un entero
         histag(ng+1) =  histag(ng+1) + 1;
         ng = round(bg(f,c)); % Redondeamos a un entero
         histbg(ng+1) =  histbg(ng+1) + 1;
     end
end

figure (2);
subplot(1,2,1), plot(histag), title('Imagen Original');
subplot(1,2,2), plot(histbg), title('Imagen Procesado');
sgtitle('Histogramas de Puntos Normalizados');