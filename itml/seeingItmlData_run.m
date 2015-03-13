% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Table Similarities
% File Name  : 
% Syntax     : 
% Description: This is a script that allows to look through the analysis of
%              the data of ITML Experiments.
%              
% Author     : Akshaya Thippur
% Last Edited: 13 March 2015
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

load 'data/ITMLDataAnalysis.mat';
load 'data/CleanData_SceneLabels.mat';

MisclassTotalMat_Itml   = sum(MisclassMat_Itml, 3);
MisclassTotalMat_Eucl   = sum(MisclassMat_Eucl, 3);

% Figure To See Where Errors Are

figure;
NumOfClasses   = size(MisclassTotalMat_Itml, 2);
pOffsetArray   = (1:NumOfClasses)' *15;
pConfusionMat_Itml   = (MisclassTotalMat_Itml + repmat(pOffsetArray, 1, NumOfClasses))';
pConfusionMat_Eucl   = (MisclassTotalMat_Eucl + repmat(pOffsetArray, 1, NumOfClasses)+0.5)';
pErrorWeight_Itml    = ceil(sum(ClassCountMat,2)./max(sum(MisclassTotalMat_Itml,2)));
pErrorWeight_Eucl    = ceil(sum(ClassCountMat,2)./max(sum(MisclassTotalMat_Eucl,2)));
pErrorWeight_Absl    = ceil(sum(MisclassTotalMat_Eucl,2)/10);
for c = 1:NumOfClasses
   plot(pConfusionMat_Itml(:,c),'.-b','LineWidth',pErrorWeight_Absl(c));
   hold on; grid on;
   plot(pConfusionMat_Eucl(:,c),'.-r','LineWidth',pErrorWeight_Absl(c));
end
xlim([-2,NumOfClasses+2]); ylim([-1,max(pOffsetArray)+10]);
title([{'Confusion in classification'};{'Weighted by total class occurences in tests'}]);
ylabel('Actual Classes'); xlabel('Confused as these classes');
ax   = gca;
ax.XTick   = 1:NumOfClasses;
ax.YTick   = min(pOffsetArray):15:max(pOffsetArray)+10;
ax.XTickLabel = ClassLabelsMap.person;
ax.YTickLabel = ClassLabelsMap.person;
ax.XTickLabelRotation = 45;


figure;
pErrorWeight_Itml    = ceil(sum(ClassCountMat,2)./max(sum(MisclassTotalMat_Itml,2)));
pErrorWeight_Eucl    = ceil(sum(ClassCountMat,2)./max(sum(MisclassTotalMat_Eucl,2)));
for c = 1:NumOfClasses
   plot(pConfusionMat_Itml(:,c),'.-b','LineWidth',pErrorWeight_Itml(c));
   hold on; grid on;
   plot(pConfusionMat_Eucl(:,c),'.-r','LineWidth',pErrorWeight_Eucl(c));
end
xlim([-2,NumOfClasses+2]); ylim([-1,max(pOffsetArray)+10]);
title([{'Confusion in classification'};{'Weighted by error fraction in tests'}]);
ylabel('Actual Classes'); xlabel('Confused as these classes');
ax   = gca;
ax.XTick   = 1:NumOfClasses;
ax.YTick   = min(pOffsetArray):15:max(pOffsetArray)+10;
ax.XTickLabel = ClassLabelsMap.person;
ax.YTickLabel = ClassLabelsMap.person;
ax.XTickLabelRotation = 45;