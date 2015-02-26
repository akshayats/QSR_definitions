load('CleanData_QSR.mat');

QSRNrmlData   = DataNormalise(AllScenesQSRs, AllScenesObjs);

save('data/CleanData_QSR_Nrml.mat','QSRNrmlData');