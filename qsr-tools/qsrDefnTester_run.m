%  This is a functionality tester script - It will not work as a whole - NO
%  FUNCTIONALIY!
% This file has been written to check the working of the QSR definitions.
close all; clear; clc;

PLOTFLAG   = true;

% Table =    [0, 158, 158, 0, 0, 158, 158, 0;
%             0, 0, 78, 78,0, 0, 78, 78;
%             0, 0, 0, 0, -3, -3, -3, -3]';
% 
% Monitor   = [0, 56.1, 56.1, 0, 0, 56.1, 56.1, 0;
%              0, 0, 15.9, 15.9, 0, 0, 15.9, 15.9;
%              0, 0, 0, 0, 46.7, 46.7, 46.7, 46.7]';
         
load('ObjData1')

% Indicators
B     = [1;0;0;0;0];
F     = [0;1;0;0;0];
L     = [0;0;1;0;0];
R     = [0;0;0;1;0];
E     = [0;0;0;0;1];
        
AllFields   = FindFields(MonitorShifted,Table);
% % % 
% % % % >>>> TEST 1
% % % PMat   = [25, 250;
% % %           300, 150;
% % %           200, 200;
% % %           100, -50;
% % %           110, 60;
% % %           120, 80;
% % %           130, 35;
% % %           160, 45;
% % %           80, 70;
% % %           180, 75;
% % %           190, 55;
% % %           150, 15;
% % %           180. 20;
% % %           100, 130;
% % %           80, 110;
% % %           80, 40;
% % %           60, 50]';
% % % %               a,b,c,d,e, f,g,h,i,1, 2,3,4,5,6, 7,8
% % % ExpResults   = [L,R,B,F,E, B,F,R,L,B, R,F,R,B,L, F,L];
% % % 
% % % % >>>> TEST 2
% % % PMat         = AllFields.Behind;
% % % ExpResults   = [B B B B B B];
% % % 
% % % % >>>> TEST 3
% % % % This fails because of floating point precision errors
% % % PMat         = AllFields.Forward;
% % % ExpResults   = [F F F F F F];
% % % 

% >>>> TEST 4
% This fails because of floating point precision errors
PMat         = AllFields.Forward;
Perturb      = [-5, +5, +5, -5, +5, -5; 0, 0, 0, 0, 0, 0];
% Perturb      = [0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0];
PMat         = PMat + Perturb;
ExpResults   = [L R R F F L];

FieldVecs   = WhichField(PMat, AllFields, MonitorShifted);
Logicals   = ExpResults == FieldVecs;            
[Indxs]    = sum(Logicals, 1)~=5;

if PLOTFLAG
	hndl   = figure;
	drawPlane(Table, 'b', hndl);
	drawPlane(MonitorShifted, 'm', hndl);
	drawPlane(TrajObj, 'k', hndl);
	drawPlane(AllFields.Behind, '--.g', hndl);
	drawPlane(AllFields.Forward, '--.r', hndl);
	% Plotting
	figure(hndl);
	plot(PMat(1,:), PMat(2, :), '.b', 'LineWidth', 5);
	figure(hndl);
	plot(PMat(1,Indxs), PMat(2, Indxs), '*r', 'LineWidth', 5);
end

if sum(sum(abs(ExpResults-FieldVecs))) == 0
    disp('SUCCESS!');
else
    disp('There might be some Errors! Check!');
end

%% getQSRMsrs
QSRMsrs   = GetQSRMsrs(MonitorShifted, TrajObj, Table);
