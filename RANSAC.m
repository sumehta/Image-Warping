%RANSAC
% The input to the algorithm is:
% n - the number of random points to pick every iteration in order to create the transform.
% k - the number of iterations to run
% t - the threshold for the square distance for a point to be considered as a match
% d - the number of points that need to be matched for the transform to be valid
n = 5;
k = 20;
t = 100000;
d = 4;

I1 = rgb2gray(imread('2.jpg'));
I2 = rgb2gray(imread('3.jpg'));

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);

indexPairs = matchFeatures(f1, f2);

matchedPoints1 = vpts1(indexPairs(:, 1), :);
matchedPoints2 = vpts2(indexPairs(:, 2), :);
% 
% [tform, matchedPoints1, matchedPoints] = ...
%     estimateGeometricTransform(matchedPoints1, matchedPoints2, 'affine');
 
best_error = Inf;
for i = 0:k
  rand_indices = randi(matchedPoints1.length, n, 1);
  base_points = matchedPoints1.Location(rand_indices', :);
  input_points = matchedPoints2.Location(rand_indices',:);
  maybe_model = computeH(input_points', base_points');

  inliers = 0;
  total_error = 0;
  for j = 1 : uint16(matchedPoints1.length)
    error = sum(sum((maybe_model*[matchedPoints1.Location(j,:)';100] - [matchedPoints2.Location(j,:)';100]).* ...
    (maybe_model*[matchedPoints1.Location(j,:)';100] - [matchedPoints2.Location(j,:)';100])));
    if error < t
      inliers = inliers + 1;
      total_error = total_error + error;
    end
  end

  if inliers > d && total_error < best_error
    best_model = maybe_model;
    best_error = total_error;
  end
end

    

    