function labelimg = postProcessor(noduleimg)

%% extract features from the nodule image
% need to reconsider this
entropyOfImg = entropy(noduleimg);
energyOfImg = sum(noduleimg(:));

%% post process the nodules
% find the length of each nodules in the lung region
nodules = regionprops(noduleimg, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
% consider nodules with max length larger than 3.5 and 
% min length larger than 1 to be cancerous
cancerous = [];
maxindex = [nodules.MajorAxisLength] > 4.5;
minindex = [nodules.MinorAxisLength] > 1;
index = maxindex .* minindex;
for i = 1: length(index)
    if index(i) == 1
        temps = nodules(i);
        cancerous = [cancerous; temps];
    end
end

%% label the cancerous nodules in the image
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

