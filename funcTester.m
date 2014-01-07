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
        
% BehindField = FindFrontField(Table, MonitorShifted);
% disp(BehindField)

AllFields   = FindFields(Table, MonitorShifted);

hndl   = figure;
drawPlane(Table, 'b', hndl);
drawPlane(MonitorShifted, 'm', hndl);
drawPlane(AllFields.Behind, '--.g', hndl);
drawPlane(AllFields.Forward, '--.r', hndl);