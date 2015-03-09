% This is a Run Script
SAVFLAG   = false;
load('CleanData_QSR.mat');
% load('CleanData_Set1Objects_QSR.mat');

Set1Objects = {
			'Mouse';
			'Keyboard';
			'Monitor';
			'Papers';
			'Book';
			'Notebook';
			'Laptop';
			'Mobile';
			'Mug';
			'Glass';
			'Flask';
			'Bottle';
			'Jug'
		   };
	   
AllObjects = {
    'Book';
    'Bottle';
    'Flask';
    'Folder';
    'Glass';
    'Headphones';
    'Highlighter';
    'Jug';
    'Keyboard';
    'Keys';
    'Lamp';
    'Laptop';
    'Marker';
    'Mobile';
    'Monitor';
    'Mouse';
    'Mug';
    'Notebook';
    'Papers';
    'Pen';
    'PenStand';
    'Pencil';
    'Rubber';
    'SoftFish';
    'Telephone'
	};
QSRNrmlData   = DataNormalise(AllScenesQSRs, AllScenesObjs, sort(AllObjects));
% QSRNrmlData   = DataNormalise(AllScenesQSRs, AllScenesObjs, sort(Set1Objects));

if SAVEFLAG
% 	save('data/CleanData_Set1Objects_QSR_Nrml.mat','QSRNrmlData');
	save('data/NormalisedData.mat','QSRNrmlData');
end