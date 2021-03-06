function Dists   = ItmlDist(X1, X2)
% 	load('data/ITMLData_2.mat');
% 	load('data/ITMLData_5_8c.mat');
% 	load('data/ITMLData_10_10c.mat')
% load('data/itml-expts/ITMLData_5_13ob2_10c.mat')
global FileName
load(FileName)
	if size(X1,1) ~= 1 
		error('TSA:: Wrong Dimensions of Inputs');
	elseif size(X1,2) ~= size(X2,2)
		error('TSA:: Wrong Dimensions of Inputsssss');
	end
	X1Mat     = repmat(X1, size(X2,1), 1);
	DiffMat   = X1Mat - X2;
	Dists     = diag(DiffMat*A*DiffMat');
end