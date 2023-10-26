%% 7. Look-up tables
clear all, close all

%%  Carga de la imagen
addpath('/MATLAB Drive/Train_data')
a= imread('Arborio(25).jpg');

%% Se arma el vector LUT - Biblioteca
lutbase = 0:255;
lutgamma2 = uint8(((lutbase/255).^2)*255);
lutgamma3 = uint8(((lutbase/255).^3)*255);
lutespec1= 0:255;
lutespec1(100:120)=200;   % si me interesa una región en particular
lutespec1(200:220)=100; 
lutespec1 = uint8(lutespec1);

lutespec2= (0:255)*2;
lutespec2(128:256)=255-lutespec2(1:129);   % si me interesa una region en particular
lutespec2 = uint8(lutespec2);

lutinvert = uint8(255-lutbase); %negativo de la imagen 

%% Aplicación de LUT (Transformación de la imagen)
b = lutgamma2(a+1);   % el +1 es por los ceros que puede encontrar
b1 = lutgamma3(a+1);
b2 =  lutespec1(a+1);
b3 =  lutinvert(a+1);
b4 =  lutespec2(a+1);

%% Visualización de las imágenes transformadas:
figure(4),  imshow(b2)
figure(5),  imshow(b3)
figure(6),  imshow(b4)