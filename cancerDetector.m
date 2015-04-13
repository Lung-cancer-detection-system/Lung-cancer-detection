function result = cancerDetector()

%% read the image file and preprocess
path = 'resources/000008.dcm';

% read the dcm image file
img = dicomread(path);

% this is how to show the dcm image
% imshow(img, [])

% transfer the rgb image to grey scale
% greyimg = rgb2gray(img);
greyimg = im2uint8(img);

% calculate the average grey level
avgimg = mean(double(reshape(greyimg, [], 1)));

%% use global image thresholding to find the edge
% generate the thresholded image
[segimg, ~] = otsu(greyimg,2);
% segimg(find(segimg == 1)) = 0;
segimg(find(segimg == 2)) = 0;

% implement morphological reconstruction to 
% find the lung region in the image
inborderimg = imclearborder(segimg);

% erode the image
SE = strel('disk', 3);
imgerode = imerode(inborderimg, SE);

% dilate the image to restore the nodules
SE = strel('disk', 3);
imgdilate = imdilate(imgerode, SE);

% store the lung image for post process
lungimg = imgdilate;
% imshow(imgdilate);

%% extract the lung nodule segmentation
% find the boundary of lung in the image
[B, ~, N, ~] = bwboundaries(imgdilate,'noholes');

% generate a temp matrix with all the point position in the image
[nrow, ncol] = size(imgdilate);
temp = zeros(nrow * ncol, 2);
curr = 0;
for i = 1: nrow
    for j = 1: ncol
        curr = curr + 1;
        temp(curr, 1) = i;
        temp(curr, 2) = j;
    end
end

% check whether a point is inside one of the boundary or not
label = [];
for k = 1: N
    label = [label inpoly(temp, B{k})];
end

% if a point is not in the boundary, then set its value to 1
for n = 1: nrow * ncol
    res = find(label(n, :) == 1);
    if size(res, 2) == 0
        position = temp(n, :);
        imgdilate(position(1, 1), position(1, 2)) = 1;
    end
end

% get the nodules by invert the tranformed image
imgdilate = ~imgdilate;
% consider whether erode image is necessary
% it is not necessary
% SE = strel('disk', 1);
% imgdilate = imerode(imgdilate, SE);

%% post process the nodules in the image
