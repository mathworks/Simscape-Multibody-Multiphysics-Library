% Code to plot simulation results from sm_lift_table_f1_actf
%% Plot Description:
%
% The plots below show the amount of actuator force required to follow a
% specified motion profile for the actuator.
%
% Copyright 2016-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_lift_table_f1_actf', 'var')
    sim('sm_lift_table_f1_actf')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_lift_table_f1_actf', 'var') || ...
        ~isgraphics(h1_sm_lift_table_f1_actf, 'figure')
    h1_sm_lift_table_f1_actf = figure('Name', 'sm_lift_table_f1_actf');
end
figure(h1_sm_lift_table_f1_actf)
clf(h1_sm_lift_table_f1_actf)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_lift_table_f1_actf.PrismaticCylinderPiston.Pz.p.series.time;
simlog_cylz = simlog_sm_lift_table_f1_actf.PrismaticCylinderPiston.Pz.p.series.values('m');

temp_actForce = logsout_sm_lift_table_f1_actf.get('Actuator_Force');
temp_hTable = logsout_sm_lift_table_f1_actf.get('Table_Height');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_cylz, 'LineWidth', 1)
hold on
plot(temp_hTable.Values.Time, temp_hTable.Values.Data, 'LineWidth', 1)
hold off
grid on
title('Table Height and Cylinder Extension')
ylabel('Distance (m)')
legend({'Actuator Extension','Table Height'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(temp_actForce.Values.Time, temp_actForce.Values.Data, 'LineWidth', 1)
grid on
title('Required Actuator Force')
ylabel('Force (N)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_cylz temp_actForce temp_hTable 

