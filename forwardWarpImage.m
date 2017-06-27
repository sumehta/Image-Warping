function [warpIm,mergeIm] = warpImage(inputIm, refIm, H)


X1 = 1:size(inputIm, 2);
Y1 = 1:size(inputIm, 1);

X2 = 1:size(refIm, 2);
Y2 = 1:size(refIm, 1);

sizet1 = size(X1,2)*size(Y1,2);
sizet2 = size(X2,2)*size(Y2,2);

t1 = zeros(2, sizet1);

% index input image and store in t1
index = 1;
for i = 1:size(X1,2)
    for j = 1:size(Y1,2)
        t1(1,index) = i;
        t1(2,index) = j;
        index = index + 1;
    end
end


t1 = [t1; 100*ones(1,sizet1)];

t2 = H*t1;
t2 = t2./repmat(t2(3,:),[3,1]);
% t2=t2*max(max(t1));
t2 = uint16(t2);

mergeIm = refIm;
for i=1:size(t2,2);
    if t2(1,i) ~= 0 && t2(2,i)~=0
        warpIm(t2(2,i),t2(1,i),:) = inputIm(t1(2,i),t1(1,i),:);
%         mergeIm(t2(2,i),t2(1,i),:) = inputIm(t1(2,i),t1(1,i),:);
    end
end
figure;
imshow(warpIm);


% figure;
% imshow(mergeIm);
end

