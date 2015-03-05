function Dists   = ItmlDist(X1, X2)
	load('data/ITMLData_2.mat');
	if size(X1,1) ~= 1 
		error('TSA:: Wrong Dimensions of Inputs');
	elseif size(X1,2) ~= size(X2,2)
		error('TSA:: Wrong Dimensions of Inputsssss');
	end
	X1Mat     = repmat(X1, size(X2,1), 1);
	DiffMat   = X1Mat - X2;
	Dists     = diag(DiffMat*A*DiffMat');
end