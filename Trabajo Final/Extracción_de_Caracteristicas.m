%% Limpiar el entorno de ejecución
close all;
clc;
clear all;

%% Configuración inicial
read_path = '/MATLAB Drive/Train_data/';
files = dir(read_path);
num_images = length(files) - 2; % Número de imágenes (excluyendo '.' y '..')
features = cell(num_images, 7); % Celda para almacenar características de todas las imágenes
names = cell(num_images, 1); % Celda para almacenar nombres de archivos

for f = 3:length(files)
    file_2_read = strcat(files(f).folder, '/', files(f).name);
    names{f - 2} = files(f).name; % Almacena el nombre del archivo
    imagenRGB = imread(file_2_read); % Lee la imagen
    grayImage = rgb2gray(imagenRGB); % Convierte la imagen a escala de grises
    thresh = graythresh(grayImage); % Calcula el Umbral de binarización optimo
    binh = imbinarize(grayImage, thresh); % Binariza cada imagen
    [I_label, num] = bwlabel(binh, 8); % Etiqueta cada región de la imagen para calcular las caracteristicas
    I_cdes = regionprops(I_label, 'Area', 'Perimeter', 'MajorAxisLength', 'MinorAxisLength', 'Eccentricity', 'Extent', 'BoundingBox');
    features{f - 2, 1} = I_cdes.Area;
    features{f - 2, 2} = I_cdes.Perimeter;
    features{f - 2, 3} = I_cdes.MajorAxisLength;
    features{f - 2, 4} = I_cdes.MinorAxisLength;
    features{f - 2, 5} = I_cdes.Eccentricity;
    features{f - 2, 6} = I_cdes.Extent;
    features{f - 2, 7} = I_cdes.BoundingBox(3) / I_cdes.BoundingBox(4);

end

%% Convertir las celdas de características en matrices
%features_matrix = cell2mat(features);
% Crear un dataframe a partir de las matrices de características y 'names'
data = table(features(:, 1), features(:, 2), features(:, 3), features(:, 4), features(:, 5), features(:, 6), features(:, 7), ...
    'VariableNames', {'Area', 'Perimeter', 'MajorAxisLength', 'MinorAxisLength', 'Eccentricity', 'Extent', 'AspectRatio'});

% Agregar la columna de nombres de archivos al dataframe
data.FileName = names;
excel_filename = 'Features_img_Arroz.xlsx';
writetable(data, excel_filename);
disp(['Los datos se han guardado en ' excel_filename]);

