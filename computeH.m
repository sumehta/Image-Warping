function H = computeH(t1, t2)
% t1, t2 = 2xN matrices

% t1 = [x1 x2 x3 x4
%       y1 y2 y3 y4]
% t2 = [
% H = [h1' ; h2' ; h3']
% h1 = [a,b,c]
% h2 = [d,e,f]
% h3 = [g,h,i]

%convert t1 to homogenous coordinates by adding a row of ones
[~, n] = size(t1);
t = [t1; 100*ones(1,n)];
s = [t2 ; 100*ones(1,n)];

maxt1 = max(max(t));
%t = t/maxt1;
maxt2 = max(max(s));
%s = s/maxt2;

L = zeros(2*n, 9);

indx= 1;
for i = 1:n
    L(i, :) = [t(:,indx)' zeros(1,3) t(:,indx)'.*(-1*s(1,indx))];
    indx = indx+1;
end
indx = 1;
for i = n+1:2*n
    L(i, :) = [zeros(1,3) t(:,indx)' t(:,indx)'.*(-1*s(2,indx))];
    indx = indx+1;
end
% indx = 1;
% for i = 1:2:2*n-1
%     L(i,:) = [t(:,indx)' zeros(1,3) t(:,indx)'*(-1*s(1,indx))];
%     L(i+1,:) = [zeros(1,3) t(:,indx)' t(:,indx)'*(-1*s(2,indx))];
%     indx = indx + 1;
% end
m = L'*L;
% V = eigen vectors, D = diagonal matrix containing eigen vectors
[V,D] = eig(m);
% j contains the position of the largest eigen value
[~,j] = min(min(D));
% H = eigen vector corresponding to largest eigen value
H = V(:,j);
H = reshape(H,3,3)';


% imshow(im2);
% hold on
% plot(t2computed(1,1),t2computed(2,1),'r.','MarkerSize',20);
% hold on
% plot(t2computed(1,2),t2computed(2,2),'r.','MarkerSize',20);
% hold on
% plot(t2computed(1,3),t2computed(2,3),'r.','MarkerSize',20);
% hold on
% plot(t2computed(1,4),t2computed(2,4),'r.','MarkerSize',20);
% hold off

