%CIS 520 - Spring 2019
%
%Final Project - Group 14 - Moving object detection using ICA
%
%Creates a 2D cell array where each cell is a patch. In each cell of patch_stack
%, there is a 4d array where the axis are (image_row, image_col, image_depth, time)
%
%imagePath: path where images will be read. images should be named
%imagePath[number].bmp
%
%imageScale: resize the image if desired
%
%patches_dims: dimension of patches passed as a [row size, column size]
%array
%
%overlap_rate: percentage of possible overlap when creating patches (?).
%For now set to 1


function [patch_stack, sampleImage] = make_time_patch_stack(imagePath, numTrain, imageScale, patches_dims, overlap_rate, trainingIndexes)
if floor(numTrain) ~= numTrain
    error('numTrain must be integer')
elseif numTrain < 1
    error('train on more than one image')
end
if overlap_rate ~= 0
    warning('Overlap_rate not implemented yet. Setting overlap_rate to 0')
    overlap_rate = 0;
end
start = 1;
firstImName = strcat(imagePath, num2str(start),'.bmp');
im0 = read_scaled_image(firstImName, imageScale);
sampleImage = scale_to_uint8(im0);
sampleImage = PreICAImageSegmentation(sampleImage,patches_dims, overlap_rate);


[imPatches,patches_lines,patches_columns] = ...
    PreICAImageSegmentation(im0,patches_dims, overlap_rate);
[m,n] = size(imPatches);

%preallocate stacks in time
patch_stack = imPatches;

%for t = trainingIndexes
for t = 1:length(trainingIndexes)
    i = trainingIndexes(t); %i = t; %floor(numImg*rand);
    curImName = strcat(imagePath, num2str(i),'.bmp');
    curIm = read_scaled_image(curImName, imageScale);
    [imPatches,patches_lines,patches_columns] = ...
    PreICAImageSegmentation(curIm,patches_dims, overlap_rate);
    for i = 1:m
        for j = 1:n 
            patch_stack{i,j} = cat(4,patch_stack{i,j}, imPatches{i,j}); 
        end
    end
end

end




function [image] = read_scaled_image(path, scale)
image = imread(path);
image = double(image);
image = imresize( image, scale);
end