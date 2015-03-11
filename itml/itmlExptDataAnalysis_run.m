% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Table Similarities
% File Name  : itmlExptDataAnalysis_run.m
% Syntax     : 
% Description: To analyse why in some cases ITML fails over Euclidean KNN
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;
SAFEFLAG   = false;

% Get All Data Files
Filenames   = dir('data/itml-expts/');
NumOfFiles  = length(Filenames);

for f = 1:NumOfFiles
	% Assume All .mat Files Are Valid
	if regexp(Filenames(f).name, '.mat')
		disp(['   Processing: ', Filenames(f).name, ' ...']);
	else
		disp('   TSA:: Not a data file, moving on...')
	end
end
