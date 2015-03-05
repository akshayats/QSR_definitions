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
load('data/ITMLData_2.mat')
% -------------------------------------------------------------------------
% Do K-Means Clustering Experiments
% -------------------------------------------------------------------------
% Training Clusters

% ClusterModel = ClassificationKNN.fit(X_Train, Y_Train, 'NSMethod', 'exhaustive', 'Distance', @ItmlDist);
ClusterModel = ClassificationKNN.fit(X_Train, Y_Train, 'NSMethod', 'exhaustive', 'Distance', 'Euclidean');

% Testing Clusters
Y_Hat   = predict(ClusterModel, X_Test);

% Error
find(Y_Hat~=Y_Test)
ErrorPercent   = sum(Y_Hat~=Y_Test);