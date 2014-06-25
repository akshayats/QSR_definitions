% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : GetNearness.m
% Syntax     : 
% Description: This is a function written to find how near the Trajector
%			   Object is to the Landmark Object. This is calculated as a
%			   ratio to the mean of their respective sizes represented by
%			   their diagonals.
%              
% Author     : Akshaya Thippur
% Last Edited: 22 June 2014
% Notes      : 
% Parents    : 
% Daughters  : WhichField.m, FindFillPoints.m, drawPlane.m
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Nearness   = GetNearness(Landmark, Trajector)
	
	PLOTFLAG  = false;
	LObjPts   = Landmark(1:4,1:2);
	LObjPts   = [Landmark(1:4,1:2); mean(Landmark(1:4,1:2))];
	
	TObjPts   = Trajector(1:4,1:2);
	TObjPts   = [Trajector(1:4,1:2); mean(Trajector(1:4,1:2))];
	
	LPts   = [repmat(LObjPts(1,:),5,1);
		      repmat(LObjPts(2,:),5,1);
			  repmat(LObjPts(3,:),5,1);
			  repmat(LObjPts(4,:),5,1);
			  repmat(LObjPts(5,:),5,1);];
		  
	TPts   = repmat(TObjPts(:,:),5,1);
	
	Dists   = sqrt(sum((LPts - TPts).^2, 2));
	
	% Minimum Distance Between Sets of 5 Points Representing Both Objects
	% Think About Using Rotating Callipers Algorithm Here Instead!
	[Rd, MinIndx]   = min(Dists);
	
	% Finding Diagonal Sizes For Both Objects To Scale Rd
	DiagL   = sqrt(sum((LObjPts(1,:) - LObjPts(3,:)).^2,2));
	DiagT   = sqrt(sum((TObjPts(1,:) - TObjPts(3,:)).^2,2));
	% Scaling Factor
	SclFctr   = (DiagL + DiagT)/2;
	
	% Measure Factor x
	x   = (Rd / SclFctr).^2;
	
	% Nearness is Given By:
	if x <= 0
		Nearness   = 1;
	elseif x >= 1
		Nearness   = 0;
	else
		% Using Square of Linear Interpolation Between Max and Min Nearness
		% Consider Using Exponential Interpolation Between Extrema
		Nearness   = (-1)*x + 1; % Points are (0,1), (1,0)
	end
	
	% Plotting
	if PLOTFLAG
		hndl   = figure;
		drawPlane(Landmark, 'm', hndl);
		drawPlane(Trajector, 'k', hndl);
		LIndx   = ceil(MinIndx / 5);
		TIndx   = mod(MinIndx, 5);
		plot([LObjPts(LIndx, 1),TObjPts(TIndx, 1)], [LObjPts(LIndx, 2),TObjPts(TIndx, 2)], '--', 'LineWidth', 5);
		title('Debug plot: GetNearness.m');
	end
end