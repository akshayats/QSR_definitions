% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : DataNormalise.m
% Syntax     : 
% Description: This is a function written to find the
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function NrmlData   = DataNormalise(QSRData, ObjNames)
	% Initialise
	NrmlData   = cell(length(QSRData), 1);
	% a Sorted Superset List of Objects
	ObjListSortedAll= {
    'Book';
    'Bottle';
	
    'Headphones';
    'Highlighter';
    'Jug';
    'Keyboard';
    'Lamp';
    'Marker';
    'Mobile';
    'Monitor';
    'Mouse';
    'Mug';
    'Papers';
    'PenStand';
    'Pencil';
    'Rubber'};
	% -----------------------------
	% Loop Through All Scenes
	NumOfScenes    = size(QSRData, 1);
	NumOfObjsAll   = length(ObjListSortedAll);
	for s = 1:NumOfScenes
		disp(['   Processing Scene # ', num2str(s), ' ...']);
		% Initialise
		Indxs           = [1:NumOfObjsAll]';
		sSrtdQSRBlock   = zeros(6, NumOfObjsAll,NumOfObjsAll);
		% Yank Current Data
		sObjNames       = fieldnames(ObjNames{s});
		sObjTypes       = cell(length(sObjNames),1);
		% Find Unique Set of Objects
		sObjTypes = cell(length(sObjNames),1);
		for o = 1:length(sObjNames)
			sObjTypes(o)   = {ObjNames{s}.(sObjNames{o})};
		end
		% Get Sorted Unique Object Types
		[sObjTypesUnqSrtd, aIndx, ~]   = unique(sObjTypes, 'first');
		% Find Sorting Order
		ObjListAllMat   = repmat(ObjListSortedAll, 1, length(sObjTypesUnqSrtd));
		sObjTypesMat    = repmat(sObjTypesUnqSrtd', NumOfObjsAll, 1);
		sIndxMat        = repmat(1:length(sObjTypesUnqSrtd), NumOfObjsAll, 1);
		sHitMat         = strcmp(ObjListAllMat, sObjTypesMat).*sIndxMat;
		sQSRIndxs       = sum(sHitMat,2);
		% Sanity Check
		if sum(sum(sHitMat,1) == 0)
			disp('------------------------Unknown Object Type Found!');
		end
		sNrmlIndxs      = find(sQSRIndxs);
		sQSRIndxs       = sQSRIndxs(sNrmlIndxs);
		% Assign Sorted Values In Right Places
		sTmpQSRBlock                               = QSRData{s}(:, aIndx, aIndx);
		sSrtdQSRBlock(:, sNrmlIndxs, sNrmlIndxs)   = sTmpQSRBlock(:, sQSRIndxs, sQSRIndxs);
		% Return To Function Output
		NrmlData(s)   = {sSrtdQSRBlock};
	end
end