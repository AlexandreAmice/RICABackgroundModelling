%Given two ICA backgrounds choose the true color one that contains the
%background
function [background,backgroundCell] = select_background(sampleImg, ica1, ica2)
[numRows, numCols] = size(sampleImg);
backgroundCell = sampleImg;
plots = 0;
for r = 1:numRows
    for c = 1:numCols
        close all;
        guesses = {ica1{r,c}, -ica1{r,c}, ica2{r,c}, -ica2{r,c}};
        
        distances = zeros(length(guesses),1);
        curPatch = sampleImg{r,c};
        for i = 1:length(guesses)
            curGuess = scale_to_uint8(guesses{i});
            distances(i) = ssim(curGuess, curPatch);
        end
        [~, backIdx] = max(distances);

        backgroundCell{r,c} = scale_to_uint8(guesses{backIdx});
        
    end
end
background = cell2mat(backgroundCell);
end