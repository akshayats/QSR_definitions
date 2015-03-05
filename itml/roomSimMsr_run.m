clear all; close all; clc;


disp('Loading QSR and Scenes Data');
% Load and Reshape QSR Data
load('CleanData_QSR_Nrml');
load('CleanData_SceneLabels');
% Reshape Data
OutData = ReshapeData(QSRNrmlData,5);
% Pick Out Data From 2 People
X   = OutData(ClassLabels.person == 6, :); % Francisco
y   = ones(numel(find(ClassLabels.person == 6)), 1) * 6;
X   = [X;OutData(ClassLabels.person == 19, :)]; % Yasemin
y   = [y;ones(numel(find(ClassLabels.person == 19)), 1) * 19];
X   = [X;OutData(ClassLabels.person == 16, :)]; % Puren
y   = [y;ones(numel(find(ClassLabels.person == 16)), 1) * 16];

% ITML Part
disp('Running ITML');
num_folds = 2;
knn_neighbor_size = 4;
% acc = CrossValidateKNN(y, X, @(y,X) MetricLearningAutotuneKnn(@ItmlAlg, y, X), num_folds, knn_neighbor_size);
A = MetricLearningAutotuneKnn(@ItmlAlg, y, X);

% disp(sprintf('kNN cross-validated accuracy = %f', acc));

disp('DONE!!!')
%%
% load FirstTry
% a = X(4,:);
% b = X(43,:);

aMat    = repmat(X, [1,1,size(X,1)]); % r = Data Points, c = Data Dims, p = Copies
bSeed   = reshape(X', [1,size(X,2),size(X,1)]);
bMat    = repmat(bSeed, [size(X,1),1,1]); % r = Copies, c = Data Dims, p = Data Points

DiffMat   = aMat - bMat;
[r, c, p]   = size(DiffMat);
DistMat   = cellfun(@(x) diag(x*A*x'), mat2cell(DiffMat, r, c, ones(1,p)), 'UniformOutput', false);
DistMat   = cat(3, DistMat{:});
HistMat   = DistMat(:,1,1:26);
hist(HistMat(:),30);

% S = (a-b)*A*(a-b)'

return;

%% Trial of KNN Classifier
clear all;
X   = rand(50, 2);
Y   = ones(50, 1);
X   = [X;rand(50, 2)+5];
Y   = [Y;zeros(50, 1)];
mdl = ClassificationKNN.fit(X,Y, 'NSMethod', 'exhaustive');

xNov   = rand(5, 2) + 4;
yNov   = predict(mdl, xNov)

% %%
% X(1,:,:) = [1,2,3;4,5,6;7,8,9];
% X(2,:,:) = [1,2,3;4,5,6;7,8,9];
% 
% Y = [
%     0.8147    0.9134    0.2785    0.9649;
%     0.9058    0.6324    0.5469    0.1576;
%     0.1270    0.0975    0.9575    0.9706];
% 
% [A,B,C] = size(X);
% Z = cellfun(@(x) x*Y,mat2cell(X,A,B,ones(1,C)),'UniformOutput',false);
% Z = cat(3,Z{:});
% 
% v = mat2cell(X,A,B,ones(1,20))
