function FillPoints   = FindFillPoints(Object, Nx)
	PLOTFLAG   = false;
	
	xo1   = Object(1,1);
	yo1   = Object(1,2);

	xo2   = Object(2,1);
	yo2   = Object(2,2);

	% Rotate Box Back To Origin and Original Axes
	if xo2~=xo1
		theta   = atan((yo2-yo1)/(xo1-xo2));
	else
		if yo2-yo1 > 0
			theta   = pi/2;
		elseif yo2-yo1 < 0
			theta   = -pi/2;
		else
			error('TSA:: SINGLE POINT!');
		end
	end
	ptsrot    = RotatePts(Object(1,1:2), Object(:,1:2), -theta);

	x1   = ptsrot(1,1);
	y1   = ptsrot(1,2);

	x2   = ptsrot(2,1);
	y2   = ptsrot(2,2);

	x3   = ptsrot(3,1);
	y3   = ptsrot(3,2);

	x4   = ptsrot(4,1);
	y4   = ptsrot(4,2);

	% Calculate Ny for Equal Density of Points
	if (x2 ~= x1)
		Ny   = abs((x2-x1)/Nx);
	elseif(x4 ~= x1)
		Ny   = abs((x4-x1)/Nx);
	end

	xvec      = linspace(x1, x2, Nx);
	yvec      = y1:Ny:y4;
	% Make Grid Points According To Vectors
	[X, Y]    = meshgrid(xvec, yvec);
	% Columnize
	FillPts   = [X(:), Y(:)];

	% Corrections to Fit the Rotated Box
	FillPtsRot    = RotatePts(Object(1,1:2), FillPts, theta);
	if PLOTFLAG
		figure; plot(Object(:,1),Object(:,2), '.-b');
		hold on;
		plot(ptsrot(:,1),ptsrot(:,2), '.-k');
		plot(FillPts(:,1),FillPts(:,2),'.k');
		plot(FillPtsRot(:,1),FillPtsRot(:,2), '.r');
	end
	
	% Return
	FillPoints   = FillPtsRot;
end