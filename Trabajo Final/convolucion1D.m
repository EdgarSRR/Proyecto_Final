%% 8. Convolución 1D
clc; clear all; close all

%% Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Jasmine(5).jpg');
% Extracción de los planos
ar = a(:,:,2);

%%  Convolución 1d
% Perfil de línea
lin=110;
pl = ar(lin,:);
ar(lin,:) = 0;

% Convolucion 
k = [1 1 1 1 1];    % funcion g - conocida
c = conv(pl,k);     % funcion f - desconocida

% Despliege
figure(1), subplot(1,1,1), image(ar), title('Imagen Original: Arroz Jasmine'), colormap gray(256)

figure(2);
subplot(2,1,1), plot(pl), title('Perfil de línea');
subplot(2,1,2), plot(c), title('Perfil de línea convolución');
sgtitle('Convolución 1D para lin=110');
%%  Convulción 12D
% Perfil de línea
ar2 = a(:,:,2);
lin2=140;
pl2 = ar2(lin2,:);
ar2(lin2,:) = 0;
% Convolucion 
k2 = [1 1 1 1 1];    % funcion g - conocida
c2 = conv(pl2,k2);     % funcion f - desconocida
% Despliege
figure(3);
subplot(2,1,1);plot(pl2);title('Perfil de línea');
subplot(2,1,2);plot(c2);title('Perfil de línea convolución');
sgtitle('Convulución 1D para lin=140');