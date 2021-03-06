% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : GetQSRMsrs.m
% Syntax     : QSRMsrsMat   = GetQSRMsrs(Landmark, TrajectorArr, Table, PlotFlag)
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

function QSRMsrsMat   = GetQSRMsrs(Landmark, TrajectorArr, Table, PlotFlag)
	if nargin == 4
		if islogical(PlotFlag)
			PLOTFLAG     = PlotFlag;
		else
			warning('TSA:: Wrong PlotFlag value!');
			PLOTFLAG     = false;
		end
	else
		PLOTFLAG     = false;
	end
	% Flags
	CHANGEBBOX      = false;
	ZERO_DIM_TRJT   = false;
	ZERO_DIM_LMRK   = false;
	
	if ~iscell(TrajectorArr)
		TrajectorArr   = {TrajectorArr};
	end
	
	[r, c]   = size(Landmark);
	if r > 4 
		if c > 2
			% Checking Convention
			if Landmark(2,3)~=Landmark(3,3) 
			% Suggests Front Face Description Not Bottom Face
				CHANGEBBOX   = true;
			end
		else
			warning('TSA:: Please check the bounding box description conventions! ref: bBoxConvert.m');
		end
	end
	% Convention Handling
	if CHANGEBBOX
		Landmark   = bBoxConvert(Landmark);
	end
	
	% Calculating Fields
	if nargin == 3 
		if ~isempty(Table)
			AllFields   = FindFields(Landmark, Table);
		else
			AllFields   = FindFields(Landmark);
		end
	else
		AllFields   = FindFields(Landmark);
	end
		
	% Check For Zero Value on Any Dimension for Landmark Object
	if abs(sum(Landmark(1,:) - Landmark(2,:))) < 1e-6
		ZERO_DIM_LMRK = true;
	elseif abs(sum(Landmark(1,:) - Landmark(3,:))) < 1e-6
		ZERO_DIM_LMRK = true;
	elseif abs(sum(Landmark(1,:) - Landmark(4,:))) < 1e-6
		ZERO_DIM_LMRK = true;
	end

	% Do for Each Trajector
	NumOfTrajObjs   = length(TrajectorArr);
	
	% Initialize Output
	QSRMsrsMat      = zeros(6, NumOfTrajObjs); % 6 QSR fields
	if ~ZERO_DIM_LMRK
		for t = 1:NumOfTrajObjs
			% Initialize
			Trajector   = TrajectorArr{t};
			QSRMsrs     = zeros(6,1);

			% Convention Handling
			if CHANGEBBOX
				Trajector   = bBoxConvert(Trajector);
			end

			if sum(sum(Landmark-Trajector)) == 0 % DONT find QSR for ObjA wrt ObjA
				QSRMsrs   = zeros(6,1);
			else
				% Check For Zero Value on Any Dimension for Trajector Object
				if abs(sum(Trajector(1,:) - Trajector(2,:))) < 1e-6
					ZERO_DIM_TRJT = true;
				elseif abs(sum(Trajector(1,:) - Trajector(3,:))) < 1e-6
					ZERO_DIM_TRJT = true;
				elseif abs(sum(Trajector(1,:) - Trajector(4,:))) < 1e-6
					ZERO_DIM_TRJT = true;
				end
				if ~ZERO_DIM_TRJT
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
				end

				% Get Nearness Measure
				Nearness   = GetNearness(Landmark, Trajector);

				% Append To Get All QSR Measures. [BFLR N Err]
				QSRMsrs   = [QSRMsrs(1:4, :); Nearness; QSRMsrs(5,:)];
			end
			% Store QSRs in Ouput Mat
			QSRMsrsMat(:,t)   = QSRMsrs;

			% Plotting
			if PLOTFLAG && sum(QSRMsrs)~=0
				hndl   = figure;
				drawPlane(Landmark, 'm', hndl);
				drawPlane(Trajector, 'k', hndl);
				plot(TrajPoints(:,1), TrajPoints(:,2), '.k');
				drawPlane(AllFields.Behind, '--.g', hndl);
				drawPlane(AllFields.Forward, '--.r', hndl);
				title('Debug plot: GetQSRMsrs.m');
			end
		end
	else
		% Store QSRs in Ouput Mat
		% Send All Zeros For QSRMsrsMat
	end
end