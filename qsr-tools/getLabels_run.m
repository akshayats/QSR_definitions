% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Similarities
% File Name  : getLabels_run.m
% Syntax     : 
% Description: This is a script to run the GetAllScenesLabels.m and Save
%			   Results
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% Load Data
load('CleanData.mat');

% Extract Labels and Save
[Labels, ClassLabels, ClassLabelsMap]   = GetAllScenesLabels(InJsonData);