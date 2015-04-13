function labelimg = postProcessor(noduleimg)

%% extract features from the nodule image
% need to reconsider this
entropyOfImg = entropy(noduleimg);
energyOfImg = sum(noduleimg(:));

%% post process the nodules
% find the length of each nodules in the lung region
noduleSize = regionprops(noduleimg, 'MajorAxisLength');