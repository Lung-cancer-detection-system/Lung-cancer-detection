% process the image to binary
level = graythresh(imgsum);
imgbw = im2bw(imgsum, level + 0.3);

% use the watershed algorithm
imgshed = watershed(imgbw);

% create morphological structuring element (STREL) and erode image
SE = strel('disk', 1);
imgerode = imerode(imgshed, SE);

% dilate image
SE = strel('disk', 1);
imgdilate = imdilate(imgerode, SE);
imshow(imgdilate);