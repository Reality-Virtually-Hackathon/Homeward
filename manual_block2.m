%% block disparity
video_file = 'D:\4kvideo\videos\sv.mp4';
v = VideoReader(video_file);

v.CurrentTime = 2.5;
video = readFrame(v);

% 
% video = video(:,20:end,:);
% video = video(:,382:546,:);


h = size(video,1);
im1 = video(1:h/2,1:end,1:3);
im2 = video(h/2 + 1: end,1:end,1:3);

% im1 = im1(1:1726,:,:);
% im2 = im2(1:1726,:,:);

% im1 = edge(rgb2gray(im1));
% im2 = edge(rgb2gray(im2));

% d = disparity(im1,im2);
d = disparity(rgb2gray(im1),rgb2gray(im2));

figure; imagesc(d);
caxis([0,max(d(:))])

figure; imagesc(im1);

q = stdfilt(im1);
ch = q(:);
mask = sum(q,3) > .001*max(ch);

fd = medfilt2(d.*mask,[25,25]);

figure; imagesc(fd)
caxis([0,max(fd(:))])
disp = fd;
im = im1;

save('disparity.mat','disp','im');

% 
% 
% 
% 
% h = size(im1,1);
% w = size(im1,2);
% d = zeros(size(im2,1),size(im2,2));
% bsize = 500;
% 
% for ii = 1:bsize:size(im1,1)
%     for jj = 1:bsize:size(im1,2)
%         
%         fprintf('completed block: %d %d of %d %d \n',ii,jj,size(im1,1),size(im1,2));
%         
%         startx = jj;
%         stopx = min(jj+bsize,size(im1,2));
%         starty = ii;
%         stopy = min(ii+bsize,size(im1,1));
%         
%         patch = double(im1(starty:stopy,startx:stopx,:));
%         
%         C = normxcorr2(rgb2gray(uint8(patch)),rgb2gray(uint8(im2)));
%         
%         C1 = normxcorr2(double(patch(:,:,1)),double(im2(:,:,1)));
%         C2 = normxcorr2(double(patch(:,:,2)),double(im2(:,:,3)));
%         C3 = normxcorr2(double(patch(:,:,2)),double(im2(:,:,3)));
%         C = C1+C2+C3;
%         
%         [dummy, idx] = max(C(:));
%         [y,x,c] = ind2sub(size(C),idx);
%         d(starty:stopy, startx:stopx)= [(startx+stopx)/2 - x];
%         
% %         
% %         match = [];
% %         for kk = 1:size(im1,2)-bsize-1
% %             other = double(im2(starty:stopy,kk:kk+stopx - startx,:));
% %             diff = patch - other;
% %             match(kk) = sum(abs(diff(:)));
% %         end
% %         
%         
% %         
% %         
% %         
% %         [dummy, x] = max(match);
% %         %[y,x,c] = ind2sub(size(C),idx);
% %         
% %         d(starty:stopy, startx:stopx)= [(startx+stopx)/2 - x];
%         
%     end
% end
% 
% 
% 
% % 
% % 
% % 
% % 
% % for ii = 1:h
% %     row = double(im2(ii,:,:));
% %     row = permute(row,[3,2,1]);
% %    for jj = 1:bsize:w
% %        start = jj;
% %        stop = min(jj+bsize, w);
% %        patch = double(im1(ii,start:stop,:));
% %        patch = permute(patch,[3, 2, 1]);
% %        %patch = -patch;
% %        
% %        match = [];
% %        for kk = 1:(size(row,2)-size(patch,2))
% %            match(kk) = sum(sum(abs(row(:,kk:kk+size(patch,2)-1) - patch),1));
% %        end
% %        [dummy,idx] = min(sum(match,1));
% %        d(ii,start:stop) = idx - start;
% %        
% %    end
% % end
% 
% figure;imagesc(d); caxis([0,20])
% figure; imagesc(im2)
% 
