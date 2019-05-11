%CIS 520 --- Spring 2019
%
%Final Project
%
%This function computes precision, recall and F1 measure on two binary
%matrices representing the predicted values and true labels.
%
%Inputs
%   Labels: k \times n \times T matrix with the true labels for each pixel/element
%   of the matrix;
%   Predictions: k \times n \times T matrix with the predicted values for each
%   pixel/element of the image matrix;
%
%Outputs
%   Recall: fraction of positive examples which are predicted accurately;
%   Precision: fraction of positive predictions that are actually positive;
%   F1 measure: harmonic mean of recall and precision

function [VideoRecall,VideoPrecision,VideoF1,MeanAvgLoss,VideoTNR] = PixelPerfMeas(GTLabels,...
    VideoPredictions)

[k,n,T] = size(GTLabels);

FramesRecall = zeros(1,T);
FramesPrecision = zeros(1,T);
AvgLoss = zeros(1,T);

for jj = 1:T
    %(positions of) positive labels
    TrueLabels = find(GTLabels(:,:,jj));
    %(positions of) instances classified as 1
    PosPredictions = find(VideoPredictions(:,:,jj));
    %finds instances correctly classified
    CorrectInstances = ismember(PosPredictions,TrueLabels);
    %Recall / TPR
    if sum(sum(GTLabels(:,:,jj))) == 0
        if sum(sum(VideoPredictions(:,:,jj))) == 0
            FramesRecall(jj) = 1;
        else
            FramesRecall(jj) = 0;
        end
    else
        FramesRecall(jj) = sum(CorrectInstances)/sum(sum(GTLabels(:,:,jj)));
    end
    %Precision
    if sum(sum(VideoPredictions(:,:,jj))) == 0
        if sum(sum(GTLabels(:,:,jj))) == 0
            FramesPrecision(jj) = 1;
        else
            FramesPrecision(jj) = 0;
        end
    else
        FramesPrecision(jj) = sum(CorrectInstances)/sum(sum(VideoPredictions(:,:,jj)));        
    end
    
    %average loss over all pixels
    Mismatches = abs(GTLabels(:,:,jj) - VideoPredictions(:,:,jj));
    AvgLoss(jj) = sum(sum(Mismatches))/(k*n);
    
    %true negative rate
    NegLabelsAux = abs(GTLabels(:,:,jj) - 1);
    NegPredictionsAux = abs(VideoPredictions(:,:,jj) - 1);
    
    NegLabels = find(NegLabelsAux);
    NegPredictions = find(NegPredictionsAux);
    
    CorrectNegatives = ismember(NegPredictions,NegLabels);
    FramesTNR = sum(CorrectNegatives)/sum(sum(NegLabelsAux));
end

VideoRecall = mean(FramesRecall);
VideoPrecision = mean(FramesPrecision);

VideoF1 = 2*VideoRecall*VideoPrecision / (VideoRecall + VideoPrecision);

MeanAvgLoss = mean(AvgLoss);

VideoTNR = mean(FramesTNR);


