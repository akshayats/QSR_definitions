% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : getQSRMsrs.m
% Syntax     : 
% Description: This is a function written to find how much of the trajector
%			   is contained in each of the QSR fields. The values are
%			   percentages of the entire volume (area) measured by the
%			   points populating 
%              
% Author     : Akshaya Thippur
% Last Edited: 12 May 2014
% Notes      : 
% Parents    : 
% Daughters  : WhichField.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function QSRMsrs   = getQSRMsrs(Table, Landmark, Trajector)
	% Calculating Fields
	AllFields   = FindFields(Table, Landmark);
	
	% Populate Trajector With Points
	xvec   = Trajector(1,1):Trajector(2,1);
	yvec   = Trajector(1,2):Trajector(4,2);
	[A,B]   = meshgrid(xvec,yvec);
	
	% Plotting
	hndl   = figure;
	drawPlane(Landmark, 'm', hndl);
	drawPlane(Trajector, 'k', hndl);
	drawPlane(AllFields.Behind, '--.g', hndl);
	drawPlane(AllFields.Forward, '--.r', hndl);
	
	plot(x1, y1, '.k')
	
	% Return Value
	QSRMsrs   = [];
end