function labelimg = postProcessor(noduleimg)

%% extract features from the nodule image
% need to reconsider this
entropyOfImg = entropy(noduleimg);
energyOfImg = sum(noduleimg(:));

%% post process the nodules
% find the length of each nodules in the lung region
nodules = regionprops(noduleimg, 'Centroid', 'MajorAxisLength');
% consider nodules with length larger than 3.5 to be cancerous
cancerous = [];
index = [nodules.MajorAxisLength] > 3.5;
for i = 1: length(index)
    if index(i) == 1
        temps = subsetstruct(nodules(i), index(i));
        cancerous = [cancerous; temps];
    end
end
        