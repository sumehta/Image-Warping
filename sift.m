% I = vl_impattern('roofs1') 
% image(I) ;
% I = single(rgb2gray(I)) ;
% [f,d] = vl_sift(I) ;
% 
% %detectors
% perm = randperm(size(f,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(f(:,sel)) ;
% h2 = vl_plotframe(f(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% 
% %descriptors
% h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
% set(h3,'color','g') ;

Ia = imread('crop1.jpg');
Ia = single(rgb2gray(Ia)) ;

Ib = imread('crop2.jpg');
Ib = single(rgb2gray(Ib)) ;

[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ;


for i=1:size(matches,2)
    feat1 = fa(:,matches(1,i));
    t1(1,i) = round(feat1(1,1));
    t1(2,i) = round(feat1(2,1));
    
    feat2 = fb(:,matches(2,i));
    t2(1,i) = round(feat2(1,1));
    t2(2,i) = round(feat2(2,1));
end
t1
t2
% %detectors
% perm = randperm(size(fa,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(fa(:,sel)) ;
% h2 = vl_plotframe(fb(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% 
% %descriptors
% h3 = vl_plotsiftdescriptor(da(:,sel),fa(:,sel)) ;
% set(h3,'color','g') ;

