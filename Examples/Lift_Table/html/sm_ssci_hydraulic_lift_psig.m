%% Hydraulic Actuator with Physical Signal Ports
%
% This example shows how to extend Simscape Multibody models with
% additional physical effects using joint actuation and joint sensing. A
% hydraulic actuator raises and lowers a lift table by extending and
% contracting.  The table is a four-bar mechanism which moves vertically
% and horizontally.
%
% This method of extending Simscape Multibody models uses joint sensing and
% joint actuation to connect to custom Simscape blocks that model
% mechanical and hydraulic effects. The physical effects are modeled using
% custom Simscape blocks that use the same equations as in the Foundation
% library. The code is open and can be modified.
% 
% To verify that consistent positions are used in the multibody model and
% the hydraulic actuator, click on the hyperlink to change the initial
% height of the table and rerun the simulation. The simulation results and
% animation show that the hard stops limit the travel of the piston
% correctly.
%
%
% Copyright 2016-2018 The MathWorks, Inc.


%% Model

open_system('sm_ssci_hydraulic_lift_psig')

set_param(find_system('sm_ssci_hydraulic_lift_psig','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Hydraulic Actuator Subsystem
%
% This hydraulic actuator is constructed using custom Simscape blocks that
% use the same equations as in the Foundation library.  The code is open
% and can be modified. Position information is communicated to the hard
% stop and the hydraulic chambers, and the resulting force is applied to
% the joint. No algebraic loop is created and the equations from both
% models are solved simultaneously.

open_system('sm_ssci_hydraulic_lift_psig/Hydraulic Actuator','force')

%% Four Bar Subsystem
%
% This models the lift table as a four-bar mechanism.  The initial height
% of the table is set using the position state target for the Y-prismatic
% degree of freedom in the 6-DOF Joint labeled Initial Table Height.  That
% value is set in the mask for this subsystem.
%
% The 6-DOF Joint has no effect on the dynamics or kinematics during
% simulation.  It is only used to set the initial position of the mechanism
% along an axis where we have not defined a joint.

open_system('sm_ssci_hydraulic_lift_psig/Four Bar','force')

%% Simulation Results from Simscape Logging
%
% The table is lifted and lowered in stages.  The upper and lower limits on
% the cylinder extension indicates that the cylinder has reached the ends
% of its range of travel.
sm_ssci_hydraulic_lift_psig_plot1ext;

%% Mechanics Explorer Animation
%
% <<sm_ssci_hydraulic_lift_psig_mechexp.gif>>

%%

%clear all
close all
bdclose all
