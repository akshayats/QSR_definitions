% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project    : General Tools
% File Name  : plotWtd.m
% Syntax     : 
% Description: This is a function written to plot approximate lines with
%              patches instead of the built-in plot() function. This is so
%              that one can change the color and transparency of lines.
%
%              Each Y value should have a corresponding X value.
% 
%              Different lines have their range in the columns of Y and
%              domain in the columns of X.
%              
% Author     : Akshaya Thippur
% Last Edited: 
% Notes      : 
% Parents    : 
% Daughters  : patch() -> in-built
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [fHndl] = plotWtd(X, Y, varargin)
   % Input Check
   [dR, dC]    = size(X);
   [rR, rC]    = size(Y);
   if (dR~=rR || dC~=rC)
      fHndl   = -1;
      error('   TSA:: Wrong input sizes!');
   end
   % Parameters
   Thickness    = 0.1;
   fA           = 0.5;
   eA           = 0.5;
   C            = 'b';
   eC           = 'b';
   fC           = 'b';
   fHndl        = -999;
   Thickness   = repmat(Thickness, dR, 1);
   eA   = repmat(eA, dR, 1);
   fA   = repmat(fA, dR, 1);
   eC   = repmat(eC, dR, 1);
   fC   = repmat(fC, dR, 1);
   if nargin > 2
      NumOfParams   = (nargin - 2)/2;
      for p = 1:NumOfParams
         switch varargin{p*2-1}
            case 'FaceColor'
               temp   = varargin{p*2};
               if size(temp,1) == dR
                  fC   = temp;
               end
            case 'EdgeColor'
               temp   = varargin{p*2};
               if size(temp,1) == dR
                  eC   = temp;
               end
            case 'FaceAlpha'
               temp   = varargin{p*2};
               if size(temp,1) == dR
                  fA   = temp/ max(temp);
               end
            case 'EdgeAlpha'
               temp   = varargin{p*2};
               if size(temp,1) == dR
                  eA   = temp/ max(temp);
               end
            case 'Thickness'
               temp   =  varargin{p*2};
               if size(temp,1) == dR
                  Thickness   = temp;
               end
            case 'FigHndl'
               fHndl   = varargin{p*2};
         end
      end
   end
   % Make Figure
   if fHndl == -999
      fHndl   = figure;
   else
      figure(fHndl);
   end
   % Loop Through Each Line
   for l = 1:dC
      % Make a Patch
      pX    = X(:,l);
      pY    = Y(:,l);
      pX    = [pX',fliplr(pX')];
      pY    = [pY',(fliplr(pY')+Thickness(l))];
      % Plot Patch
      patch(pX, pY, C, 'FaceColor', fC(l), 'EdgeColor', eC(l), 'FaceAlpha', fA(l), 'EdgeAlpha', eA(l));
   end
end

