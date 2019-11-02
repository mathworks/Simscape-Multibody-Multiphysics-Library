% Code to plot simulation results from sm_lift_table_f2_hydr
%% Plot Description:
%
% The plots below show the height of the table and extension of the
% cylinder.  The position of the valve spool determines if the table is
% raised or lowered.  The limits of travel are reached when the piston
% reaches the ends of the cylinder.
%
% Copyright 2016-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_lift_table_f2_hydr', 'var')
    sim('sm_lift_table_f2_hydr')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_lift_table_f2_hydr', 'var') || ...
        ~isgraphics(h1_sm_lift_table_f2_hydr, 'figure')
    h1_sm_lift_table_f2_hydr = figure('Name', 'sm_lift_table_f2_hydr');
end
figure(h1_sm_lift_table_f2_hydr)
clf(h1_sm_lift_table_f2_hydr)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_lift_table_f2_hydr.PrismaticCylinderPiston.Pz.p.series.time;
simlog_cylz = simlog_sm_lift_table_f2_hydr.PrismaticCylinderPiston.Pz.p.series.values('m');
simlog_valve = simlog_sm_lift_table_f2_hydr.Valve.Area_PA.I.series.values('mm');

temp_hTable = logsout_sm_lift_table_f2_hydr.get('Table_Height');

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
plot(simlog_t, simlog_valve, 'LineWidth', 1)
grid on
title('Valve Spool Position')
ylabel('Position (mm)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_cylz simlog_valve temp_hTable

