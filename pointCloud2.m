%% display point cloud:

load('disparity.mat');


[X,Y] = meshgrid([1:size(im,2)],[1:size(im,1)]);
u = X/size(im,2);
v = Y/size(im,1);




factor = .1;
X = imresize(X,factor);
Y = imresize(Y,factor);
u = imresize(u,factor);
v = imresize(v,factor);
disp(disp<0)=0;
disp = imresize(disp,factor);

vnumber = 1:length(X(:));
vnumber = reshape(vnumber,[size(X,1),size(X,2)]);


tri = manualD(vnumber);



u = u(:);
v = v(:);
%Y = Y - size(im,1)/2;
%Y = -Y;
Y = Y/(size(im,1));

X = X/size(im,2);

theta = Y*180*pi/180;
theta = theta(:);
phi = X*360*pi/180;
phi = phi(:);

%disp(disp<0)=max(disp(:));
mindist = 20;
dynamicrange = 200;
superfar = 400;
disp = disp/(max(disp(:))-min(disp(:)));
R = mindist + dynamicrange*(1-disp);
R(disp==0)=superfar;
R(1:floor(size(R,1)*.2),:)=superfar;


R = R.^2;
R = R/max(R(:));


fudge_height = max(max(R(disp~=0)));
fudge_height = fudge_height*.9;

%R= atan(R);
R = R(:);



r = double(imresize(im(:,:,1),factor));
r = r(:)/256;
g = double(imresize(im(:,:,2),factor));
g = g(:)/256;
b = double(imresize(im(:,:,3),factor));
b = b(:)/256;



x = R.*cos(phi);
y = R.*sin(phi);
z = -fudge_height*Y(:);

% x = R.*sin(theta).*cos(phi);
% y = R.*sin(theta).*sin(phi);
% z = R.*cos(theta);



fix = randperm(size(x,1));
pix = fix(1:1000);



figure;
scatter3( x(pix),y(pix),z(pix),1,[r(pix),g(pix),b(pix)]);


%pause;
dix = fix(length(pix)+1:end);

hold on;
scatter3(x(dix),y(dix),z(dix),1,[r(dix),g(dix),b(dix)]);

axis equal;



%%
%write image!
fprintf('writing image \n');
imwrite(im,'cool.png');




%% make and write mesh:

triList = tri;
tri = zeros(length(triList),3);
for ii = 1:length(triList)
   tri(ii,:) = triList{ii}; 
end


figure;
trisurf(tri,x,y,z);


fprintf('writing ply file\n');
fid = fopen('cool3.ply','w');
fprintf(fid,'ply\n');
fprintf(fid,'format ascii 1.0\n');
fprintf(fid,'element vertex %d\n', length(x));
fprintf(fid,'property float32 x\n');
fprintf(fid,'property float32 y\n');
fprintf(fid,'property float32 z\n');
fprintf(fid,'property float32 s \n');
fprintf(fid,'property float32 t \n');
fprintf(fid,'element face %d\n', size(tri,1));
fprintf(fid,'property list uint8 int32 vertex_index\n');
fprintf(fid,'end_header\n');

for ii = 1:length(x)
   %fprintf(fid,'%f %f %f %f %f \n',double(x(pix(ii))),double(y(pix(ii))),double(z(pix(ii))),double(u(pix(ii))),double(v(pix(ii))));     
   fprintf(fid,'%f %f %f %f %f\n',double(x(ii)),double(y(ii)),double(z(ii)),double(u(ii)),1-double(v(ii)));
   %fprintf(fid,'%f %f %f\n',double(x(ii)),double(y(ii)),double(z(ii)));     

end

for ii = 1:size(tri,1)
   fprintf(fid,'3 %d %d %d\n',tri(ii,1)-1,tri(ii,2)-1, tri(ii,3)-1); 
end

fclose(fid);

fprintf('finished! \n');
% 
% 
% %%  write point cloud
% 
% fid = fopen('cool.ply','w');
% 
% fprintf(fid,'ply \n');
% fprintf(fid,'format ascii 1.0 \n');
% fprintf(fid,'element vertex 100000 \n');
% fprintf(fid,'property float x \n');
% fprintf(fid,'property float y \n');
% fprintf(fid,'property float z \n');
% fprintf(fid,'property float uchar diffuse_red \n');
% fprintf(fid,'property float uchar diffuse_green \n');
% fprintf(fid,'property float uchar diffuse_blue \n');
% fprintf(fid,'end_header \n');
% 
% 
% 
% for ii = 1:size(x,1)
%    
%     fprintf(fid,'%f %f %f %d %d %d \n',x(fix(ii)),y(fix(ii)),z(fix(ii)),uint8(r(fix(ii))*256),uint8(g(fix(ii))*256),uint8(b(fix(ii))*256));
%     if(mod(ii,100)==0)
%         fprintf('finished: %d of %d \n',ii,size(x,1))
%     end
% end
% 
% fclose(fid);
% 
% 
