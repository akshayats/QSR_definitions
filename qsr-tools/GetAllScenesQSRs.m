% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : GetAllScenesQSR.m
% Syntax     : [AllScenesQSRs, AllScenesObjs]   = GetAllScenesQSRs(InJsonData, SaveFileName)
% Description: This is a function which takes in JSON file, calculates all
%			   QSR measures for all scenes, writes to a text file or saves
%			   as Matlab data file.
%              
% Author     : Akshaya Thippur
% Last Edited: 23 June 2014
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [AllScenesQSRs, AllScenesObjs]   = GetAllScenesQSRs(InJsonData, SaveFileName)
	NumOfScenes   = length(InJsonData);

	AllScenesQSRs   = cell(NumOfScenes, 1);
	AllScenesObjs   = cell(NumOfScenes, 1);
	
	if nargin == 1
		SaveFileName   = 'AllScenesQSRData';
	end
	
	disp('START OF PROCESSING...');

	for s = 1:NumOfScenes
		ObjBBoxs    = InJsonData(s).bbox;
		ObjNames    = fieldnames(ObjBBoxs);
		NumOfObjs   = length(ObjNames);
		ObjTypes    = InJsonData(s).type;

		% All QSR Measures for Whole Scene
		QSRBlock   = zeros(6, NumOfObjs, NumOfObjs);

		% All Objects In The Scene Are Trajector Objects
		TrajctrObj    = struct2cell(ObjBBoxs);
		for l = 1:NumOfObjs
			lLandmarkObj      = ObjBBoxs.(ObjNames{l});
			lQSRMsrs          = GetQSRMsrs(lLandmarkObj, TrajctrObj);
			QSRBlock(:,:,l)   = lQSRMsrs;
		end

		% Store QSR Block
		AllScenesQSRs(s)   = {QSRBlock};
		AllScenesObjs(s)   = {ObjTypes};
		
		% Intermediate Saving
		save(SaveFileName, 'AllScenesObjs', 'AllScenesQSRs');
		
		% Dialogue
		disp(['        Processed scene # ', num2str(s)]);
	end
	
	% Adding Time Stamp
	cTimeStamp     = datestr(clock,30);
	% Saving Data Read In
	SaveFileName   = [SaveFileName,'_',cTimeStamp];
	
	% Saving
	save(SaveFileName, 'AllScenesObjs', 'AllScenesQSRs');
	
	disp('END OF PROCESSING. Succesfully completed!');
end