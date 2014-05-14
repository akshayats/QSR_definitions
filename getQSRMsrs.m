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
% Daughters  : WhichField.m, FindFillPoints.m, drawPlane.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function QSRMsrs   = getQSRMsrs(Table, Landmark, Trajector)
	PLOTFLAG   = false;
	% Calculating Fields
	AllFields   = FindFields(Table, Landmark);
	
	% Populate Trajector With Points
	TrajPoints   = FindFillPoints(Trajector, 100);
	% Which Fields Do The Points Belong To? (All Fill Points and Vertices)
	Indicators   = WhichField([TrajPoints; Trajector(1:4,1:2)], AllFields, Landmark);
	
	% Calculate Percentage Measures of QSRs
	QSRMsrs   = sum(Indicators,2)/sum(sum(Indicators));
	% Sanity Check
	if sum(sum(Indicators)) ~= (size(TrajPoints,1)+4)
		warning('TSA:: Some points have gone missing');
		disp(['Number of Points   = ', num2str(sum(sum(Indicators)) ~= (size(TrajPoints,1)+4))]);
	end
	if QSRMsrs(5) ~= 0
		warning('TSA:: Some points may have been wrongly classified!');
	end
	% Plotting
	if PLOTFLAG
		hndl   = figure;
		drawPlane(Landmark, 'm', hndl);
		drawPlane(Trajector, 'k', hndl);
		plot(TrajPoints(:,1), TrajPoints(:,2), '.k');
		drawPlane(AllFields.Behind, '--.g', hndl);
		drawPlane(AllFields.Forward, '--.r', hndl);
	end
end