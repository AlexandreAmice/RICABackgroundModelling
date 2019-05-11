%CIS 520 --- Spring 2019
%
%File used to run tests using the proposed algorithm on some sequences from
%the LASIESTA database.

TotalTimeVar = tic;
%indoor sequences
%Remember to change the path on dataPaths and dataDirs to your local
%folder. Here we use dataPaths to load the images and dataDirs (current
%folder) to calculate the size of the video stream.
dataPaths = {'/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_01/I_SI_01/I_SI_01-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_02/I_SI_02/I_SI_02-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_01/I_CA_01/I_CA_01-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_02/I_CA_02/I_CA_02-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_01/I_OC_01/I_OC_01-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_02/I_OC_02/I_OC_02-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_01/I_IL_01/I_IL_01-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_02/I_IL_02/I_IL_02-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_01/I_MB_01/I_MB_01-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_02/I_MB_02/I_MB_02-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_01/I_BS_01/I_BS_01-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_02/I_BS_02/I_BS_02-';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MC_02/I_MC_02/I_MC_02-'};

dataDirs = {'/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_01/I_SI_01/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_02/I_SI_02/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_01/I_CA_01/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_02/I_CA_02/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_01/I_OC_01/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_02/I_OC_02/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_01/I_IL_01/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_02/I_IL_02/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_01/I_MB_01/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_02/I_MB_02/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_01/I_BS_01/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_02/I_BS_02/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MC_02/I_MC_02/'};

%lasiesta labels
%remember to do the same thing as above i.e. change the paths to your local
%storage of the original video stream labels
dataPathsGT = {'/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_01/I_SI_01-GT/I_SI_01-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_02/I_SI_02-GT/I_SI_02-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_01/I_CA_01-GT/I_CA_01-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_02/I_CA_02-GT/I_CA_02-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_01/I_OC_01-GT/I_OC_01-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_02/I_OC_02-GT/I_OC_02-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_01/I_IL_01-GT/I_IL_01-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_02/I_IL_02-GT/I_IL_02-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_01/I_MB_01-GT/I_MB_01-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_02/I_MB_02-GT/I_MB_02-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_01/I_BS_01-GT/I_BS_01-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_02/I_BS_02-GT/I_BS_02-GT_';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MC_02/I_MC_02-GT/I_MC_02-GT_'};

dataDirsGT = {'/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_01/I_SI_01-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_SI_02/I_SI_02-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_01/I_CA_01-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_CA_02/I_CA_02-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_01/I_OC_01-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_OC_02/I_OC_02-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_01/I_IL_01-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_IL_02/I_IL_02-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_01/I_MB_01-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MB_02/I_MB_02-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_01/I_BS_01-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_BS_02/I_BS_02-GT/';
    '/home/admin-1/Documents/CIS_520_project/Dataset/indoor/I_MC_02/I_MC_02-GT/'};

%separating frames
trainingIndexes = { [83:128,159:207, 247:291];%I_SI_01
    [80:276];%I_SI_02
    [92:164, 276:321];%I_CA_01
    [190:231, 431:483];%I_CA_02
    [105:168,193:230]; %I_OC_01
    [86:133, 168:245];%I_OC_02
    [101:190]; %I_IL_01
    [73:384];%I_IL_02
    [100:259];%I_MB_01
    [94:292];%I_MB_02
    [1:176];%I_BS_01
    [1:158];%I_BS_02
    [159:236]
    };

backgroundIndexes = { [1:79, 133:156,210:242, 294:300];%I_SI_01
    [1:74, 281:300]; %I_SI_02
    [1:90, 333:350];%I_CA_01
    [1:180, 491:525]; %I_CA_02
    [1:96, 235:250]; %I_OC_01
    [1:82, 139:163]; %I_OC_02
    [1:95, 195:300];%I_IL_01
    [1:70, 394:525]; %I_IL_02
    [1:97];%I_MB_01
    [1:92];%I_MB_02
    [184:275];%I_BS_01
    [176:275];%I_BS_02
    [1:156, 247:250]
    };

NumSeqs = 13;

%Parameters evaluated
%size of the training set
trainingSizevecPer = 0.1:0.1:1;
size_training_vec = length(trainingSizevecPer);

%value of lambda (rica)
%lambda1 = [0.1,0.2,0.3,0.4,0.5];
lambdavec = 0:0.2:1;
size_lambda = length(lambdavec);

%Consider only the full image here
%patchSize = floor([288,352]);
%size of image patches
patch_size1(:,:,1) = floor([288,352]);
patch_size1(:,:,2) = floor([144,352]);
patch_size1(:,:,3) = floor([144,176]);

%background removal technique
algorithm = "structural_sim";
ImgType = "RGB"; 

%evaluating influence of patch size 
%lambda does not affect the performance but might affect the training time.
for ii = 1:NumSeqs
    
    trainingSize = 100;
    
    dataPath = dataPaths{ii};
    dataDir = dataDirs{ii};
    bmpImgsDir = dir([dataDir '*.bmp']);
    numImagesInFolder = size(bmpImgsDir,1);
    
    %Training w/ `training' indexes only
    trainIndexes = trainingIndexes{ii};
    NumNonStatic = length(trainIndexes);
    
    %Training w/ `training' indexes and a percentage of background idxs
    backIndexes = backgroundIndexes{ii};
    NumStatic = length(backIndexes);
    
    for jj = 1:numImagesInFolder
        ImagePath = strcat(dataPath,num2str(jj),'.bmp');
        OriginalVideoStream(:,:,:,jj) = imread(ImagePath);
        OriginalVideoStream_gs(:,:,jj) = rgb2gray(OriginalVideoStream(:,:,:,jj));
    end
    
    %loads labels
    dataPathGT = dataPathsGT{ii};
    dataDirGT = dataDirsGT{ii};
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
    end
    
    TrainingSetIndexes = 1:floor(0.8*numImagesInFolder);
    
    for jj = 1:size_lambda
        lambda = lambdavec(jj);
        for kk = 1:3
            patchSize = patch_size1(:,:,kk);
            [background, backgroundCell] = ...
                extract_background_ica(dataPath, trainingSize, numImagesInFolder,...
                patchSize, lambda, TrainingSetIndexes);
            
            %Similarity measures: background images
            StreamBackground = OriginalVideoStream(:,:,:,backgroundIndexes{ii});
            [BackgroundCompCross.AvgLoss(ii,jj,kk),BackgroundCompCross.SSIM(ii,jj,kk),...
                BackgroundCompCross.PeakSNR(ii,jj,kk),BackgroundCompCross.MSE(ii,jj,kk)] = ...
                BackgroundImgComparison(StreamBackground,background);
        end
    end
    
    fprintf('Parameter tuning: iteration %d of 13\n',ii)
end

%choosing lambda, patch which yield highest similarity
%average over the sequences
meanSSIM = mean(BackgroundCompCross.SSIM,1);
[MaxCols,ArgMaxCols] = max(meanSSIM);
[MaxSSIM,ArgMax] = max(MaxCols);


fprintf('Parameter tuning: selected parameters\n')

lambda = lambdavec(ArgMaxCols(ArgMax)), patchSize = patch_size1(:,:,ArgMax)

simResultsName = strcat('PrjSim_Performances_Similarity_P1','_',date,'.mat');
    save(simResultsName,'BackgroundCompCross')

clear VideoLabelsBW GTLabelsBW OriginalVideoStream OriginalVideoStream_gs GTLabels

%training / test

%Saves simulation results (images): uncomment the lines in the following
%pattern (SimDir/mkdir/imwrite) if you wish to save the frames locally.
%SimDir = strcat('../../../../Documents/CIS_520_project/Sim_Test4_',datestr(date));
%mkdir(SimDir);
for ii = 1:NumSeqs
    
    trainingSize = 100;
    
    dataPath = dataPaths{ii};
    dataDir = dataDirs{ii};
    bmpImgsDir = dir([dataDir '*.bmp']);
    numImagesInFolder = size(bmpImgsDir,1);
    
    %Training w/ `training' indexes only
    trainIndexes = trainingIndexes{ii};
    NumNonStatic = length(trainIndexes);
    
    %Training w/ `training' indexes and a percentage of background idxs
    backIndexes = backgroundIndexes{ii};
    NumStatic = length(backIndexes);
    
    for jj = 1:numImagesInFolder
        ImagePath = strcat(dataPath,num2str(jj),'.bmp');
        OriginalVideoStream(:,:,:,jj) = imread(ImagePath);
        OriginalVideoStream_gs(:,:,jj) = rgb2gray(OriginalVideoStream(:,:,:,jj));
    end
    
    %loads labels
    dataPathGT = dataPathsGT{ii};
    dataDirGT = dataDirsGT{ii};
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
    end
    %Saves simulation results
    %SimDirSeq = strcat(SimDir,'/Seq',num2str(ii));
    %mkdir(SimDirSeq);
    
    TrainingSetIndexes = 1:floor(0.8*numImagesInFolder);
    
    ttIndexes = floor(0.8*numImagesInFolder)+1:numImagesInFolder;
    
    for mm = 1:size_training_vec
        
        %First K frames
        %up to 80% of the training set
        trIndexes = 1:floor(0.1*mm*0.8*numImagesInFolder);
        
        auxTime = tic;
        
        [background, backgroundCell] = ...
            extract_background_ica(dataPath, trainingSize, numImagesInFolder,...
            patchSize, lambda, trIndexes);
        trainTime(ii,mm) = toc(auxTime);
        
        [VideoWoBg,VideoWoBg_gs,VideoLabels] =  VideoStreamBackgroundRemoval(background,...
            OriginalVideoStream,algorithm,ImgType);
        
        %Evaluating performance measure (training)
        for jj = 1:numImagesInFolderGT
            VideoLabelsBW(:,:,jj) = imbinarize(VideoLabels(:,:,jj));
            %imwrite(VideoLabelsBW(:,:,jj),strcat(SimDirTraining,'/BW',...
            %    num2str(jj),'.png'));
            %imwrite(VideoWoBg_gs(:,:,jj),strcat(SimDirTrainingGS,'/GS',...
            %    num2str(jj),'.png'));
        end
        
        %imwrite(background,strcat(SimDirTrainingBg,'/Background_',...
        %       num2str(mm*10),'.png'));
        
        [VideoCompTr.RecallVec(ii,mm),VideoCompTr.PrecisionVec(ii,mm),...
            VideoCompTr.F1Vec(ii,mm),VideoCompTr.AvgLoss(ii,mm),...
            VideoCompTr.TNRVec(ii,mm)] = ...
            PixelPerfMeas(GTLabelsBW(:,:,trIndexes),VideoLabelsBW(:,:,trIndexes));
        
        %Similarity measures: background images
        StreamBackground = OriginalVideoStream(:,:,:,backgroundIndexes{ii});
        
        [BackgroundCompTr.AvgLoss(ii,mm),BackgroundCompTr.SSIM(ii,mm),...
            BackgroundCompTr.PeakSNR(ii,mm),BackgroundCompTr.MSE(ii,mm)] = ...
            BackgroundImgComparison(StreamBackground,background);
        
        %Static / non static images
        %First only nonstatic images
        trIndexes = trainIndexes(1:floor(0.1*mm*NumNonStatic));
        
        auxTime = tic;
        [background, backgroundCell] = ...
            extract_background_ica(dataPath, trainingSize, numImagesInFolder,...
            patchSize, lambda, trIndexes);
        trainTimeSNS(ii,mm) = toc(auxTime);
        
        [VideoWoBg,VideoWoBg_gs,VideoLabels] =  VideoStreamBackgroundRemoval(background,...
            OriginalVideoStream,algorithm,ImgType);
        
        %Evaluating performance measure (training)
        for jj = 1:numImagesInFolderGT
            VideoLabelsBW(:,:,jj) = imbinarize(VideoLabels(:,:,jj));
            %imwrite(VideoLabelsBW(:,:,jj),strcat(SimDirTraining,'/BW',...
            %    num2str(jj),'.png'));
            %imwrite(VideoWoBg_gs(:,:,jj),strcat(SimDirTrainingGS,'/GS',...
            %    num2str(jj),'.png'));
        end
        
        %imwrite(background,strcat(SimDirTrainingBg,'/Background_',...
        %       num2str(mm*10),'.png'));
        
        [VideoComp.RecallVec(ii,mm),VideoComp.PrecisionVec(ii,mm),...
            VideoComp.F1Vec(ii,mm),VideoComp.AvgLoss(ii,mm),...
            VideoComp.TNRVec(ii,mm)] = ...
            PixelPerfMeas(GTLabelsBW,VideoLabelsBW);
        
        %Similarity measures: background images
        StreamBackground = OriginalVideoStream(:,:,:,backgroundIndexes{ii});
        
        [BackgroundComp.AvgLoss(ii,mm),BackgroundComp.SSIM(ii,mm),...
            BackgroundComp.PeakSNR(ii,mm),BackgroundComp.MSE(ii,mm)] = ...
            BackgroundImgComparison(StreamBackground,background);
        
        %Now static and non static
        if mm == 10
            for nn = 1:10
                SIndexes = backIndexes(1:floor(0.1*mm*NumStatic));
                SNSIndexes = [trIndexes SIndexes];
                
                auxTime = tic;
                [background, backgroundCell] = ...
                    extract_background_ica(dataPath, trainingSize, numImagesInFolder,...
                    patchSize, lambda, SNSIndexes);
                trainTimeSNS(ii,mm) = toc(auxTime);
                
                [VideoWoBg,VideoWoBg_gs,VideoLabels] =  VideoStreamBackgroundRemoval(background,...
                    OriginalVideoStream,algorithm,ImgType);
                
                %Evaluating performance measure (training)
                for jj = 1:numImagesInFolderGT
                    VideoLabelsBW(:,:,jj) = imbinarize(VideoLabels(:,:,jj));
                    %imwrite(VideoLabelsBW(:,:,jj),strcat(SimDirTraining,'/BW',...
                    %    num2str(jj),'.png'));
                    %imwrite(VideoWoBg_gs(:,:,jj),strcat(SimDirTrainingGS,'/GS',...
                    %    num2str(jj),'.png'));
                end
                
                %imwrite(background,strcat(SimDirTrainingBg,'/Background_',...
                %       num2str(mm*10),'.png'));
                
                [VideoCompSNS.RecallVec(ii,nn),VideoCompSNS.PrecisionVec(ii,nn),...
                    VideoCompSNS.F1Vec(ii,nn),VideoCompSNS.AvgLoss(ii,nn),...
                    VideoCompSNS.TNRVec(ii,nn)] = ...
                    PixelPerfMeas(GTLabelsBW,VideoLabelsBW);
                
                %Similarity measures: background images
                StreamBackground = OriginalVideoStream(:,:,:,backgroundIndexes{ii});
                
                [BackgroundCompSNS.AvgLoss(ii,nn),BackgroundCompSNS.SSIM(ii,nn),...
                    BackgroundCompSNS.PeakSNR(ii,nn),BackgroundCompSNS.MSE(ii,nn)] = ...
                    BackgroundImgComparison(StreamBackground,background);
                
            end
        end
                       
        [VideoCompTt.RecallVec(ii,mm),VideoCompTt.PrecisionVec(ii,mm),...
            VideoCompTt.F1Vec(ii,mm),VideoCompTt.AvgLoss(ii,mm),...
            VideoCompTt.TNRVec(ii,mm)] = ...
            PixelPerfMeas(GTLabelsBW(:,:,ttIndexes),VideoLabelsBW(:,:,ttIndexes));
        
    end
    
    fprintf('Training error: sequence %d of 13\n',ii)
    
    simResultsName = strcat('PrjSim_Performances_Similarity_Seq',num2str(ii),'_',date,'.mat');
    save(simResultsName,'BackgroundComp','VideoComp', 'trainTime',...
        'BackgroundCompSNS','VideoCompSNS', 'trainTimeSNS',...
        'BackgroundCompTr','VideoCompTr',...
        'VideoCompTt')
    
    CurrentTime = toc(TotalTimeVar);
    
    fprintf('Current simulation time: %d s\n',CurrentTime)
    
    clear VideoLabelsBW GTLabelsBW OriginalVideoStream OriginalVideoStream_gs GTLabels
end

%plot
percentAux = 10:10:100;

figure, plot(percentAux,BackgroundComp.SSIM(1,:),'-d','LineWidth',1.5)
grid, hold on
plot(percentAux,BackgroundComp.SSIM(3,:),'-^','LineWidth',1.5)
plot(percentAux,BackgroundComp.SSIM(8,:),'-o','LineWidth',1.5)
plot(percentAux,BackgroundComp.SSIM(9,:),'-x','LineWidth',1.5)

%plot(percentAux,BackgroundComp.SSIM(13,:),'-s','LineWidth',1.5)
hXLabel = xlabel('% nonstatic frames');
hYLabel=  ylabel('Structural Similarity Index (SSIM)');
hLegend = legend('Simple Sequence','Camouflage','Illumination changes',...
    'Moving background','Moving camera');
hTitle = title('SSIM');

set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

 figure, plot(percentAux,BackgroundComp.PeakSNR(1,:),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,BackgroundComp.PeakSNR(3,:),'-^','LineWidth',1.5)
 plot(percentAux,BackgroundComp.PeakSNR(8,:),'-o','LineWidth',1.5)
 plot(percentAux,BackgroundComp.PeakSNR(9,:),'-x','LineWidth',1.5)
 
 %plot(percentAux,BackgroundComp.PeakSNR(13,:),'-s','LineWidth',1.5)
 hXLabel = xlabel('% nonstatic frames');
 hYLabel=  ylabel('Peak Signal-to-Noise Ratio');
 hLegend = legend('Simple Sequence','Camouflage','Illumination changes',...
     'Moving background','Moving camera');
 hTitle = title('Peak SNR');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel,hTitle]  , ...
    'FontSize'   , 10          );


 figure, plot(percentAux,BackgroundComp.MSE(1,:),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,BackgroundComp.MSE(3,:),'-^','LineWidth',1.5)
 plot(percentAux,BackgroundComp.MSE(8,:),'-o','LineWidth',1.5)
 plot(percentAux,BackgroundComp.MSE(9,:),'-x','LineWidth',1.5)
 
 %plot(percentAux,BackgroundComp.MSE(13,:),'-s','LineWidth',1.5)
 hXLabel = xlabel('% nonstatic frames');
 hYLabel=  ylabel('Mean Squared Error');
 hLegend = legend('Simple Sequence','Camouflage','Illumination changes',...
     'Moving background','Moving camera');
 hTitle = title('MSE');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

 figure, plot(percentAux,trainTime(1,:),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,trainTime(3,:),'-^','LineWidth',1.5)
 plot(percentAux,trainTime(8,:),'-o','LineWidth',1.5)
 plot(percentAux,trainTime(9,:),'-x','LineWidth',1.5)
 
 %plot(percentAux,BackgroundComp.MSE(13,:),'-s','LineWidth',1.5)
 hXLabel = xlabel('% nonstatic frames');
 hYLabel=  ylabel('Time');
 hLegend = legend('Simple Sequence','Camouflage','Illumination changes',...
     'Moving background','Moving camera');
 hTitle = title('Training time');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

