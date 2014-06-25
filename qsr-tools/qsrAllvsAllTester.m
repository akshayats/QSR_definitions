%  This is a functionality tester script - It will not work as a whole - NO
%  FUNCTIONALIY!

close all; clear; clc;

load InJsonData;

warning off;

[AllScenesQSRs, AllScenesObjs]   = GetAllScenesQSRs(InJsonData);