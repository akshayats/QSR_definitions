% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Table Similarities
% File Name  : 
% Syntax     : 
% Description: This script is written to formulate the data folds for the
%				measure training and the test set for the k-means
%				clustering.
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

% Parameters
NumOfData    = 5;
TrainSplit   = 0.65;
WhichQSRs    = [5]; % [B F L R N] = [1 2 3 4 5] Include Indxs You Want
NumOfClasses   = 8;

save('runParams.mat')

% Make Data
for n = 1:NumOfData
	
	% -------------------------------------------------------------------------
	% Data Processing
	% -------------------------------------------------------------------------
	disp('   Loading QSR and Scenes Data');
	
	% Load and Reshape QSR Data
	load('CleanData_QSR_Nrml');
	load('CleanData_SceneLabels');
	% Pick 3 People Classes at Random and X and Y
	ClassIndxs      = randperm(length(ClassLabelsMap.person), NumOfClasses);
% 	ClassIndxs      = [6, 19, 16];
	ChosenClasses   = ClassLabelsMap.person(ClassIndxs);
	X_All           = ReshapeData(QSRNrmlData, WhichQSRs);
	DataSelectIndxs   = zeros(length(ClassLabels.person),1);
	for s = 1:NumOfClasses
		DataSelectIndxs   = ClassLabels.person == ClassIndxs(s) |DataSelectIndxs;
	end
	% Data Chosen For This Experiment's Data Split
	X_Chosen        = X_All(DataSelectIndxs, :);
	Y_Chosen        = ClassLabels.person(DataSelectIndxs, :);
						 
	% Make Training & Test Data
	disp('   Classes Chosen');
	disp(ChosenClasses);
	disp('   Making Training and Test Data Splits');
	ChosenDataIndxs   = randperm(length(Y_Chosen)); % Randomise
	NumOfTrainData    = ceil(TrainSplit*length(Y_Chosen)); % Splitting Data
	
	X_Train   = X_Chosen(ChosenDataIndxs(1:NumOfTrainData), :);
	Y_Train   = Y_Chosen(ChosenDataIndxs(1:NumOfTrainData), :);
	X_Test    = X_Chosen(ChosenDataIndxs(NumOfTrainData+1:end), :);
	Y_Test    = Y_Chosen(ChosenDataIndxs(NumOfTrainData+1:end), :);
	% -------------------------------------------------------------------------
	% Find Distance Metric
	% -------------------------------------------------------------------------
	disp('   Running ITML ...');
	% Parameters
	num_folds         = 2;
	knn_neighbor_size = 4;
	params.max_iters   = 100000;
	A = MetricLearningAutotuneKnn(@ItmlAlg, Y_Train, X_Train, params); % ITML Matrix
	% disp(sprintf('kNN cross-validated accuracy = %f', acc));
	disp('   Training Done.')
	% -------------------------------------------------------------------------
	% Saving Files
	% -------------------------------------------------------------------------
	SaveFileName   = ['data/ITMLData_',num2str(n), '_8c'];
	save(SaveFileName, 'X_Test', 'Y_Test', 'X_Train', 'Y_Train', 'ChosenClasses', 'ClassIndxs', 'A');
	


end

delete runParams.mat