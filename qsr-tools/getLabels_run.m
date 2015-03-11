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
% load('CleanData.mat');
load('CleanData_Set1Objects.mat');

% Extract Labels and Save
% OutputFileName   = 'data/CleanData_SceneLabels.mat';
OutputFileName   = 'data/CleanData_Set1Objects_SceneLabels.mat';
[Labels, ClassLabels, ClassLabelsMap]   = GetAllScenesLabels(InJsonData, OutputFileName);