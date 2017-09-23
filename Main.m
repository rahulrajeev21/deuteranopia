clear all

%Load image:
imageRGB = im2double(imread('rubik.jpg'));

%proposed algorithm
%laplacian filter
H = fspecial ('laplacian');

%apply laplacian filter
blurred = imfilter(imageRGB,H);
% imshow(blurred); title('Edge detected image');
lap=imsubtract(imageRGB,blurred);

%simulation
[sim error]=deuteranopiaSim(lap);


corrected  = daltonize(lap,error);
[simCorrected error2] = deuteranopiaSim(corrected);


% figure(15)
% imshow(blurred)
% title('Edge-Detection')

% figure(1)
figure('name','Proposed Algorithm','NumberTitle','off');
% imshow(lap)
% title('Pre-processed image')


subplot(2,2,1)
imshow(lap)
title('Pre-processed image')
subplot(2,2,2)
imshow(sim)
title('Simulation of pre-processed image')
subplot(2,2,3)
imshow(corrected)
title('Modified Image')
subplot(2,2,4)
imshow(simCorrected)
title('Simulation of Modified Image')


% figure(2)
% imshow(sim)
% title('Simulation of pre-processed image')

% figure(3)
% imshow(corrected)
% title('Modified Image')

% figure(4)
% imshow(simCorrected)
% title('Adjusted image as seen by Deuteranopia patient')
delta_E1 = deltaE(real(corrected),real(simCorrected));

% figure(5)
% imagesc(delta_E)
% colorbar
% title('Delta E')

% RGB COLOUR CONTRAST APPROACH

imageCon = contrast(imageRGB,8);
imageConSim = deuteranopiaSim(imageCon);
delta_E2 = deltaE(imageCon, real(imageConSim));
    
figure('name','Color Contrast Algorithm','NumberTitle','off');

subplot(2,2,1)
imshow(imageRGB)
title('Original Image')

% figure(7)
subplot(2,2,2)
imshow(sim)
title('Simulation of Original Image')

% figure(8)
subplot(2,2,3)
imshow(imageCon)
title('Modified Image')

% figure(9)
subplot(2,2,4)
imshow(imageConSim)
title('Simulation of modified image')

% figure(10)
% imagesc(delta_E)
% colorbar
% title('Delta E (COLOR CONTRAST)')

%LAB COLOUR CORRECTION

colorAdjust = correctColor(imageRGB);
colorAdSim = deuteranopiaSim(colorAdjust);
delta_E3 = deltaE(imageRGB,real(colorAdSim));

% figure(3)
figure('name','LAB Color Correction Algorithm','NumberTitle','off');
subplot(2,2,1)
imshow(imageRGB)
title('Original Image')

subplot(2,2,2)
imshow(sim)
title('Simulation of Original Image')

% figure(12)
subplot(2,2,3)
imshow(colorAdjust)
title('Modified Image')

% figure(13)
subplot(2,2,4)
imshow(colorAdSim)
title('Simulation of modified image')

% figure(14)

figure('name','Delta E','NumberTitle','off');
subplot(2,2,1)
imagesc(delta_E1)
colorbar
title('Delta E (Proposed Algorithm)')

subplot(2,2,3)
imagesc(delta_E2)
colorbar
title('Delta E (Colour Contrasting)')

subplot(2,2,4)
imagesc(delta_E3)
colorbar
title('Delta E (LAB Colour Correction)')

