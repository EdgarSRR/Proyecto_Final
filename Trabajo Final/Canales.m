%% 6. Procesamiento de punto
clear all, close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Arborio(1).jpg');
b= a+50;   % Si le subimos mas al numero se ve como se pierde los niveles de gris
c= a-50;   %Se oscurece la imagen 
d=a*2;    %Aumenta el valor de pendiente
e=a/2;    %Diminuye el valor de pendiente
f=double(a).^2;   %El contenedor no es suficiente

%% Visualización 
figure (1), subplot(2,2,1),imshow(a), title('imagen original');
figure (1), subplot(2,2,2),imshow(b), title('imagen procesada al sumar');
figure (1), subplot(2,2,3),imshow(c), title('imagen procesada al restar');

figure (2), subplot(2,2,1),imshow(a), title('imagen original');
figure (2), subplot(2,2,2),imshow(d), title('imagen procesada al x2');
figure (2), subplot(2,2,3),imshow(e), title('imagen procesada al /2');

figure (3), subplot(2,2,1),imshow(a), title('imagen original');
figure (3), subplot(2,2,2),imshow(f), title('imagen procesada al ^2');


