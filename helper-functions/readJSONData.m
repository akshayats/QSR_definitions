% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : readJSONData.m
% Syntax     : InJsonData   = readJSONData(FileName, AbsPathToFile, SaveFileName)
% Description: This is a function written to find the
%              
% Author     : Akshaya Thippur
% Last Edited: 14 May 2014
% Notes      : This module works along with the JSON toolbox created for
%			   MATLAB. This is available at: 
%			   http://www.cs.sunysb.edu/~kyamagu/software/json/
% Parents    : None
% Daughters  : None
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function InJsonData   = readJSONData(FileName, AbsPathToFile, SaveFileName)
	json.startup;
	FullPath       = [AbsPathToFile, FileName];
	InJsonData     = json.read(FullPath);
	if nargin == 3
		if SaveFileName == 'save'
			SaveFileName   = 'InJsonData';
		end
		% Correcting Some FieldNames
		InJsonData     = fieldCorrectJSONStruct(InJsonData);
		% Adding Time Stamp
		cTimeStamp     = datestr(clock,30);
		% Saving Data Read In
		dataFilename   = [SaveFileName,'_',cTimeStamp];
		save(dataFilename, 'InJsonData');
	end
end