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


load('data/ITMLData_3_13ob_10c.mat')
C1   = ChosenClasses;
load('data/ITMLData_4_13ob_10c.mat')
C2   = ChosenClasses;
load('data/ITMLData_3_13ob2_10c.mat')
C3   = ChosenClasses;
load('data/ITMLData_4_13ob2_10c.mat')
C4   = ChosenClasses;
load('data/ITMLData_5_13ob2_10c.mat')
C5   = ChosenClasses;

C = [C1, C2, C3, C4, C5]

C = C(:,randperm(5));

CommonClasses   = intersect(C(:,1), C(:,2))

for i = 3:5
	CommonClasses   = intersect(CommonClasses, C(:,i))
end