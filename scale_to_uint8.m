%Rescale a double image to a standard uint
function [image] = scale_to_uint8(orgImg)
image = uint8(255 * mat2gray(orgImg));
end