%Example on one of the sequences showing the use of the proposed algorithm.
dataPath = '../Data_Seq1/I_SI_01/I_SI_01/I_SI_01-';
dataDir = '../Data_Seq1/I_SI_01/I_SI_01/';
bmpImgsDir = dir([dataDir '*.bmp']);
numImagesInFolder = size(bmpImgsDir,1);

close all;

%Change trainingSize to set how many frames to train the algorithm with.
trainingSize = 10;
%calculating number of images in the folder
numImgInFolder = 225;
patchSize = floor([288,352]);
lambda = 0.25;
trainIndexes = 1:trainingSize;

[background, backgroundCell] = extract_background_ica(dataPath, trainingSize, numImgInFolder, patchSize, lambda,trainIndexes);
imshow(background);

for jj = 1:numImagesInFolder
    ImagePath = strcat(dataPath,num2str(jj),'.bmp');
    OriginalVideoStream(:,:,:,jj) = imread(ImagePath);
    OriginalVideoStream_gs(:,:,jj) = rgb2gray(OriginalVideoStream(:,:,:,jj));
end

algorithm = "structural_sim";
ImgType = "RGB";

[VideoWoBg,VideoWoBg_gs,VideoLabels] =  VideoStreamBackgroundRemoval(background,...
    OriginalVideoStream,algorithm,ImgType);

%Data set true labels
dataPathGT = '../Data_Seq1/I_SI_01/I_SI_01-GT/I_SI_01-GT_';
dataDirGT = '../Data_Seq1/I_SI_01/I_SI_01-GT/';
bmpImgsDir = dir([dataDirGT '*.png']);
numImagesInFolderGT = size(bmpImgsDir,1);

if numImagesInFolderGT~= numImagesInFolder
    error('Ground set and original video stream set have different size.\n')
end

for jj = 1:numImagesInFolderGT
    ImagePath = strcat(dataPathGT,num2str(jj),'.png');
    GTLabels(:,:,:,jj) = imread(ImagePath);
    GTLabels_gs = rgb2gray(GTLabels(:,:,:,jj));
    GTLabelsBW(:,:,jj) = imbinarize(GTLabels_gs);
    VideoLabelsBW(:,:,jj) = imbinarize(VideoLabels(:,:,jj));
end

%Original sequence
h = implay(OriginalVideoStream);
set(h.Parent, 'Name', 'Original Stream')
%Our results
h = implay(VideoLabels);
set(h.Parent, 'Name', 'Project results')
%True Labels
h = implay(GTLabels);
set(h.Parent, 'Name', 'LASIESTA original labels')

