%% clear
clc; clear all; close all;

%% load image
imrgb = imread('./im/sandstone.png');

%% RGB -> G
im = imrgb(:,:,2);

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:))); 

%% microcracks segmentation
s1 = 10; 
s2 = 10; 
nr = 12;

imsk = sandstone_microcracks_segmentation2d(im,s1,s2,nr);

%% plot
figure, imagesc(imrgb); colormap jet;
set(gca,'ytick',[]); set(gca,'xtick',[]); axis equal; axis tight;

figure, imagesc(imsk); colormap gray;
set(gca,'ytick',[]); set(gca,'xtick',[]); axis equal; axis tight;
