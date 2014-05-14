% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : QSR Comparisons to Metric
% File Name  : WhichField.m
% Syntax     : FieldVecs   = WhichField(PMat, AllFields, Landmark)
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
%              thus:
%              FieldVecs   = [b1, b2, b3, b4, b5;
%                             f1, f2, f3, f4, f5;
%                             l1, l2, l3, l4, l5;
%                             r1, r2, r3, r4, r5;
%                             e1, e2, e3, e4, e5 ];
% 
%             for PMat     = [x1, x2, x3, x4, x5;
%                             y1, y2, y3, y4, y5 ];
%              
% Author     : Akshaya Thippur
% Last Edited: 07 Jan 2014
% Notes      : 
% Parents    : 
% Daughters  : 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function FieldVecs   = WhichField(PMat, AllFields, Landmark)
	% Input Correction
	if size(PMat, 1) > 2 && size(PMat, 2) == 2
		PMat   = PMat';
	end
    % Initialize
    NumOfPts    = size(PMat, 2);
    FieldVecs   = zeros(5,NumOfPts);
    % One Padding for Affine Transform
    PMat        = [PMat; ones(1, NumOfPts)];
    
    % Get Coordinate Transformers
    [CoordTx, ~]   = GetCoordTxMats(Landmark);
    
    % Convert All Points to New Coordinate System Representation
    nPMat           = CoordTx*PMat;
    nBehindField    = CoordTx*[AllFields.Behind;  ones(1,size(AllFields.Behind,2) )];
    nForwardField   = CoordTx*[AllFields.Forward; ones(1,size(AllFields.Forward,2))];
    nLeftField      = CoordTx*[AllFields.Left;    ones(1,size(AllFields.Left,2)   )];
    nRightField     = CoordTx*[AllFields.Right;   ones(1,size(AllFields.Right,2)  )];
    
    % Truncate & Transpose Back
    nPMat           = nPMat(1:2, :);
    nBehindField    = nBehindField(1:2, :);
    nForwardField   = nForwardField(1:2, :);
    nLeftField      = nLeftField(1:2, :);
    nRightField     = nRightField(1:2, :);
    
    % Make All Lines
    L1   = nBehindField(1, 5);
    L2   = nBehindField(1, 3);
    L3   = nBehindField(2, 6);
    L4   = nForwardField(2, 3);
    L5   = nBehindField(2, 1);
    L6   = nForwardField(2, 1);
    L7   = nForwardField(1, 1);
    L8   = nBehindField(1, 2);    
    
    for p = 1:NumOfPts
        % Initialize
        x    = nPMat(1, p);
        y    = nPMat(2, p);

        iB     = false;
        iF     = false;
        iL     = false;
        iR     = false;
        iErr   = false;

        % Begin Long Chain of if-elseif-else According to Spider Diagram
        cmpVal   = [];
        varVal   = [];
        
        if(x < L1)
            iL       = 1;
            varVal   = x;
            cmpVal   = L1;
        elseif(x > L2)
            iR       = 1;
            varVal   = x;
            cmpVal   = L2;
        else
            if(y >= L3)
                iB       = 1;
                varVal   = y;
                cmpVal   = L3;
            elseif(y <= L4)
                iF       = 1;
                varVal   = y;
                cmpVal   = L4;
            elseif(y < L5)&&(y > L6)&&(x > L7)&&(x < L8)
                iErr     = 1;
                varVal   = [y,  y,  x,  x];
                cmpVal   = [L5, L6, L7, L8];
            elseif(x >= L7)&&(x <= L8)
                if(y >= L5)
                    iB       = 1;
                    varVal   = y;
                    cmpVal   = L5;
                elseif (y <= L6)
                    iF   = 1;
                    varVal   = y;
                    cmpVal   = L6;
                end
            elseif(y <= L5)&&(y >= L6)
                if(x > L8)
                    iR       = 1;
                    varVal   = x;
                    cmpVal   = L8;
                elseif(x < L7)
                    iL       = 1;
                    varVal   = x;
                    cmpVal   = L7;
                end
            elseif(x >= L8)
                varVal   = x;
                cmpVal   = L8;
                if(y >= L5)
                    varVal   = [varVal, y];
                    cmpVal   = [cmpVal, L5];
                    A   = nBehindField(:,2);
                    B   = nBehindField(:,3);
                    P   = [x; y];
                    if(IsLeft(A, B, P))
                        iB   = 1;
                    else
                        iR   = 1;
                    end
                elseif(y <= L6)
                    varVal   = [varVal, y];
                    cmpVal   = [cmpVal, L6];
                    A   = nForwardField(:,2);
                    B   = nForwardField(:,3);
                    P   = [x; y];
                    if(IsRight(A, B, P))
                        iF   = 1;
                    else
                        iR   = 1;
                    end
                end
            elseif(x <= L7)
                varVal   = x;
                cmpVal   = L7;
                if(y >= L5)
                    varVal   = [varVal, y];
                    cmpVal   = [cmpVal, L5];
                    A   = nBehindField(:,1);
                    B   = nBehindField(:,6);
                    P   = [x;y];
                    if(IsRight(A, B, P))
                        iB   = 1;
                    else
                        iL   = 1;
                    end
                elseif(y <= L6)
                    varVal   = y;
                    cmpVal   = L6;
                    A   = nForwardField(:,1);
                    B   = nForwardField(:,6);
                    P   = [x;y];
                    if(IsLeft(A, B, P))
                        iF   = 1;
                    else
                        iL   = 1;
                    end
                end
            else
                FieldVecs(5)   = 9;
            end
        end

        % Assign Vector Values
        FieldVecs(1, p)   = iB;
        FieldVecs(2, p)   = iF;
        FieldVecs(3, p)   = iL;
        FieldVecs(4, p)   = iR;
        FieldVecs(5, p)   = iErr;

        % Sanity Check - A Point Cannot Be in More Than One Field
        if sum(FieldVecs(:, p))>1 || sum(FieldVecs(:, p)) == 0
            warning('TSA:: Wrong Field Assignment Done to Point!');
        end
        
        % Generate Warnings - for Precision Point Errors
        Checksum   = abs(varVal-cmpVal);
        if ~isempty(find(Checksum<=1e-6,1))
            warning('TSA:: Precision point errors might have occured!');
        end
    end
end