InFolderName   = '/home/akshaya/technical/tinker-box/data-io-organization/data/';
% InFileName     = 'Three_Days_s1o.json';
% InFileName     = 'All_Real_Data_s1o.json';
InFileName     = 'CleanData.json';
% FullPath       = [InFolderName, InFileName];
% InJsonData     = json.read(FullPath);

InJsonData   = readJSONData(InFileName, InFolderName, 'save');