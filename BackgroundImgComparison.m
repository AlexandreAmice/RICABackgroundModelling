%CIS 520 --- Spring 2019
%
%Final Project
%
%This function computes some performance / similarity measures between two
%images (one of them a reference background and the other one the
%background image found by the ICA method). We assume the input is an RGB
%image.
%
%Inputs
%   RefBground: k \times n \times d matrix representing the reference
%   background;
%   ICABground: k \times n \times d matrix representing the background
%   image found by the ICA algorithm.
%
%Outputs
%   AverageSqLoss: average squared loss of the background image pixels with
%   relation to the reference image;
%   BgroundSSIM: structural similarity index, using MATLAB built-in `ssim'
%   function.
%   PSNR: peak signal-to-noise ratio (MATLAB `psnr')
%   MSE: mean squared error, pixel by pixel. (MATLAB `immse')
function [AverageSqLoss,BgroundSSIM,PeakSNR,MSError] = BackgroundImgComparison(RefBground,...
    ICABground)

[k,n,d,T] = size(RefBground);
[k_ica,n_ica,d_ica] = size(ICABground);
if k ~= k_ica || n ~= n_ica || d ~= d_ica
    error('ICA and Reference background images have different dimensions.\n')
end

%Structural Similarity Index

ICABgroundGS = rgb2gray(ICABground);

%Average squared error loss
for ii = 1:T
    %SSIM
    RefBgroundGS = rgb2gray(RefBground(:,:,:,ii));
    BgroundSSIMVec(ii) = ssim(ICABgroundGS,RefBgroundGS);
    BgroundSNRVec(ii) = psnr(ICABground,RefBground(:,:,:,ii));

    %MSE
    for jj = 1:d
        BgroundDiff = ICABground(:,:,jj) - RefBground(:,:,jj,ii);
        BgroundDiffSq(:,:,jj) = BgroundDiff.^2;
    end
    AverageSqLossVec(ii) = sum(BgroundDiffSq(:))/(k*n*d);
    MSErrorVec(ii) = immse(ICABground,RefBground(:,:,:,ii));
end

AverageSqLoss = mean(AverageSqLossVec);
BgroundSSIM = mean(BgroundSSIMVec);
PeakSNR = mean(BgroundSNRVec);
MSError = mean(MSErrorVec);