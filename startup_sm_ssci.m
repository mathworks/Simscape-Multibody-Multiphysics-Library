% Copyright 2016 The MathWorks, Inc.

addpath([pwd filesep 'Multibody_1D_Intf_Lib']);
addpath([pwd filesep 'Doc']);
addpath([pwd filesep 'Scripts_Data']);

cd Multibody_1D_Intf_Lib
if((exist('+mechPS')==7) && ~exist('mechPS_Lib'))
    ssc_build mechPS
end
cd ..

web('Extending_Simscape_Multibody_Demo_Script.html');