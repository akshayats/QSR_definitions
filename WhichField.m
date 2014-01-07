% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : WhichField.m
% Syntax     : FieldVec   = WhichField(Point, AllFields, Landmark)
% Description: This is a function written to find the field to which a
%              given point belongs. FieldVec is a logical vector that
%              contains logical 1 according to which field the point lies
%              in. The rest are logical zeros. The order of indices are as
%              follows:
%              FieldVec   = [Behind;
%                            Forward;
%                            Left;
%                            Right;
%                            Error]
%              
% Author     : Akshaya Thippur
% Last Edited: 07 Jan 2014
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function FieldVec   = WhichField(P, AllFields, Landmark)
    % Initialize
    FieldVec   = zeros(5,1);
    
    % Get Coordinate Transformers
    [CoordTx, ~]   = GetCoordTxMats(Landmark);
    
    % Convert All Points to New Coordinate System Representation
    nP              = CoordTx*[P,1]';
    nBehindField    = CoordTx*[AllFields.Behind,  ones(size(AllFields.Behind,1) ,1)]';
    nForwardField   = CoordTx*[AllFields.Forward, ones(size(AllFields.Forward,1),1)]';
    nLeftField      = CoordTx*[AllFields.Left,    ones(size(AllFields.Left,1)   ,1)]';
    nRightField     = CoordTx*[AllFields.Right,   ones(size(AllFields.Right,1)  ,1)]';
    
    % Truncate & Transpose Back
    nP              = nP(1:2)';
    nBehindField    = nBehindField(1:2, :)';
    nForwardField   = nForwardField(1:2, :)';
    nLeftField      = nLeftField(1:2, :)';
    nRightField     = nRightField(1:2, :)';
    
    % Make All Lines
    L1   = nBehindField(5, 1);
    L2   = nBehindField(3, 1);
    L3   = nBehindField(6, 2);
    L4   = nForwardField(3, 2);
    L5   = nBehindField(1,2);
    L6   = nForwardField(1,2);
    L7   = nBehindField(1,1);
    L8   = nBehindField(2,1);    
    
    % Initialize
    x    = nP(1);
    y    = nP(2);
    
    iB     = false;
    iF     = false;
    iL     = false;
    iR     = false;
    iErr   = false;
    
    % Begin Long Chain of if-elseif-else According to Spider Diagram
    if(x < L1)
        iL   = 1;
    elseif(x > L2)
        iR   = 1;
    else
        if(y >= L3)
            iB   = 1;
        elseif(y <= L4)
            iF   = 1;
        elseif(y < L5)&&(y > L6)&&(x > L7)&&(x < L8)
            iErr   = 1;
        elseif(x >= L7)&&(x <= L8)
            if(y >= L5)
                iB   = 1;
            elseif (y <= L6)
                iF   = 1;
            end
        elseif(y <= L5)&&(y >= L6)
            if(x > L8)
                iR   = 1;
            elseif(x < L7)
                iL   = 1;
            end
        elseif(x >= L8)
            if(y >= L5)
                if(IsLeft(nBehindField(2,:), nBehindField(3,:), nP))
                    iB   = 1;
                else
                    iR   = 1;
                end
            elseif(y <= L6)
                if(IsLeft(nForwardField(3,:), nForwardField(2,:), nP))
                    iF   = 1;
                else
                    iR   = 1;
                end
            end
        elseif(x <= L7)
            if(y >= L5)
                if(IsRight(nBehindField(1,:), nBehindField(6,:), nP))
                    iB   = 1;
                else
                    iL   = 1;
                end
            elseif(y <= L6)
                if(IsRight(nForwardField(1,:), nForwardField(6,:), nP))
                    iF   = 1;
                else
                    iL   = 1;
                end
            end
        else
            FieldVec(5)   = 9;
        end
    end
    
    % Assign Vector Values
    FieldVec(1)   = iB;
    FieldVec(2)   = iF;
    FieldVec(3)   = iL;
    FieldVec(4)   = iR;
    FieldVec(5)   = iErr;
    
    % Sanity Check - A Point Cannot Be in More Than One Field
    if sum(FieldVec)>1
        warning('TSA:: Wrong Field Assignment Done to Point!');
    end
end