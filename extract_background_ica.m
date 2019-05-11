function [background, backgroundCell] = extract_background_ica(data_path, trainingSize, numImgInFolder, patchSize, lambda, trainingIndexes)
%%%
%data_path: example path "path/O_CL_01/O_CL_01-"
%trainings size: scalar number of samples to use to train
%numImgInFolder: number of images in data path
%patchsize passes as 2 x 1 vector
%lambda: regularization coefficient for rICA
%%%

%option to rescale image may be included later
imageScale = 1;
%option to overlap patches may be included later
overlap_rate = 0;


[patch_stack, sampleImg] = make_time_patch_stack(data_path, trainingSize, imageScale, patchSize, overlap_rate, trainingIndexes);
[numRows, numCols] = size(patch_stack);

[imgRows, imgCols, imgDepth] = size(sampleImg);
ica1 = cell(numRows, numCols);
ica2 = cell(numRows, numCols);

for r = 1:numRows
    for c = 1:numCols
        tic
        [icaData, orgRows, orgCols, orgDepth] = time_stack_to_ica_data(patch_stack{r,c});
        Mdl = rica(icaData, 2);
        icasig = transform(Mdl,icaData, 'Lambda',lambda, 'Standarize', true);
        ica1{r,c} = reshape(icasig(:,1), orgRows, orgCols, orgDepth);
        ica2{r,c} = reshape(icasig(:,2), orgRows, orgCols, orgDepth);
        toc
    end
end

[background,backgroundCell] = select_background(sampleImg, ica1, ica2);
background = imresize(background, 1/imageScale);
