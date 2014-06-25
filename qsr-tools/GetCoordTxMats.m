% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : GetCoordTxMats.m
% Syntax     : [CoordTx, InvCoordTx]   = GetCoordTxMats(Landmark)
% Description: This is a function written to find the Coordinate
%              Transformation matrices so that the coordinate axes can be
%              affine transformed from the original location:
% 
%              (Assumption)
%              origin = left bottom corner of table 
%              x axis = lower edge of table
%              y axis = left edge of table
% 
%              to a new location:
% 
%              origin = left bottom corner of Landmark Object
%              x axis = lower edge of Landmark Object
%              y axis = left edge of Landmark Object
% 
%              usage:
%              PtsInOldCoords   = [x1, x2, x3, x4;
%                                  y1, y2, y3, y4;
%                                  1 , 1 , 1 , 1  ];
%              PtsInNewCoords   = CoordTx*PtsInOldCoords
%              PtsInOldCoords   = InvCoordTx*PtsInNewCoords
% 
% Author     : Akshaya Thippur
% Last Edited: 07 Jan 2014
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CoordTx, InvCoordTx]   = GetCoordTxMats(Landmark)
    
    % Truncate Unneeded Points for Bottom Face of Bounding Box
    % First Four Points and Without Z Coordinate
    oLObj       = Landmark(1:4, 1:2); 
    
    % Shift Origin and X-Y Axis = New Coordinate System
    % Find Yaw Angle
    yaw   = atan((oLObj(2,2) - oLObj(1,2))/(oLObj(2,1) - oLObj(1,1)));
    % Make Point Transformer, Acc to Shifted Origin and Rotated Axes
    WantOrigin   = oLObj(1,:);
    c            = cos(-yaw);
    s            = sin(-yaw);
    h            = -WantOrigin(1,1);
    k            = -WantOrigin(1,2);
    % Converts Points from Original Coordinate System to New Coordinate System
    CoordTx   = [c   -s   h*c-k*s;
                 s   c    h*s+k*c;
                 0   0    1      ];
    % Converts Points from New Coordinate System to Original Coordinate System
    InvCoordTx   = [c    s   -h;
                   -s   c   -k;
                    0    0    1  ];
    
end