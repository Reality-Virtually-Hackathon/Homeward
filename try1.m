%%
%some new stuff for commit.
close all

video_file = 'D:\4kvideo\videos\fv.mp4';
v = VideoReader(video_file);

v.CurrentTime = 2.5;
video = readFrame(v);
h = size(video,1);
w = size(video,2);

video = video(:,20:end,:);
video = video(:,382:546,:);

im1 = video(1:h/2,1:end,1:3);
im2 = video(h/2 + 1: end,1:end,1:3);
%
% ha = [];
% figure;
% ha(end+1) = subplot(1,2,1);
% imagesc(im1);
% ha(end+1) = subplot(1,2,2);
% imagesc(im2);


ha = [];
figure;
ha(end+1)=subplot(1,1,1);
imagesc(im1);
figure;
ha(end+1)=subplot(1,1,1);
imagesc(im2);
linkaxes(ha,['x','y'])

disparityRange = [-32 32];
d = disparity(double(rgb2gray(im1)), double(rgb2gray(im2)), 'BlockSize',...
    5,'DisparityRange',disparityRange);
d(d<0)=0;
ha = [];
figure;
ha(end+1)=subplot(1,1,1);
imagesc(double(rgb2gray(im1)));
figure;
ha(end+1)=subplot(1,1,1);
imagesc(double(rgb2gray(im2)));
figure;
ha(end+1)=subplot(1,1,1);
imagesc(d);
linkaxes(ha,['x','y'])




%%
d_list = [-20 : 20];
d = zeros(size(im1,1),size(im1,2));

for ii = 1:length(d_list)

    diff = double(im1) - double(circshift(im2,[0,d_list(ii)]));


    ha = [];
    figure(8);
    ha(end+1) = subplot(1,3,1);
    imagesc(im1);
    ha(end+1) = subplot(1,3,2);
    imagesc(circshift(im2,[0,d_list(ii)]));
    ha(end+1) = subplot(1,3,3);
    imagesc(sum(abs(diff),3) == 0)
    imagesc(diff)
    title(d_list(ii))
    linkaxes(ha,['x','y']);
    pause(.1)

    diff = sum(abs(diff),3);
    d(find(diff<10))=d_list(ii);
end

figure; imagesc(d)

%%

I1 = imread('scene_left.png');
I2 = imread('scene_right.png');

figure
imshow(stereoAnaglyph(I1,I2));
title('Red-cyan composite view of the stereo images');

disparityRange = [-6 10];
disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
    15,'DisparityRange',disparityRange);

figure
imshow(disparityMap,disparityRange);
title('Disparity Map');
colormap(gca,jet)
colorbar
