%CIS 520 - Spring 2019
%
%Final Project - Group 14 - Moving object detection using ICA
%
%Takes a 4D matrix of data in format (row, column, depth, time) and outputs
% a row*column x time x depth matrix
%
%time_stack: 3D matrix capable of training ICA data on
function [ica_data, numRows, numCols, depth] = time_stack_to_ica_data(time_stack)
[numRows, numCols, depth, time] = size(time_stack);
numPixels = numRows*numCols*depth;
ica_data = zeros( numPixels, time);


for t = 1:time
    ica_data(:,t) = reshape(time_stack(:,:,:,t), numPixels, 1);
end

end