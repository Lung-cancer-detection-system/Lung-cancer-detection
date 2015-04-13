function cancerous = postProcessor(noduleimg)

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
maxindex = [nodules.MajorAxisLength] > 4.26;
minindex = [nodules.MinorAxisLength] > 1;
index = maxindex .* minindex;
for i = 1: length(index)
    if index(i) == 1
        temps = nodules(i);
        cancerous = [cancerous; temps];
    end
end

end

