cd(fileparts(which('sm_ssci_01_slider_crank.slx')));
cd('html')
publish_all_html

cd(fileparts(which('sm_lift_table_0_import.slx')));
cd('html');
publish_all_html

cd(fileparts(which('sm_ssci_electric_lift_trsn.slx')));
cd('html');
publish_all_html

% Copyright 2016-2022 The MathWorks(TM), Inc.

function publish_all_html
filelist_m=dir('*.m');

filenames_m = {filelist_m.name};

warning('off','Simulink:Engine:MdlFileShadowedByFile');

for i=1:length(filenames_m)
    if ~(strcmp(filenames_m{i},'publish_all_html.m'))
    publish(filenames_m{i},'showCode',false)
    end
end
end