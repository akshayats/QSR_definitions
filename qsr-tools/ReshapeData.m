% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Based Table Similarities
% File Name  : 
% Syntax     : 
% Description: This is a function written to find the
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function OutData   = ReshapeData(InData, varargin)
	% Reading Input
	NumOfData   = length(InData);
	[r,c,p]     = size(InData{1});
	% Input Handling - Function Overload
	if nargin == 1
		QSRDims   = 1:r-1;
	elseif nargin == 2
		QSRDims     = varargin{1};
	else
		warning('TSA:: Switch to default operation mode!');
	end
	% Initialise Output
	OutData     = zeros(NumOfData, length(QSRDims)*c*p);
	% Loop Over Input Data
	for d = 1:length(InData)
		dOutData = [];
		for i = QSRDims
			dInData    = InData{d}(i,:,:);
			dMidData   = reshape(dInData, p, c)';
			dOutData   = [dOutData, dMidData(:)'];
		end
		OutData(d,:)   = dOutData;
	end
end