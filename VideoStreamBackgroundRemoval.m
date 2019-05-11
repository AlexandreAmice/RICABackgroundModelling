%CIS 520 - Spring 2019
%
%Final Project - Group 14 - Moving object detection using ICA
%
%Given background image from ICA code, subtracts background from original
%video stream. 
%
%Inputs:
%
%BackgroundImg: k \times n \times d matrix (d is the image 'depth',1  for
%gray scale, 3 for RGB and HSV) representing the background image learned
%by the ICA algorithm;
%
%OriginalVideoStream: k \times n \times d \times t matrix ( with t the
%number of images in the video stream).
%
%Algorithm: string with the algorithm for background removal
%   'static_rgb': static frame difference(component wise);
%   'GMM': EM algorithm for Gaussian mixture model with background
%   knowledge (not implemented yet; not used in the report)
%   'gray_subtract': imsubtract for grayscale image
%   'structural_sim': removes background using structural similarity, cf.
%   MATLAB builtin `ssim' function. 
%
%Output:
%
%StreamRemovedBackground: k \times n \times d \times t matrix representing
%the sequence of images with the background removed (for illustration)
%
%MovingObjectsLabel: k \times n \times t binary matrix with 0 for static
%pixels and 1 for moving pixels.
%
%Obs: the lasiesta convention uses RGB notation. 

function [StreamRemovedBackground,StreamRemovedBackground_gs, MovingObjectsLabelSimplified] = ...
    VideoStreamBackgroundRemoval(BackgroundImg,OriginalVideoStream,...
    algorithm,ImgType)

c = 0;

%Detecting specific algorithm
SupportedAlgorithms = ["static_rgb","gmm_em","gray_subtract","structural_sim"];

alg_type = find(strcmpi(algorithm,SupportedAlgorithms));

if nnz(alg_type) == 0
    error('Background subtraction technique not supported.')
end

%Detecting specific image type
SupportedTypes = ["gray","HSV","RGB"];

img_type = find(strcmpi(ImgType,SupportedTypes));

if nnz(img_type) == 0
    error('Image type not supported.')
end

%Matrices dimensions
[k,n,d,T] = size(OriginalVideoStream);

[k_back,n_back,d_back] = size(BackgroundImg);

if k_back ~= k || n_back ~= n || d_back ~= d
    error('Background image and video stream dimensions do not agree.')
end

%Pre-allocation
%Note that when we use pre allocation this way then Matlab will import the
%image data as double
%StreamRemovedBackground = zeros(k,n,d,T);
%Using RGB for now
MovingObjectsLabel = zeros(k,n,3,T);
%use a binary matrix representation instead!
MovingObjectsLabelSimplified = zeros(k,n,T);

% Find common features
% background_gs = rgb2gray(background);
% HarrisFeatures_bg = detectHarrisFeatures(background_gs);
% [FeaturesBg,ValidPointsBg] = extractFeatures(background_gs,HarrisFeatures_bg);
% for jj = 1:T
%     OriginalVideoStream_gs(:,:,jj) = rgb2gray(OriginalVideoStream(:,:,:,jj));
%     ArrayHarrisPoints{jj} = detectHarrisFeatures(OriginalVideoStream_gs(:,:,jj));
%     [ArrayFeatures{jj},ArrayValidPoints{jj}] = ...
%         extractFeatures(OriginalVideoStream_gs(:,:,jj),ArrayHarrisPoints{jj});
%     HarrisIndexPairs{jj} = matchFeatures(ArrayFeatures{jj},FeaturesBg);
%     HarrisMatchedPoints{jj} = ArrayValidPoints{jj}(HarrisIndexPairs{jj}(:,1),:);
% end

SE  = strel('Disk',1,4);
background_gs = rgb2gray(BackgroundImg);

switch alg_type
    case 1
        %static frame difference / assuming RGB
        %using provided background image
        %obs: ssim based task is giving better results for now.
        for i = 1:T
            for jj = 1:d
                StreamRemovedBackground(:,:,jj,i) = abs(OriginalVideoStream(:,:,jj,i) ...
                    - BackgroundImg(:,:,jj));
                 aux_rgb(:,:,jj,i) = StreamRemovedBackground(:,:,jj,i) - c;
                 aux_rgb(:,:,jj,i) = max(aux_rgb(:,:,jj,i),0);
            end
            RGBWoBg_gs(:,:,i) = rgb2gray(StreamRemovedBackground(:,:,:,i));
            RGBWoBg_gs_2(:,:,i) = imdilate(RGBWoBg_gs(:,:,i), SE);
            RGBWoBg_gs_3(:,:,i) = rgb2gray(aux_rgb(:,:,:,i));
            %T = adaptthresh(RGBWoBg_gs(:,:,jj), 0.04);
            %RGBBw(:,:,jj) = imbinarize(RGBWoBg_gs(:,:,jj),T);
            %aux_scalar = zeros(k,n);
            %aux_scalar(find(RGBWoBg_gs(:,:,jj))) = 255;
            %RGBWoBgBW_test(:,:,jj) = aux_scalar;    
            %level = graythresh(RGBWoBg_gs_2(:,:,i));
            %BW(:,:,i) = imbinarize(RGBWoBg_gs_2(:,:,i),level);
            RGBWoBg_ed(:,:,i) = edge(RGBWoBg_gs(:,:,i),'sobel');
            img_dil = imdilate(RGBWoBg_ed(:,:,i),SE);
            img_fill = imfill(img_dil,'holes');
            %RGBWoBg_ed_2(:,:,i) = edge(RGBWoBg_gs_3(:,:,i),'canny');
            RGBWoBg_ed_2(:,:,i) = img_fill;
        end      
        StreamRemovedBackground_gs = RGBWoBg_gs;
        %uncomment if wish to see video
        %implay(RGBWoBg_gs), implay(RGBWoBg_ed), implay(RGBWoBg_ed_2)
    case 2
        %EM/GMM/k-means-> not implemented yet, not used in the report. Save
        %for future tests.
    case 3
        %grayscale + imsubtract + canny edge
        for jj = 1:T
            OriginalVideoStream_gs(:,:,jj) = rgb2gray(OriginalVideoStream(:,:,:,jj));
            VideoStreamWoBg(:,:,jj) = ...
                imsubtract(OriginalVideoStream_gs(:,:,jj),background_gs);
            T = adaptthresh(VideoStreamWoBg(:,:,jj), 0.4);
            VideoStreamBw(:,:,jj) = imbinarize(VideoStreamWoBg(:,:,jj),T);
            %VideoStreamBw(:,:,jj) = imbinarize(VideoStreamWoBg(:,:,jj),'adaptive');
            %VideoStreamBwManual(:,:,j)
            aux(:,:,jj) = imsubtract(imdilate(OriginalVideoStream_gs(:,:,jj), SE),imerode(background_gs, SE));
            mask(:,:,jj) = imbinarize(aux(:,:,jj),T);
            %trying manually
            aux2(:,:,jj) = imdilate(OriginalVideoStream_gs(:,:,jj),SE)- imerode(background_gs, SE);
            aux2(:,:,jj) = aux2(:,:,jj) - 20;
            aux2(:,:,jj) = max(aux2(:,:,jj),0);
            aux3(:,:,jj) = OriginalVideoStream_gs(:,:,jj) -background_gs;
            %aux3(:,:,jj) = imdilate(OriginalVideoStream_gs(:,:,jj),SE) -background_gs;
            aux3(:,:,jj) = aux3(:,:,jj) - 15;
            aux3(:,:,jj) = max(aux3(:,:,jj),0);
            aux_scalar = aux3(:,:,jj);% = min(aux3(:,:,jj),1);
            aux_scalar(find(aux_scalar)) = 255;
            aux4(:,:,jj) = aux_scalar; %imbinarize(aux3(:,:,jj));
        end
        StreamRemovedBackground_gs = aux4;
        StreamRemovedBackground = VideoStreamWoBg;
        
    case 4
        %Structural similarity index using MATLAB `ssim' function
        %that is the approach we are using in the project report%
        for jj = 1:T
            %Finds grayscale representation of original video stream
            OriginalVideoStream_gs(:,:,jj) = rgb2gray(OriginalVideoStream(:,:,:,jj));
            %Finds the global structural similarity value and the local
            %ssim for each pixel in the image.
            [ssimval(jj), ssimmap(:,:,jj)] = ...
                ssim(OriginalVideoStream_gs(:,:,jj),background_gs);
            %StructuralMap(:,:,jj) = ssimmap(:,:,jj) - 0.85;
            StructuralMap(:,:,jj) = ssimmap(:,:,jj) - ssimval(1) + 0.4;
            StructuralMap(:,:,jj) = max(StructuralMap(:,:,jj),0);
            %RemovedBackground = 255*ones(k,n);
            for ii = 1:d
                RemovedBackground = OriginalVideoStream(:,:,ii,jj);
                RemovedBackground(find(StructuralMap(:,:,jj))) = 0;
                StreamRemovedBackground(:,:,ii,jj) = RemovedBackground;
            end
            StreamRemovedBackground_gs(:,:,jj) = rgb2gray(StreamRemovedBackground(:,:,:,jj));
        end
        %uncoment and use a break point if you want to see the ssim values
        %for each pixel.
         %vec1 = 1:k; vec2=1:n;
        %figure, figure, surf(vec2,vec1,ssimmap(:,:,jj)), title('ssim values (pixelwise)')
%         figure, plot(vec2,ssimmap(1,:,jj)), title('ssim values (pixelwise)')
%         figure, plot(vec1,ssimmap(:,100,jj)), title('ssim values (pixelwise)')
%         
        
        
    otherwise
        error('Background subtraction technique not supported.')
end

%Creating image labels
switch img_type
    case 1
        %gray scale -> RGB
        for i = 1:T
            for ii = 1:n
                for jj = 1:k
                    %what threshold shoud we use?
                    if StreamRemovedBackground(jj,ii,1,i) ~= 0
                        MovingObjectsLabel(jj,ii,1,i) = 255;
                        MovingObjectsLabelSimplified(jj,ii,i) = 255;
                    end
                end
            end
        end
    case {2,3} %HSV // RGB
        for i = 1:T
            for ii = 1:n
                for jj = 1:k
                    if StreamRemovedBackground(jj,ii,1,i) > c || ...
                            StreamRemovedBackground(jj,ii,2,i) > c || ...
                            StreamRemovedBackground(jj,ii,3,i) > c
                        MovingObjectsLabel(jj,ii,1,i) = 255;
                        MovingObjectsLabelSimplified(jj,ii,i) = 255;
                    end
                end
            end
        end
    otherwise
        error('Image type not supported.')
end






