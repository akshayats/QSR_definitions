% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : bBoxConvert.m
% Syntax     : NewBBox   = bBoxConvert(OldBBox);
% Description: This is a function written to convert the BoundingBox
%			   description conventions from FrontFace-BackFace (in JSON
%			   File) to BottomFace-TopFace (convention used by rest of the
%			   functions in this module)
%
%				Initial Convention (from JSON)
%
%				    *8-------------*7
%              *4-------------*3	|
%				|	 |		   |	|	back
%				|	 |		   |	|
%		front	|	 |		   |	|
%				|	 |		   |	|
%				|	*5---------|---*6
%			   *1-------------*2
%
%
%				Converted Convention (for these modules)
%
%				    *8-------------*7
%              *5-------------*6	|
%				|	 |		   |	|	back
%				|	 |		   |	|
%		front	|	 |		   |	|
%				|	 |		   |	|
%				|	*4---------|---*3
%			   *1-------------*2
%              
% Author     : Akshaya Thippur
% Last Edited: 23 June 2014
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function NewBBox   = bBoxConvert(OldBBox)
	% There is an Assumption Over Point Ordering Conventions (Notice Description)
	NewBBox   = OldBBox([1 2 6 5 4 3 7 8], :);
end