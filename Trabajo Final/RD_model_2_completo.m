%% Limpiar entorno
close all;
clc;
clear all;

%% Cargar datos
matr_descrip = xlsread('Features_img_Arroz.xlsx'); 
ss = size(matr_descrip); 

%% 20 primeras filas de cada grupo
num_grupos = 5;
filas_por_grupo = 250;
filas_a_extraer_por_grupo = 50;
j = 1;
for grupo = 1:num_grupos
    inicio_fila = (grupo - 1) * filas_por_grupo + 1;
    fin_fila = inicio_fila + filas_a_extraer_por_grupo - 1;

    area(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 1);
    perim(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 2);
    ejeMaj(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 3);
    ejeMin(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 4);
    Excent(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 5);
    Exten(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 6);
    AspRat(j:j+filas_a_extraer_por_grupo-1) = matr_descrip(inicio_fila:fin_fila, 7);

    j = j + filas_a_extraer_por_grupo;
end

%% Configuración y ejecución del clasificador
X = [area; perim; ejeMaj; ejeMin; Excent; Exten; AspRat]'; %Datos de entrenamiento

% 1.2 Configuración target
%Se crea una matriz con las etiquetas posibles para las muestras (6 filas, 1 columna)
T = repmat([1 2 3 4 5 ],50,1); 
target = T(:); % Se serializa T, Vector objetivo para la clasif supervisada

%% Configuración y obtención del modelo de redes neuronales
% 2: Configuración de la red neuronal
disp('Configuring Neural Network...');
trainFcn = 'trainlm';  % Levenberg-Marquardt
hiddenLayerSize = [5 10 20 10]; %if I need more layers then I should write: [10,12,...,9]
net = fitnet(hiddenLayerSize,trainFcn);
% net.layers{1}.transferFcn='logsig';                %tansig by default, but I can put another
% net.layers{2}.transferFcn='tansig';   
% net.layers{3}.transferFcn='purelin';  
% net.trainParam.goal = 0.1;
% net.trainParam.epochs = 500;
%net = init(net);                                  %initializing the network with previous configurations
% view(net)                                          % para visualizar la red final 
[net, tr] = train(net,X',target');               %training

%% Validación del modelo sobre muestras de prueba
num_grupos = floor(length(matr_descrip) / 250); % Calcula el número de grupos completos de 50 filas
j = 1;
for grupo = 1:num_grupos
    indice_inicio = (grupo - 1) * 250 + 51; % Índice de inicio (21) para las últimas 30 filas del grupo
    indice_fin = indice_inicio + 199; % Índice de fin (50) para las últimas 20 filas del grupo
    area_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 1);
    perim_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 2);
    ejeMaj_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 3);
    ejeMin_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 4);
    Excent_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 5);
    Exten_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 6);
    AspRat_test(j:j+199) = matr_descrip(indice_inicio:indice_fin, 7);
    j = j + 200;
end

%% Configuración y ejecución para la validación
X_test = [area_test; perim_test; ejeMaj_test; ejeMin_test; Excent_test; Exten_test; AspRat_test]';
% 1.2 Configuración target
T_test = repmat([1 2 3 4 5 ],200,1); 
target_test = T_test(:);

%% Respuesta del clasificador
outputs = round(net(X_test'));
outputs % para presentar en pantalla un vector fila con los resultados (como responde)
target_test' %... y compararlo con el objetivo (como debería responder)
%performance = perform(myRF_2, target', res)
% Evaluación del desempeño: Es mejor si se acerca a 100
eval = sum(outputs==target_test')/length(target_test)*100

%% Matriz de confusión
confusionchart(target_test, outputs);
C = confusionmat(target_test, outputs);
imagesc(C);
colorbar;xlabel('Clases Predichas');ylabel('Clases Reales');
title('Matriz de Confusión: Red Neuronal');

%% Guardar modelo
% save RD_model_97.8 net % guardar modelo clasificador
