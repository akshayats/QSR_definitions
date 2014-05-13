close all; clear;
load('ObjData1')
Trajector   = MonitorShifted;

Nx   = 100; % Number of Points For Interpolation Along X Axis
FillPoints   = FindFillPoints(Trajector, Nx);