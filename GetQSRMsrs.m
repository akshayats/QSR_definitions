% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : GetQSRMsrs.m
% Syntax     : 
% Description: This is a function written to find how much of the trajector
%			   is contained in each of the QSR fields. The values are
%			   percentages of the entire volume (area) measured by the
%			   points populating.
%				
%			   Nearness QSR is defined in another function.
%              
% Author     : Akshaya Thippur
% Last Edited: 22 June 2014
% Notes      : 
% Parents    : 
% Daughters  : WhichField.m, FindFillPoints.m, drawPlane.m, GetNearness.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function QSRMsrs   = GetQSRMsrs(Table, Landmark, Trajector)
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
	
	% Get Nearness Measure
	Nearness   = GetNearness(Landmark, Trajector);
	
	% Append To Get All QSR Measures. [BFLR N Err]
	QSRMsrs   = [QSRMsrs(1:4, :); Nearness; QSRMsrs(5,:)];
	
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