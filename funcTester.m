%  This is a functionality tester script - It will not work as a whole - NO
%  FUNCTIONALIY!

close all; clear all; clc;

% Table =    [0, 158, 158, 0, 0, 158, 158, 0;
%             0, 0, 78, 78,0, 0, 78, 78;
%             0, 0, 0, 0, -3, -3, -3, -3]';
% 
% Monitor   = [0, 56.1, 56.1, 0, 0, 56.1, 56.1, 0;
%              0, 0, 15.9, 15.9, 0, 0, 15.9, 15.9;
%              0, 0, 0, 0, 46.7, 46.7, 46.7, 46.7]';
         
load('Objdata')

% Indicators
B     = [1;0;0;0;0];
F     = [0;1;0;0;0];
L     = [0;0;1;0;0];
R     = [0;0;0;1;0];
E     = [0;0;0;0;1];
        
% BehindField = FindFrontField(Table, MonitorShifted);
% disp(BehindField)

AllFields   = FindFields(Table, MonitorShifted);

hndl   = figure;
drawPlane(Table, 'b', hndl);
drawPlane(MonitorShifted, 'm', hndl);
drawPlane(AllFields.Behind, '--.g', hndl);
drawPlane(AllFields.Forward, '--.r', hndl);

PMat   = [25, 250;
          300, 150;
          200, 200;
          100, -50;
          110, 60;
          120, 80;
          130, 35;
          160, 45;
          80, 70;
          180, 75;
          190, 55;
          150, 15;
          180. 20;
          100, 130;
          80, 110;
          80, 40;
          60, 50]';

% PMat   = 
figure(hndl);
plot(PMat(1,:), PMat(2, :), '.b', 'LineWidth', 10);
FieldVecs   = WhichField(PMat, AllFields, MonitorShifted);
%               a,b,c,d,e, f,g,h,i,1, 2,3,4,5,6, 7,8
ExpResults   = [L,R,B,F,E, B,F,R,L,B, R,F,R,B,L, F,L];

Logicals   = ExpResults == FieldVecs;            
[Indxs]    = sum(Logicals, 1)~=5;


figure(hndl);
plot(PMat(1,Indxs), PMat(2, Indxs), '.r', 'LineWidth', 10);

sum(sum(abs(ExpResults-FieldVecs)))            