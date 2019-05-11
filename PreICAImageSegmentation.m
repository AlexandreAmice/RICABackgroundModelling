%CIS 520 - Spring 2019
%
%Final Project - Group 14 - Moving object detection using ICA
%
%This script divides images into pixel 'clusters' for ICA analysis.
%The function takes as inputs
%
%image_org: original image (matrix structure, after imread);
%
%patches_dimension \in N^2 = dimension of each patche (lines vs columns)
%
%overlap_rate: percentage of possible overlap when creating patches (?)

function [image_patches,patches_lines,patches_columns] = ...
    PreICAImageSegmentation(image_org,patches_dimension, overlap_rate)

%image dimensions
[n_lines,n_columns,n_layers] = size(image_org);
patches_size = patches_dimension(1)*patches_dimension(2);

if patches_size > n_lines*n_columns
    error('Patch size is too large!\n')
end


if length(patches_dimension) ~= 2
    error('Check patch dimensions\n')
end

patches_lines = floor(n_lines/patches_dimension(1));

patches_columns = floor(n_columns/patches_dimension(2));

number_patches = patches_columns*patches_lines;

rowDims = patches_dimension(1) * ones(1, patches_lines); 
if mod(n_lines, patches_dimension(1)) ~= 0
    rowDims = [rowDims , mod(n_lines, patches_dimension(1)) ];
end
colDims = patches_dimension(2) * ones(1, patches_columns);
if mod(n_columns, patches_dimension(2)) ~= 0
    colDims = [colDims, mod(n_columns, patches_dimension(2))];
end

image_patches = mat2cell(image_org, rowDims, colDims, n_layers);



end



