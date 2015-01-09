% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Table Similarities
% File Name  : Trial_MinSpan.m
% Syntax     : 
% Description: This is a file to try the minimum spanning tree algorithm
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

child_handles = allchild(0);

names = get(child_handles,'Name');

k = find(strncmp('Biograph Viewer', names, 15));

close(child_handles(k))


% Load Data
load('AllScenesQSRData.mat')

% Select a Scene and Display 

QSRMat              = AllScenesQSRs{5};
ObjLabelMat         = struct2cell(AllScenesObjs{5});
ObjLabelMat(4)      = [{'Akshaya'}];
[depth rows cols]   = size(QSRMat);

% Since the Matrix Shows Increasing Amount of Nearness, Negate Values
DistMat   = 1-reshape(QSRMat(5, :, :), rows, cols);
% Only Lower Triangular Matrix Because Otherwise There Are Two Edges
% Between Every Node-Pair
UG   = tril(sparse(DistMat));
% UG   = tril(DistMat);

% UG = tril(SDistMat + SDistMat');
bgobj   = biograph(UG,ObjLabelMat');
get(bgobj.nodes, 'ID' )
% view(biograph(UG,ObjLabelMat))%,'ShowArrows','off','ShowWeights','on'));
% [ST, pred]    = graphminspantree(UG);
% view(biograph(ST,ObjLabelMat))%,'ShowArrows','off','ShowWeights','on'));

% W = [.41 .29 .51 .32 .50 .45 .38 .32 .36 .29 .21];
% DG = sparse([1 1 2 2 3 4 4 5 5 6 6],[2 6 3 5 4 1 6 3 4 2 5],W);
% UG = tril(DG + DG');
% NodeIds   = [];
% view(biograph(UG,[],'ShowArrows','off','ShowWeights','on'))
% [ST,pred] = graphminspantree(UG);
% view(biograph(ST,[],'ShowArrows','off','ShowWeights','on'))