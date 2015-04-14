function greyimg = preProcessor()

%% read the image file and preprocess
% 032 is healthy
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

% %% use gabor filter to process the ct image
% % set the parameters
% lambda  = 8;
% theta   = 0;
% psi     = [0 pi/2];
% gamma   = 0.5;
% bw      = 1;
% N       = 8;
% img_in = greyimg;
% % img_in(:,:,2:3) = [];   % discard redundant channels, it's gray anyway
% img_out = zeros(size(img_in,1), size(img_in,2), N);
% for n=1:N
%     gb = gaborfilter(bw,gamma,psi(1),lambda,theta)...
%         + 1i * gaborfilter(bw,gamma,psi(2),lambda,theta);
%     % gb is the n-th gabor filter
%     img_out(:,:,n) = imfilter(img_in, gb, 'symmetric');
%     % filter output to the n-th channel
%     theta = theta + 2*pi/N;
%     % next orientation
% end
% img_out_disp = sum(abs(img_out).^2, 3).^0.5;
% % default superposition method, L2-norm
% img_out_disp = img_out_disp./max(img_out_disp(:));

end