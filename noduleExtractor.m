function noduleimg = noduleExtractor(dilateimg)

%% extract the lung nodule segmentation
% find the boundary of lung in the image
[B, ~, N, ~] = bwboundaries(dilateimg,'noholes');

% generate a temp matrix with all the point position in the image
[nrow, ncol] = size(dilateimg);
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
        dilateimg(position(1, 1), position(1, 2)) = 1;
    end
end

% get the nodules by invert the tranformed image
noduleimg = ~dilateimg;
% consider whether erode image is necessary
% it is not necessary
% SE = strel('disk', 1);
% dilateimg = imerode(dilateimg, SE);

end