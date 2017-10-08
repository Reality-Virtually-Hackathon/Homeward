%% manual crazy

%% block disparity
video_file = 'D:\4kvideo\videos\sv.mp4';
v = VideoReader(video_file);

v.CurrentTime = 2.5;
video = readFrame(v);

video = video(:,1605:2425,:);
% 
% video = video(:,20:end,:);
% video = video(:,382:546,:);


h = size(video,1);
im1 = video(1:h/2,1:end,1:3);
im2 = video(h/2 + 1: end,1:end,1:3);

h = size(im1,1);
w = size(im1,2);
d = zeros(size(im2,1),size(im2,2));
bsize = 20;





patch = double(im1( 914:1000,322:400,:));
other = double(im2);

figure; 
subplot(1,2,1);
imagesc(patch/256);
subplot(1,2,2);
imagesc(other/256)


C = normxcorr2(rgb2gray(uint8(patch)),rgb2gray(uint8(other)));
figure;
imagesc(C); title(max(C(:)));

[dummy,idx] = max(C(:));
[y,x] = ind2sub(size(C),idx);
hold on;
plot(x,y,'r*');


C1 = normxcorr2(patch(:,:,1), other(:,:,1));
C2 = normxcorr2(patch(:,:,2), other(:,:,2));
C3 = normxcorr2(patch(:,:,3), other(:,:,3));
D = C1+C2+C3;

figure; imagesc(D); title(max(D(:)));

[dummy,idx] = max(D(:));
[y,x] = ind2sub(size(C),idx);
hold on;
plot(x,y,'r*');

%figure; imagesc(conv2(rgb2gray(uint8(patch)),rgb2gray(uint8(other))))