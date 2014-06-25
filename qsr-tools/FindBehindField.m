% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : FindBehindField.m
% Syntax     : BehindField = FindBehindField(Table, Landmark)
% Description: This is a function written to find the Behind Field given a
%              with respect to a Landmark Object, given the Landmark
%              Object and the Table Dimensions.
% 
%              The Table vertices are specified in the order (lower left, 
%              lower right, upper right and upper left) < visualize from 
%              top view>
%              
%              The Landmark Object vertices are also specified in a
%              particular order (BottomFace: front left, front right, back
%              right, back left; TopFace: front left, front right, back
%              right, back left) <visualize from front-view>
% 
%              The B-field will also be specified as 6 vertices in the
%              order (Landmark Object upper left, Landmark Object upper
%              right, right inflexion point, field right max point, field
%              left max point, left inflexion point) (clockwise)
%               
%              Assumptions: Flatland, Convex Bounding boxes - majorly
%              resting on the table;
% 
% Author     : Akshaya Thippur
% Last Edited: 07 Jan 2014
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function BehindField = FindBehindField(Table, Landmark)
    % Find Table Top
    oTableTop   = Table(1:4, 1:2);
    oOrigin     = [0,0];
    
    % Find Bottom Face of Bounding Box
    oLObj       = Landmark(1:4, 1:2); % First Four Points and Without Z Coordinate
    
    % Find Centroid of Bottom Face
    oLObjCentroid   = sum(oLObj,1)/4;
   
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
    PtTx   = [c   -s   h*c-k*s;
              s   c    h*s+k*c;
              0   0    1      ];
    % Converts Points from New Coordinate System to Original Coordinate System
    InvPtTx   = [c    s   -h;
                 -s   c   -k;
                 0    0    1  ];
    % New Coordinates Of All Relevant Points
    nOrigin     = PtTx*[oLObj(1,:), 1]';
    nLObj       = PtTx*[oLObj, ones(size(oLObj,1),1)]';
    nTableTop   = PtTx*[oTableTop, ones(size(oTableTop,1),1)]';
    % Truncate Points
    nOrigin     = nOrigin(1:2)';
    nLObj       = nLObj(1:2,:)';
    nTableTop   = nTableTop(1:2,:)';
    
    % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 
    % Work In New Coordinate System
    % Find Back Edge Line Equation
    P1   = nLObj(4,:);
    P2   = nLObj(3,:);
    L    = P2(1);
    % Find Right 45deg Line Parameters --> eqn1: y = x + CRt
    CRt   = P2(2) - P2(1);
    % Find Left 45deg Line Parameters --> eqn2: y = -x + CLt
    CLt   = P1(2) + P1(1);
    % Find Right Cut Off Line Parameters --> eqn3: x = 2*length
    CutOffRt   = 2*L;
    % Find Left Cut Off Line Parameters --> eqn4: x = -length
    CutOffLt   = -L;
    % Find Right Inflexion Point --> eqn1, eqn3
    P3 = [CutOffRt, CutOffRt+CRt];
    % Find Left Inflexion Point --> eqn2, eqn4
    P6 = [CutOffLt, -CutOffLt+CLt];
    % Find Right Max Point for Visualization
    P4 = [CutOffRt, 3*(CutOffRt+CRt)];
    % Find Left Max Point for Visualization
    P5 = [CutOffLt, 3*(-CutOffLt+CLt)];
    % Rearrange Points in Correct Order
    BehindField   = [P1;P2;P3;P4;P5;P6];
    % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    % Returning Bounding Points
    BehindField   = [BehindField, ones(6,1)]';
    % Convert Back To Original Coordinate System
    BehindField   = InvPtTx * BehindField;
    % RETURN
    BehindField   = BehindField(1:2, :)';
    
    % Plotting
%     hndl   = drawPlane(oTableTop);
%     drawPlane(oLObj,'r',hndl);
%     axis equal;

end