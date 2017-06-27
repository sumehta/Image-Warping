I1 = rgb2gray(imread('2.jpg'));

I2 = rgb2gray(imread('3.jpg'));

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);
indexPairs = matchFeatures(f1, f2);


matchedPoints1 = vpts1(indexPairs(:, 1), :);
matchedPoints2 = vpts2(indexPairs(:, 2), :);

[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedPoints1, matchedPoints2, 'affine');

figure();
imshow(I1); hold on;
plot(inlierBoxPoints);

figure();
imshow(I2); hold on;
plot(inlierScenePoints);

% figure;
% showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
%     matchedScenePoints, 'montage');
% title('Putatively Matched Points (Including Outliers)');
% 
% hold on;
% plot(selectStrongest(scenePoints, 300));
% [tform, inlierBoxPoints, inlierScenePoints] = ...
%     estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');
% figure;
% showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, ...
%     inlierScenePoints, 'montage');
% title('Matched Points (Inliers Only)');