clear;
load('ObjData1')
Trajector   = TrajObj;
xvec   = Trajector(1,1),Trajector(4,1);
yvec   = Trajector(1,2):Trajector(2,2);
[A,B]   = meshgrid(xvec,yvec);