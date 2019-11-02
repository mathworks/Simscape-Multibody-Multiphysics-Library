% Code to create copy of Simscape Multibody Multiphysics Library that
% excludes all examples and testing files. Resulting folder MPL_Libs can be
% copy/pasted into other projects.
%
% Copyright 2014-2018 The MathWorks, Inc.

folder_list = {...
    'Libraries'};

file_list = {...
    'README.txt',...
    'startup_sm_ssci.m'};

copyFolderName = 'MPL_Libs';
mkdir(copyFolderName)

for i= 1:length(folder_list)
    copyfile(folder_list{i},[copyFolderName filesep folder_list{i}]);
end

for i= 1:length(file_list)
    copyfile(file_list{i},[copyFolderName filesep file_list{i}]);
end

% Move to folder
cd(copyFolderName)

% Delete files
%{
deleteFileList = {...
    ['Scripts_Data' filesep 'sm_ssci_SaveFEXCopy.m'],
    ['Scripts_Data' filesep 'sm_ssci_SaveLibsOnly.m'],
    };

for i=1:length(deleteFileList)
    delstr = [pwd filesep deleteFileList{i}];
    disp(delstr);
    delete(delstr);
end
%}

%% Delete PowerPoint files

if(strcmp(pwd,['C:' filesep 'SMILLER' filesep 'TMW' filesep 'Simscape' filesep 'Demos' filesep 'sscMbody' filesep 'Contact_Forces']))
    error('Stop delete -- in source directory')
end

pptxFullList = dir('**/*.pptx');
for ppt_i=1:length(pptxFullList)
    delstr = [pptxFullList(ppt_i).folder '' filesep '' pptxFullList(ppt_i).name]; 
    disp(delstr);
    delete(delstr)
end


