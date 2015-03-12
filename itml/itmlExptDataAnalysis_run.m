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
global FileName;

% Get All Data Files
FileNames        = dir('data/itml-expts/');
ValidFileNames   = [];
for i = 1:length(FileNames)
   % Assume All .mat Files Are Valid
   if regexp(FileNames(i).name, '.mat')
      ValidFileNames   = [ValidFileNames; {FileNames(i).name}]; 
	else
		disp(['   TSA:: ', FileNames(i).name, ' is not a data file, moving on...']);
   end
end
FileNames       = ValidFileNames;
NumOfFiles      = length(FileNames);

% Initialise
ClassOccurMat   = zeros(20, NumOfFiles);
ClassCountMat   = zeros(20, NumOfFiles);
MisclassMat_Itml    = zeros(20, 20, NumOfFiles);
MisclassMat_Eucl    = zeros(20, 20, NumOfFiles);
CorrclassMat_Itml   = zeros(20, NumOfFiles);
CorrclassMat_Eucl   = zeros(20, NumOfFiles);
ErrorRates_Itml     = zeros(NumOfFiles, 1);
ErrorRates_Eucl     = zeros(NumOfFiles, 1);

for f = 1:NumOfFiles
   fFileName   = FileNames{f};
   disp(['   Processing: ', fFileName, ' ...']);
   % Set Global FileName For Parameter A
   FileName   = fFileName;
   load(fFileName);
   % Update Method Independent Stats
   fClassOccurs                               = unique(Y_Test);
   ClassOccurMat(fClassOccurs, f)             = 1;
   fClassCounts                               = accumarray(Y_Test, 1);
   ClassCountMat(1:length(fClassCounts), f)   = fClassCounts;
   % -------------------------------------------------------------------------
   % Do K-Means Clustering Experiments
   % -------------------------------------------------------------------------
   % Model Specification Clusters
   ClusterModel_Itml = ClassificationKNN.fit(X_Train, Y_Train, 'NSMethod', 'exhaustive', 'Distance', @ItmlDist);
   ClusterModel_Eucl = ClassificationKNN.fit(X_Train, Y_Train, 'NSMethod', 'exhaustive', 'Distance', 'Euclidean');
   % Testing for Nearest Neighbours
   Y_Hat_Itml         = predict(ClusterModel_Itml, X_Test);
   Y_Hat_Eucl         = predict(ClusterModel_Eucl, X_Test);
   RightLabels_Itml   = Y_Test(Y_Hat_Itml~=Y_Test);       % Correct Labels of ITML Misclassified
   WrongLabels_Itml   = Y_Hat_Itml(Y_Hat_Itml~=Y_Test);   % Wrong Assigned Labels of ITML Misclassified
   RightLabels_Eucl   = Y_Test(Y_Hat_Eucl~=Y_Test);       % Correct Labels of Euclidean Misclassified
   WrongLabels_Eucl   = Y_Hat_Eucl(Y_Hat_Eucl~=Y_Test);   % Wrong Assigned Labels of Euclidean Misclassified
   % Update Counts
   for i = 1:length(RightLabels_Itml)
      MisclassMat_Itml(RightLabels_Itml(i),WrongLabels_Itml(i), f)...
         = MisclassMat_Itml(RightLabels_Itml(i),WrongLabels_Itml(i), f) + 1;
   end
   for i = 1:length(RightLabels_Eucl)
      MisclassMat_Eucl(RightLabels_Eucl(i),WrongLabels_Eucl(i), f)...
         = MisclassMat_Eucl(RightLabels_Eucl(i),WrongLabels_Eucl(i), f) + 1;
   end
   % Correct Classification Count
   CorrclassMat_Itml(:, f)   = ClassCountMat(:,f) - sum(MisclassMat_Itml(:,:,f), 2);
   CorrclassMat_Eucl(:, f)   = ClassCountMat(:,f) - sum(MisclassMat_Eucl(:,:,f), 2);
   % Error Rates
   ErrorRates_Eucl(f)   = sum(Y_Hat_Eucl~=Y_Test)/ length(Y_Hat_Eucl);
   ErrorRates_Itml(f)   = sum(Y_Hat_Itml~=Y_Test)/ length(Y_Hat_Itml);
   disp(['     Euclidean KNN : ',num2str(ErrorRates_Eucl(f)*100)]);
   disp(['     ITML KNN      : ',num2str(ErrorRates_Itml(f)*100)]);
  end
ItmlWorseThanEucl   = ErrorRates_Eucl < ErrorRates_Itml;
ItmlWorseData       = FileNames(ItmlWorseThanEucl);

save('ITMLDataAnalysis.mat', 'ClassOccurMat','ClassCountMat','MisclassMat_Itml',...
     'MisclassMat_Eucl', 'CorrclassMat_Itml', 'CorrclassMat_Eucl', 'ErrorRates_Itml',...
     'ErrorRates_Eucl', 'ItmlWorseThanEucl', 'ItmlWorseData');
