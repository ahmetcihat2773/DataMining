%%
%Part a ) 
%% Plot the data.
clear all;
close all;
clc;
data = load('dataSimilarityExample.mat');
x = data.X;
x_clusters = data.idxCluster;
row_num = size(x_clusters,1);
diagonal_matrix = diag(ones(1,row_num));
% Use diagonal_matrix in distance matrix.
figure()
scatter(x(:,1),x(:,2),30,x_clusters);
title("DATA WITH CLUSTERS 3-A")

%% 2)
% Calculate distance matrix by applying euclidean distance formula. 
D = pdist(x,'euclidean');
D_sq= squareform(D);
figure()
imagesc(D_sq);
title("DISTANCE MATRIX 3-A");
%% 3)
% Order the data according to the clusters.
figure()
tempdata = [x,x_clusters];
tempdata_sorted = sortrows(tempdata,3);
x_ordered = zeros(size(x));
x_ordered = tempdata_sorted(:,1:2);
% Calculate the distance matrix again. 
D_ordered = pdist(x_ordered,'euclidean');
D_ordered_sq = squareform(D_ordered);
imagesc(D_ordered_sq);
title("ORDERED DISTANCE MATRIX 3-A");
% Three clusters. First 1 then 2 and then 3 is ordered and in the distance
% matrix cluster1 has lower distance to cluster1 thats why we can see blue
% area on the left corner.
% pdist : calculates the distance between one data pair to all data pairs
% in the dataset. So method repeat same procedure for all of the pair.
%%
% Part b)
% Calculate similarity matrix by using distance matrix. We will use
% exponential function to calculate the similarity matrix.

% Select sigma
smallest_sigma = min(min(D_sq))+0.0001;
middle_sigma = mean(mean(D_sq));
biggest_sigma = max(max(D_sq));

% NOT ORDERED
d_exp_smallest_sigma = exp(-D_sq/smallest_sigma)-diagonal_matrix;
d_exp_middle_sigma = exp(-D_sq/middle_sigma)-diagonal_matrix;
d_exp_biggest_sigma = exp(-D_sq/biggest_sigma)-diagonal_matrix;

figure()
imagesc(d_exp_smallest_sigma);
title("sigma = "+string(smallest_sigma)+" 3-B");

figure()
imagesc(d_exp_middle_sigma);
title("sigma = "+string(middle_sigma)+" 3-B");

figure()
imagesc(d_exp_biggest_sigma);
title("sigma = "+string(biggest_sigma)+" 3-B");

% % S^{d,\sigma,exp}_{i,j} = e^{-d(x_i,x_j)/\sigma }

% ORDERED

d_exp_smallest_sigma_ordered = exp(-D_ordered_sq/smallest_sigma)-diagonal_matrix;
d_exp_middle_sigma_ordered = exp(-D_ordered_sq/middle_sigma)-diagonal_matrix;
d_exp_biggest_sigma_ordered = exp(-D_ordered_sq/biggest_sigma)-diagonal_matrix;



figure()
imagesc(d_exp_smallest_sigma_ordered);
title("sigma ordered = "+string(smallest_sigma)+" 3-B");

figure()
imagesc(d_exp_middle_sigma_ordered);
title("sigma ordered = "+string(middle_sigma)+ "3-B");

figure()
imagesc(d_exp_biggest_sigma_ordered);
title("sigma ordered = "+string(biggest_sigma)+" 3-B");

% When we increase the sigma values changes more or less linearly so that
% clusters can be distinguished. If sigma goes to infinity then
% exponential function goes to 1 which means all the nodes will be
% connected. 


