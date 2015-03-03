% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Similarity Measures
% File Name  : GetAllScenesLabels.m
% Syntax     : [Labels, ClassLabels, ClassLabelsMap]   = GetAllScenesLabels(InJsonData, SaveFileName)
% Description: This is a function accepts the scene data and yanks out all
%				the labels for the scenes in order of input.
% 
% 'Labels'			contains the actual label names for every scene.
% 'ClassLabels'		contains the class numbers as labels.
% 'ClassLabelsMap'	contains the mapping between the actual class label and
%					label number.
% 
% All these variables have a length
%              
% Author     : Akshaya Thippur
% Last Edited: 27 Feb 2015
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Labels, ClassLabels, ClassLabelsMap]   = GetAllScenesLabels(InJsonData, SaveFileName)
	% Person Type Definitions
	% ------------------------
	% Change File Input Here To Have More Label Fields
	PersonTypes          = text2Cell('PersonType_Occupation.txt');
	PersonTypes          = PersonTypes(2:end, :); % Ignoring Header Line
	
	% Other Data
	NumOfScenes   = length(InJsonData);

	Labels.scene_id      = cell(NumOfScenes, 1);
	Labels.person        = cell(NumOfScenes, 1);
	Labels.time          = cell(NumOfScenes, 1);
	Labels.date          = cell(NumOfScenes, 1);
	Labels.person_type   = cell(NumOfScenes, 1);
	
	if nargin == 1
		SaveFileName   = 'AllScenesLabels';
		% Adding Time Stamp
		cTimeStamp     = datestr(clock, 30);
		% Saving Data Read In
		SaveFileName   = [SaveFileName,'_',cTimeStamp];
	end
	
	disp('START OF PROCESSING...');

	for s = 1:NumOfScenes
		% Yank Scene ID
		sSceneID    = InJsonData(s).scene_id;
		% Process Scene ID for All Parts
		sStrParts   = regexp(sSceneID, '_', 'split');
		% Store Split Parts
		Labels.scene_id(s)   = {sSceneID};
		Labels.person(s)     = sStrParts(1);
		Labels.date(s)       = sStrParts(3);
		Labels.time(s)       = sStrParts(4);
		% Person Type Finding Out
		sPersonType             = PersonTypes(strcmp(PersonTypes(:,1), sStrParts(1)), 2);
		Labels.person_type(s)   = sPersonType;
		% Dialogue
		disp(['        Processed scene # ', num2str(s),'   ...' ,sSceneID]);
	end	
	% Finding Classes
	ClassLabelsMap.person          = unique(Labels.person);
	ClassLabelsMap.time            = unique(Labels.time);
	ClassLabelsMap.date            = unique(Labels.date);
	ClassLabelsMap.person_type     = unique(Labels.person_type);
	% Finding Class Labels For All Scenes
	ClassLabels.person   = sum(repmat([1:length(ClassLabelsMap.person)], NumOfScenes, 1).*...
								(strcmp(repmat(Labels.person, 1, length(ClassLabelsMap.person)), ...
								repmat(ClassLabelsMap.person', NumOfScenes, 1))), 2);
							
	ClassLabels.time     = sum(repmat([1:length(ClassLabelsMap.time)], NumOfScenes, 1).*...
								(strcmp(repmat(Labels.time, 1, length(ClassLabelsMap.time)), ...
								repmat(ClassLabelsMap.time', NumOfScenes, 1))), 2);
							
	ClassLabels.date     = sum(repmat([1:length(ClassLabelsMap.date)], NumOfScenes, 1).*...
								(strcmp(repmat(Labels.date, 1, length(ClassLabelsMap.date)), ...
								repmat(ClassLabelsMap.date', NumOfScenes, 1))), 2);
							
	ClassLabels.person_type     = sum(repmat([1:length(ClassLabelsMap.person_type)], NumOfScenes, 1).*...
								(strcmp(repmat(Labels.person_type, 1, length(ClassLabelsMap.person_type)), ...
								repmat(ClassLabelsMap.person_type', NumOfScenes, 1))), 2);
	
	% Saving
	save(SaveFileName, 'Labels', 'ClassLabels', 'ClassLabelsMap');
	
	disp('END OF PROCESSING. Succesfully completed!');
end