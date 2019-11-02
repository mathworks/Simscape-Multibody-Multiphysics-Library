% Code to plot simulation results from sm_lift_table_t2_elec
%% Plot Description:
%
% The plots below show the height of the table and extension of the lead
% screw.  The voltage applied to the motor determines if the table is
% raised or lowered.  The table stops moving when the lead screw reaches
% its limits.
%
% Copyright 2016-2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_lift_table_t2_elec', 'var')
    sim('sm_lift_table_t2_elec')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_lift_table_t2_elec', 'var') || ...
        ~isgraphics(h1_sm_lift_table_t2_elec, 'figure')
    h1_sm_lift_table_t2_elec = figure('Name', 'sm_lift_table_t2_elec');
end
figure(h1_sm_lift_table_t2_elec)
clf(h1_sm_lift_table_t2_elec)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
temp_LS_Lead = str2num(get_param([bdroot '/Lead Screw Joint'],'Lead'));
temp_LS_Dir = get_param([bdroot '/Lead Screw Joint'],'Direction');
temp_LS_Units = get_param([bdroot '/Lead Screw Joint'],'LeadUnits');

temp_slashInd = strfind(temp_LS_Units,'/');
temp_qUnits = temp_LS_Units(temp_slashInd+1:end);
temp_zUnits = temp_LS_Units(1:temp_slashInd-1);

simlog_t = simlog_sm_lift_table_t2_elec.Lead_Screw_Joint.LSz.q.series.time;
simlog_qCyl = simlog_sm_lift_table_t2_elec.Lead_Screw_Joint.LSz.q.series.values(temp_qUnits);
simlog_tMot = simlog_sm_lift_table_t2_elec.DC_Motor.Rotational_Electromechanical_Converter.t.series.values('N*m');

temp_zDir = 1;
if strcmp(temp_LS_Dir,'LeftHand')
    temp_zDir = -1;
end

simlog_cylz = simlog_qCyl*temp_LS_Lead*temp_zDir/1000;

temp_hTable = logsout_sm_lift_table_t2_elec.get('Table_Height');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_cylz, 'LineWidth', 1)
hold on
plot(temp_hTable.Values.Time, temp_hTable.Values.Data, 'LineWidth', 1)
hold off
grid on
title('Table Height and Lead Screw Extension')
ylabel('Distance (m)')
legend({'Lead Screw Extension','Table Height'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_tMot, 'LineWidth', 1)
grid on
title('Motor Torque')
ylabel('Torque (N*m)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_qCyl simlog_tMot simlog_cylz
clear temp_hTable temp_zDir temp_slashInd 
clear temp_LS_Lead temp_LS_Dir temp_LS_Units temp_qUnits temp_zUnits

