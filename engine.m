function cancerous = engine()

% read the image file and preprocess
greyimg = preProcessor();

% use global image thresholding to find the edge
[dilateimg, lungimg] = cancerDetector(greyimg);

% extract the lung nodule segmentation
noduleimg = noduleExtractor(dilateimg);

% post process the nodules image and find the actual cancerous one
cancerous = postProcessor(noduleimg);

% label the cancerous nodules in the image
imshow(greyimg, []);
% imshow(noduleimg);
hold on;
for i = 1: length(cancerous)
    centers = cancerous(i).Centroid;
    diameters = mean([cancerous(i).MajorAxisLength cancerous(i).MinorAxisLength], 2);
    radii = diameters/2;
    viscircles(centers,radii);
end
hold off;

end
