%  This is a run script

close all; clear; clc;

load InJsonData;
load CleanData_Set1Objects;

warning off;

[AllScenesQSRs, AllScenesObjs]   = GetAllScenesQSRs(InJsonData);