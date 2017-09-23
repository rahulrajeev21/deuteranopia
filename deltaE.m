function [imageOut] = deltaE(imageOriginal,imageModified)
% This function calculates the delta E value, or color difference in the
% LAB color space, betweeen the two input images.
% imageOriginal = imread('deltamod.jpg'); %debug
% imageModified = imread('deltadeut.jpg'); %debug

[imageHeight imageWidth imageDepth] = size(imageOriginal);

% Convert image from RGB to LAB colorspace
cform = makecform('srgb2lab');
labOriginal = applycform(im2double(imageOriginal),cform);
labModified = applycform(im2double(imageModified),cform);


% Extract out the color bands from the original image into 3 separate 2D
% arrays, one for each color component

L_original = labOriginal(:,:,1);
a_original = labOriginal(:,:,2);
b_original = labOriginal(:,:,3);

L_modified = labModified(:,:,1);
a_modified = labModified(:,:,2);
b_modified = labModified(:,:,3);

% Create the delta images: delta L, delta A and delta B
delta_L=L_original-L_modified;
delta_a=a_original-a_modified;
delta_b=b_original-b_modified;

% Create the delta E image
% This is an image that represents the color difference
% Delta E is the square root of the sum of squares of the delta images

delta_E = sqrt(delta_L.^2+delta_a.^2+delta_b.^2);

imageOut = delta_E;

% imshow(imageOut); %debug
end