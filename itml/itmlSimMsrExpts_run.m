% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Table Similarities
% File Name  : itmlSimMsrExpts_run.m
% Syntax     : Run the script - F5
% Description: This is a script to run many experiments on the k-means
%			   clustering based on the ITML learned similarity measure.
%              
% Author     : Akshaya Thippur
% Last Edited: 05 March 2015
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all; close all; clc;

% -------------------------------------------------------------------------
% Data Processing
% -------------------------------------------------------------------------
% load('data/ITMLData_2.mat')
load('data/ITMLData_5_8c.mat')
% -------------------------------------------------------------------------
% Do K-Means Clustering Experiments
% -------------------------------------------------------------------------
% Training Clusters

ClusterModel_Itml = ClassificationKNN.fit(X_Train, Y_Train, 'NSMethod', 'exhaustive', 'Distance', @ItmlDist);
ClusterModel_Knn = ClassificationKNN.fit(X_Train, Y_Train, 'NSMethod', 'exhaustive', 'Distance', 'Euclidean');

% Testing Clusters
Y_Hat_Itml   = predict(ClusterModel_Itml, X_Test);
Y_Hat_Knn   = predict(ClusterModel_Knn, X_Test);

% Error
find(Y_Hat_Knn~=Y_Test);
ErrorPercent_Knn   = sum(Y_Hat_Knn~=Y_Test)/ length(Y_Hat_Knn);
disp(ErrorPercent_Knn*100);


find(Y_Hat_Itml~=Y_Test);
ErrorPercent_Itml   = sum(Y_Hat_Itml~=Y_Test)/ length(Y_Hat_Itml);
disp(ErrorPercent_Itml*100);