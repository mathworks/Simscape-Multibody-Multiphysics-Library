function startup_Multibody_Multiphysics_Library
% Copyright 2016-2024 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder);

if(curr_proj.Information.TopLevel)
    if (exist('Multibody_Multiphysics_Demo_Script.html','file'))
        web('Multibody_Multiphysics_Demo_Script.html');
    end
end