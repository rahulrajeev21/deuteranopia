function[imageOut infoLost] = deuteranopiaSim(imageRGB)

% This function takes the input image and creates a new output image that
% simulates what a person suffering from Deuteranopia would perceive.
% It converts the image from RGB to LMS color space and removes the M (medium)
% wavelength information that corresponds to the patients missing green cones.


% imageRGB = im2double(imread('colorcircle.jpg')); %debug


[imageHeight imageWidth imageDepth] = size(imageRGB);
imageLMS = zeros(size(imageRGB));
imageOut = zeros(size(imageRGB));
rgbPixel = zeros(3,1);
lmsPixel = zeros(3,1);

%Matrices to convert between RGB and LMS
rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709];

lms2rgb = inv(rgb2lms);

%Matrix to adjust LMS image to simulate Deuteranopia, Protanopia or
%Tritanopia

deutAdjust = [1 0 0; 0.494207 0 1.24827; 0 0 1];

%Remove gamma correction before manipulating image
gamma = 2.1;
imageRGB = imageRGB.^gamma;

for y=1:imageHeight
    for x=1:imageWidth
        %Convert input image to LMS colorspace and adjust for Deuteranopia
        rgbPixel(1:3)=imageRGB(y,x,:); %RGB values at that pixel
        lmsPixel(1:3)=rgb2lms*rgbPixel; %LMS values at that pixel
        %adjusted LMS values at that pixel
        imageLMS(y,x,:)=deutAdjust*lmsPixel;
        
        %Convert image back to RGB color space
        lmsPixel(1:3)=imageLMS(y,x,:);
        imageOut(y,x,:)=lms2rgb*lmsPixel;
    end
end

%Gamma-correct imageOut and imageRGB for viewing
    imageRGB = imageRGB.^(1/gamma);
    imageRGB = imageOut.^(1/gamma);
    
%Gather lost information into infoLost
    infoLost=imageRGB-imageOut;
    
%     imshow(imageOut); %debug
end
