% Code to plot simulation results from sm_lift_table_t1_actt
%% Plot Description:
%
% The plots below show the amount of actuator torque required to follow a
% specified motion profile for the actuator.
%
% Copyright 2016-2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_lift_table_t1_actt', 'var')
    sim('sm_lift_table_t1_actt')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_lift_table_t1_actt', 'var') || ...
        ~isgraphics(h1_sm_lift_table_t1_actt, 'figure')
    h1_sm_lift_table_t1_actt = figure('Name', 'sm_lift_table_t1_actt');
end
figure(h1_sm_lift_table_t1_actt)
clf(h1_sm_lift_table_t1_actt)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_lift_table_t1_actt.Lead_Screw_Extension.Pz.p.series.time;
simlog_screwz = simlog_sm_lift_table_t1_actt.Lead_Screw_Extension.Pz.p.series.values('m');

temp_actTorque = logsout_sm_lift_table_t1_actt.get('Actuator_Torque');
temp_hTable = logsout_sm_lift_table_t1_actt.get('Table_Height');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_screwz, 'LineWidth', 1)
hold on
plot(temp_hTable.Values.Time, temp_hTable.Values.Data, 'LineWidth', 1)
hold off
grid on
title('Table Height')
ylabel('Distance (m)')
legend({'Actuator Extension','Table Height'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(temp_actTorque.Values.Time, temp_actTorque.Values.Data, 'LineWidth', 1)
grid on
title('Required Actuator Torque')
ylabel('Torque (N*m)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_screwz temp_hTable temp_actTorque

