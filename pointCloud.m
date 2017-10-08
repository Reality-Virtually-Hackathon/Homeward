%% display point cloud:

load('disparity.mat');


[X,Y] = meshgrid([1:size(im,2)],[1:size(im,1)]);
u = X/size(im,2);
v = Y/size(im,1);
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

disp(disp<0)=max(disp(:));
R = 60 + 1*(max(disp(:))-disp);
%R= atan(R);
R = R(:);

r = double(im(:,:,1));
r = r(:)/256;
g = double(im(:,:,2));
g = g(:)/256;
b = double(im(:,:,3));
b = b(:)/256;



x = R.*cos(phi);
y = R.*sin(phi);
z = -50*Y(:);

% x = R.*sin(theta).*cos(phi);
% y = R.*sin(theta).*sin(phi);
% z = R.*cos(theta);



fix = randperm(size(x,1));
pix = fix(1:100000);


% 
% figure;
% scatter3( x(pix),y(pix),z(pix),1,[r(pix),g(pix),b(pix)]);
% 
% 
% pause;
% dix = fix(length(pix)+1:end);
% 
% hold on;
% scatter3(x(dix),y(dix),z(dix),1,[r(dix),g(dix),b(dix)]);

%%
p = [x(pix), y(pix), z(pix)];
p = double(p);

cd MyCrustOpen070909
[t]=MyCrustOpen(p);

figure
subplot(1,2,2)
hold on
title('Output Triangulation','fontsize',14)
axis equal
trisurf(t,p(:,1),p(:,2),p(:,3),'facecolor','c','edgecolor','b')%plot della superficie
axis vis3d
view(3)

cd ..


%% crazy mesh










%% make and write mesh:


tic;
tri = delaunay(double(x(pix)),double(y(pix)),double(z(pix)));
toc

fid = fopen('cool2.ply','w');
fprintf(fid,'ply\n');
fprintf(fid,'ascii 1.0\n');
fprintf(fid,'element vertex %d\n', length(pix));
fprintf(fid,'property float32 x\n');
fprintf(fid,'property float32 y\n');
fprintf(fid,'property float32 z\n');
%fprintf(fid,'property float32 u \n');
%fprintf(fid,'property float32 v \n');
fprintf(fid,'element face %d\n', size(tri,1));
fprintf(fid,'property list uint8 int32 vertex_index\n');
fprintf(fid,'end_header\n');

for ii = 1:length(pix)
   %fprintf(fid,'%f %f %f %f %f \n',double(x(pix(ii))),double(y(pix(ii))),double(z(pix(ii))),double(u(pix(ii))),double(v(pix(ii))));     
   fprintf(fid,'%f %f %f\n',double(x(pix(ii))),double(y(pix(ii))),double(z(pix(ii))));     

end

for ii = 1:size(tri,1)
   fprintf(fid,'3 %d %d %d\n',tri(ii,1)-1,tri(ii,2)-1, tri(ii,3)-1); 
end

fclose(fid);



%%  write point cloud

fid = fopen('cool.ply','w');

fprintf(fid,'ply \n');
fprintf(fid,'format ascii 1.0 \n');
fprintf(fid,'element vertex 100000 \n');
fprintf(fid,'property float x \n');
fprintf(fid,'property float y \n');
fprintf(fid,'property float z \n');
fprintf(fid,'property float uchar diffuse_red \n');
fprintf(fid,'property float uchar diffuse_green \n');
fprintf(fid,'property float uchar diffuse_blue \n');
fprintf(fid,'end_header \n');



for ii = 1:size(x,1)
   
    fprintf(fid,'%f %f %f %d %d %d \n',x(fix(ii)),y(fix(ii)),z(fix(ii)),uint8(r(fix(ii))*256),uint8(g(fix(ii))*256),uint8(b(fix(ii))*256));
    if(mod(ii,100)==0)
        fprintf('finished: %d of %d \n',ii,size(x,1))
    end
end

fclose(fid);


