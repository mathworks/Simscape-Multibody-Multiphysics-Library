% Code to plot simulation results from sm_ssci_electric_lift_trsn
% Copyright 2015-2019 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
try
    figure(h1_sm_ssci_electric_lift_trsn)
catch
    h1_sm_ssci_electric_lift_trsn=figure('Name', 'sm_ssci_electric_lift_trsn');
end

% Generate simulation results if they don't exist
if(~exist('simlog_sm_ssci_electric_lift_trsn','var'))
    sim('sm_ssci_electric_lift_trsn')
end

% Get simulation results
temp_LS_Lead = str2num(get_param([bdroot '/Lead Screw Joint'],'Lead'));
temp_LS_Dir = get_param([bdroot '/Lead Screw Joint'],'Direction');
temp_LS_Units = get_param([bdroot '/Lead Screw Joint'],'LeadUnits');

temp_slashInd = strfind(temp_LS_Units,'/');
temp_qUnits = temp_LS_Units(temp_slashInd+1:end);
temp_zUnits = temp_LS_Units(1:temp_slashInd-1);

simlog_t = simlog_sm_ssci_electric_lift_trsn.Lead_Screw_Joint.LSz.q.series.time;
simlog_qCyl = simlog_sm_ssci_electric_lift_trsn.Lead_Screw_Joint.LSz.q.series.values(temp_qUnits);
simlog_vVal = simlog_sm_ssci_electric_lift_trsn.Voltage_Source.v.series.values('V');

temp_zDir = 1;
if strcmp(temp_LS_Dir,'LeftHand')
    temp_zDir = -1;
end

simlog_zCyl = simlog_qCyl*temp_LS_Lead*temp_zDir;

% Plot results
simlog_handles(1) = subplot(2,1,1);
plot(simlog_t,simlog_zCyl,'LineWidth',1);
grid on
title('Lead Screw Extension');
ylabel(['Extension ' temp_zUnits]);
simlog_handles(2) = subplot(2,1,2);
plot(simlog_t,simlog_vVal,'LineWidth',1);
grid on
title('Motor Voltage');
ylabel('Voltage (V)');
xlabel('Time (s)');

linkaxes(simlog_handles,'x');

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_qCyl simlog_zCyl simlog_vVal

clear temp_LS_Dir temp_LS_Units temp_slashInd temp_zUnits
clear temp_LS_Lead temp_qUnits temp_zDir
