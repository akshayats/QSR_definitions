% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : IsLeft.m
% Syntax     : Ans   = IsLeft(A, B, P)
% Description: This is a function written to find if point P is to the left
%              of the vector from point A to point B. On the line is
%              considered as left.
%              
% Author     : Akshaya Thippur
% Last Edited: 07 Jan 2014
% Notes      : Based on Cross Product of Vectors
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Ans   = IsLeft(A, B, P)
    Ans   = ((B(1)-A(1)) * (P(2)-A(2)) - (B(2)-A(2)) * (P(1)-A(1))) >= 0;
end