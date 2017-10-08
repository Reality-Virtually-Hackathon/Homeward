function [triList] = manualD(v)

%     load('disparity.mat');
% 
% 
%     [X,Y] = meshgrid([1:size(im,2)],[1:size(im,1)]);
%     u = X/size(im,2);
%     v = Y/size(im,1);
% 
% 
% 
% 
%     factor = .1;
%     X = imresize(X,factor);
%     Y = imresize(Y,factor);
%     u = imresize(u,factor);
%     v = imresize(v,factor);
%     %disp = imresize(disp,factor);
% 
%     vnumber = 1:length(X(:));
%     vnumber = reshape(vnumber,[size(X,1),size(X,2)]);
% 
%     v = vnumber;


    numVertex = size(v,1)*size(v,2);
    vertexlist = [];
    uvList = [];
    triList = {};
    
    idxImage = -1*ones(size(v));
    vCount = 0;
    
    for jj = 1:(size(v,2)-1)
        fprintf('finished all columns of %d of %d \n',jj,size(v,2));
        for ii = 1:(size(v,1)-1)
            
            x = jj;
            y = ii;
            
            tl = -1;
            tr = -1;
            bl = -1;
            br = -1;
            testX = -1;
            testY = -1;
            
            testX = jj;
            testY = ii;
            
            if(idxImage(testY,testX) == -1)
                %vertexList(vcount,:) = [textX/size(v,2),
                idxImage(testY,testX) = sub2ind(size(v),testY,testX);
                vCount;
                vCount = vCount+1;
            end
            tl = idxImage(testY,testX);
            
            testX = x+1;
            testY = y;            
            if(idxImage(testY,testX) == -1)
                %vertexList(vcount,:) = [textX/size(v,2),
                idxImage(testY,testX)  = sub2ind(size(v),testY,testX);
                vCount = vCount+1;
            end
            tr = idxImage(testY, testX);
            
            testX = x;
            testY = y+1;            
            if(idxImage(testY,testX) == -1)
                %vertexList(vcount,:) = [textX/size(v,2),
                idxImage(testY,testX)  = sub2ind(size(v),testY,testX);
                vCount = vCount+1;
            end
            bl = idxImage(testY, testX);
            
            testX = x+1;
            testY = y+1;            
            if(idxImage(testY,testX) == -1)
                %vertexList(vcount,:) = [textX/size(v,2),
                idxImage(testY,testX)  = sub2ind(size(v),testY,testX);
                vCount = vCount+1;
            end
            br = idxImage(testY, testX);
            
            
            
            triList{end+1} = [bl,br,tl];
            triList{end+1} = [tl,br,bl];
            triList{end+1} = [tr,br,tl];
            triList{end+1} = [tl,br,tr];           
            
        end
    end
    
    
    
    %
%     tri = zeros(length(triList),3);
%     for ii = 1:length(triList)
%        tri(ii,:) = triList{ii}; 
%     end
%     
%     [X,Y] = meshgrid(1:size(v,2),1:size(v,1));
%     
%     figure;
%     trisurf(tri,X(:),Y(:),sin(.01*X(:) + .01*Y(:)));
%     %shading flat
%     
    
        




end

%%

% figure;
% set = randperm(size(triList,1));
% set = set(1:100);
% hold on;
% for ii = 1:length(set)
%     idx = set(ii);
%     
%     [y1,x1] = ind2sub(size(v),triList(idx,1));
%     [y2,x2] = ind2sub(size(v),triList(idx,2));
%     [y3,x3] = ind2sub(size(v),triList(idx,3));
% 
%     plot([x1,x2],[y1,y2],'b.-');
%     plot([x1,x3],[y1,y3],'b.-');
%     plot([x2,x3],[y2,y3],'b.-');
%     text(x1,y1,num2str(triList(idx,1)));
%     text(x2,y2,num2str(triList(idx,2)));
%     text(x3,y3,num2str(triList(idx,3)));
%     
% end
% 

