function CrctdJsonData   = fieldCorrectJSONStruct(OrgJsonData)
	CrctdJsonData   = OrgJsonData;
	AllFieldNames   = fieldnames(CrctdJsonData);
	NumOfData       = length(CrctdJsonData);
	oldname         = [];
	newname         = [];
	% Condition to Change Field Name and Stored Changed Name
	for i = 1:length(AllFieldNames)
		iOldname   = AllFieldNames{i};
		iNewname   = strrep(iOldname,'0x2D', '_');
		if ~strcmp(iOldname, iNewname)
			oldname   = [oldname;{iOldname}];
			newname   = [newname;{iNewname}];
		end
	end
	% Replacing Field Names
	for d = 1:NumOfData
		for n = 1: length(newname)
			CrctdJsonData(d).(newname{n})   = CrctdJsonData(d).(oldname{n});
		end
	end
	% Remove Defunct Old Fields (With Bad Names)
	for n = 1: length(oldname)
		CrctdJsonData   = rmfield(CrctdJsonData, oldname{n});
	end
	
end