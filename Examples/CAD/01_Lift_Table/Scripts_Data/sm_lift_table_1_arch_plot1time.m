% Code to plot simulation results from sm_lift_table_1_arch
%% Plot Description:
%
% The plot below shows the height of the table and the extension of the
% cylinder.  The mechanism oscillates under the influence of gravity.
%
% Copyright 2016-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_lift_table_1_arch', 'var')
    sim('sm_lift_table_1_arch')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_lift_table_1_arch', 'var') || ...
        ~isgraphics(h1_sm_lift_table_1_arch, 'figure')
    h1_sm_lift_table_1_arch = figure('Name', 'sm_lift_table_1_arch');
end
figure(h1_sm_lift_table_1_arch)
clf(h1_sm_lift_table_1_arch)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_lift_table_1_arch.PrismaticCylinderPiston.Pz.p.series.time;
simlog_cylz = simlog_sm_lift_table_1_arch.PrismaticCylinderPiston.Pz.p.series.values('m');

temp_hTable = logsout_sm_lift_table_1_arch.get('Table_Height');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(temp_hTable.Values.Time, temp_hTable.Values.Data, 'LineWidth', 1)
grid on
title('Table Height')
ylabel('Height (m)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_cylz, 'LineWidth', 1)
grid on
title('Cylinder Extension')
ylabel('Extension (m)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_cylz simlog_cylz temp_hTable

