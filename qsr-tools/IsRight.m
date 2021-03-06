% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : IsRight.m
% Syntax     : Ans   = IsRight(A, B, P)
% Description: This is a function written to find if point P is to the
%              right of the vector from point A to point B. On the line is
%              considered as right.
%              
% Author     : Akshaya Thippur
% Last Edited: 07 Jan 2014
% Notes      : Based on Cross Product of Vectors
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Ans   = IsRight(A, B, P)
    if ~iscolumn(P)
        P   = P';
    end
    
    if iscolumn(A)
        u   = B-A;
        v   = P-A;
    else
        u   = B'-A';
        v   = P'-A';
    end
    
    u   = [u;0];
    v   = [v;0];
    
    Ans   = (u(1)*v(2) - u(2)*v(1)) < 0;
end