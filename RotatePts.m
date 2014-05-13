function [PtsRot]    = RotatePts(C, pts, theta)
	xo1   = C(1,1);
	yo1   = C(1,2);
	s     = sin(theta);
	c     = cos(theta);

	rotmat   = [c, -s; s,c];
	
	pts      = pts - repmat([xo1,yo1], size(pts,1), 1);
	PtsRot   = pts*rotmat;
	PtsRot   = PtsRot + repmat([xo1,yo1], size(pts,1), 1);

end