function greyimg = preProcessor()

%% read the image file and preprocess
% 032 is healthy
path = 'resources/000032.dcm';

% read the dcm image file
img = dicomread(path);

% this is how to show the dcm image
% imshow(img, [])

% transfer the rgb image to grey scale
% greyimg = rgb2gray(img);
greyimg = im2uint8(img);

% calculate the average grey level
avgimg = mean(double(reshape(greyimg, [], 1)));

end