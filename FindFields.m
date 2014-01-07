% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : FindFields.m
% Syntax     : Fields   = FindFields(Table, Landmark)
% Description: This is a function written to find the 
%              
%              - Behind Field 
%              - Forward Field 
%              - Left Field 
%              - Right Field 
%              
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
%              .:BEHIND FIELD:.
%              
%              The B-field will be specified as 6 vertices in the
%              order (Landmark Object upper left, Landmark Object upper
%              right, right inflexion point, field right max point, field
%              left max point, left inflexion point) (clockwise)
% 
%              .:FORWARD FIELD:.
%              
%              The F-field will be specified as 6 vertices in the
%              order (Landmark Object upper left, Landmark Object upper
%              right, right inflexion point, field right max point, field
%              left max point, left inflexion point) (clockwise)
%              
%              .:LEFT FIELD:.
%              
%              The L-field will be specified as 6 vertices in the
%              order (Landmark Object upper left, Landmark Object lower
%              left, lower inflexion point, field lower max point, field
%              upper max point, upper inflexion point) (clockwise)
%              
%              .:RIGHT FIELD:.
%              
%              The R-field will be specified as 6 vertices in the
%              order (Landmark Object upper right, Landmark Object lower
%              right, lower inflexion point, field lower max point, field
%              upper max point, upper inflexion point) (anti-clockwise)
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


function AllFields = FindFields(Table, Landmark)
    % Find Table Top
    oTableTop   = Table(1:4, 1:2);
    
    % Find Bottom Face of Bounding Box
    oLObj       = Landmark(1:4, 1:2); % First Four Points and Without Z Coordinate
    
    % Shift Origin and X-Y Axis = New Coordinate System
    % Find Yaw Angle
    yaw   = atan((oLObj(2,2) - oLObj(1,2))/(oLObj(2,1) - oLObj(1,1)));
    % Make Point Transformer, Acc to Shifted Origin and Rotated Axes
    WantOrigin   = oLObj(1,:);
    c            = cos(-yaw);
    s            = sin(-yaw);
    h            = -WantOrigin(1,1);
    k            = -WantOrigin(1,2);
% % %     % Converts Points from Original Coordinate System to New Coordinate System
% % %     PtTx   = [c   -s   h*c-k*s;
% % %               s   c    h*s+k*c;
% % %               0   0    1      ];
% % %     % Converts Points from New Coordinate System to Original Coordinate System
% % %     InvPtTx   = [c    s   -h;
% % %                  -s   c   -k;
% % %                  0    0    1  ];
    [PtTx, InvPtTx]   = GetCoordTxMats(Landmark);
    % New Coordinates Of All Relevant Points
    nOrigin     = PtTx*[oLObj(1,:), 1]';
    nLObj       = PtTx*[oLObj, ones(size(oLObj,1),1)]';
    nTableTop   = PtTx*[oTableTop, ones(size(oTableTop,1),1)]';
    % Truncate Points
    nOrigin     = nOrigin(1:2)';
    nLObj       = nLObj(1:2,:)';
    nTableTop   = nTableTop(1:2,:)';
    
    %.:BEHIND FIELD:.
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
    % Returning Bounding Points
    BehindField   = [P1;P2;P3;P4;P5;P6];
    BehindField   = [BehindField, ones(6,1)]';
    % Convert Back To Original Coordinate System
    BehindField   = InvPtTx * BehindField;
    % RETURN
    BehindField   = BehindField(1:2, :)';
    % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    %.:FORWARD FIELD:.
    % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        % Work In New Coordinate System
    % Find Forward Edge Line Equation
    P1   = nLObj(1,:);
    P2   = nLObj(2,:);
    L    = P2(1);
    % Find Right 45deg Line Parameters --> eqn1: y = x + CRt
    CRt   = P2(2) + P2(1);
    % Find Left 45deg Line Parameters --> eqn2: y = -x + CLt
    CLt   = P1(2) - P1(1);
    % Find Right Cut Off Line Parameters --> eqn3: x = 2*length
    CutOffRt   = 2*L;
    % Find Left Cut Off Line Parameters --> eqn4: x = -length
    CutOffLt   = -L;
    % Find Right Inflexion Point --> eqn1, eqn3
    P3 = [CutOffRt, -CutOffRt+CRt];
    % Find Left Inflexion Point --> eqn2, eqn4
    P6 = [CutOffLt, CutOffLt+CLt];
    % Find Right Max Point for Visualization
    P4 = [CutOffRt, 3*(-CutOffRt+CRt)];
    % Find Left Max Point for Visualization
    P5 = [CutOffLt, 3*(CutOffLt+CLt)];
    % Rearrange Points in Correct Order
    ForwardField   = [P1;P2;P3;P4;P5;P6];
    % Returning Bounding Points
    ForwardField   = [ForwardField, ones(6,1)]';
    % Convert Back To Original Coordinate System
    ForwardField   = InvPtTx * ForwardField;
    % RETURN
    ForwardField   = ForwardField(1:2, :)';
    % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
        
    %.:LEFT FIELD:.
    % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    P1   = BehindField(1, :);
    P2   = ForwardField(1, :);
    P3   = ForwardField(6, :);
    P4   = ForwardField(5, :);
    P5   = BehindField(5, :);
    P6   = BehindField(6, :);
    LeftField   = [P1;P2;P3;P4;P5;P6];
    % Returning Bounding Points
    LeftField   = [LeftField, ones(6,1)]';
    % Convert Back To Original Coordinate System
    LeftField   = InvPtTx * LeftField;
    % RETURN
    LeftField   = LeftField(1:2, :)';
    % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        
    
    %.:RIGHT FIELD:.
    % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    P1   = BehindField(2, :);
    P2   = ForwardField(2, :);
    P3   = ForwardField(3, :);
    P4   = ForwardField(4, :);
    P5   = BehindField(4, :);
    P6   = BehindField(3, :);
    RightField   = [P1;P2;P3;P4;P5;P6];
    % Returning Bounding Points
    RightField   = [RightField, ones(6,1)]';
    % Convert Back To Original Coordinate System
    RightField   = InvPtTx * RightField;
    % RETURN
    RightField   = RightField(1:2, :)';
    % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    % Return All Fields
    AllFields.Behind    = BehindField;
    AllFields.Forward   = ForwardField;
    AllFields.Left      = LeftField;
    AllFields.Right     = RightField;
end