% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : Data IO
% File Name  : text2Cell.m
% Syntax     : [ StringsCell ] = text2Cell( InFileName, Delimiter);
% Description: This is a function written to read in a bunch of strings in
%				a text file. The new line causes a new row in the cell
%				matrix. Every column in a row is a word in the text file.
%				Keep in mind that the file needs to have same number of
%				words in each line. A "word" here is defined by that string
%				which is separated from another string by the specified
%				delimiter.
%
%				The first line must not be blank!
%              
% Author     : Akshaya Thippur
% Last Edited: 27 Feb 2015
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ StringsCell ] = text2Cell(InFileName, Delimiter)
	% Input Control
	if nargin < 2
		Delimiter   = ' ';
	elseif nargin >2
		error('TSA:: Wrong number of input arguments!');
	end
    fid           = fopen(InFileName);
    tline         = fgetl(fid);
	StringsCell   = [];
	while ischar(tline)
		CellofStr     = regexp(tline, Delimiter,'split'); % Splitting into String Chunks
		StringsCell   = [StringsCell; CellofStr];
		tline         = fgetl(fid);
	end
end