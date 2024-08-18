%% Electric Motor with Multibody Ports
%
% This example shows how to extend Simscape Multibody models with
% additional physical effects by connecting directly to the frames in the
% multibody model. An electric actuator raises and lowers a lift table by
% extending and contracting.  The table is a four-bar mechanism which moves
% vertically and horizontally.
%
% This method of extending Simscape Multibody models uses a Transform
% Sensor and External Force and Torque blocks to connect to custom Simscape
% blocks that model mechanical and electrical effects. This method does not
% require adding or removing ports to the joint block. The physical effects
% are modeled using custom Simscape blocks that use the same equations as
% in the Foundation library. The code is open and can be modified.
% 
% To verify that consistent positions are used in the multibody model and
% the hardstop on the leadscrew, click on the hyperlink to change the initial
% height of the table and rerun the simulation. The simulation results and
% animation show that the hard stops limit the travel of the screw
% correctly.
%
%
% Copyright 2016-2024 The MathWorks, Inc.


%% Model

open_system('sm_ssci_electric_lift_trsn')

set_param(find_system('sm_ssci_electric_lift_trsn','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% DC Motor Subsystem
%
% This electrical motor is constructed using Simscape blocks from the
% Foundation library.  Since none of these blocks require position
% information, no custom blocks are required to add this effect to the
% multibody model.

set_param('sm_ssci_electric_lift_trsn/DC Motor','LinkStatus','none')
open_system('sm_ssci_electric_lift_trsn/DC Motor','force')

%% Rotational Simscape Multibody Subsystem
%
% Transform Sensor and External Force and Torque blocks are used to connect
% the physical effects modeled in Simscape with the multibody model.  An
% advantage of this method is that it does not require adjusting settings
% within the joint block, which makes it easy to add and remove. However,
% the mathematical operations prescribed by the joint are not reused in
% this configuration, so there is a small additional mathematical cost to
% this method.
%
% Simscape Physical Signals are used to connect the Simscape Multibody
% model to the Simscape model.  No algebraic loop is created and
% the equations from both portions of the model are solved simultaneously.
set_param('sm_ssci_electric_lift_trsn/DC Motor/Rotational Simscape Multibody','LinkStatus','none')
open_system('sm_ssci_electric_lift_trsn/DC Motor/Rotational Simscape Multibody','force')

%% Hard Stop Friction Subsystem
%
% Mechanical joint limits are modeled using custom Simscape blocks that
% use the same equations as in the Foundation library.  The code is open
% and can be modified. Position information is communicated to the hard
% stop, and the resulting force is applied to the joint. No algebraic loop
% is created and the equations from both models are solved simultaneously.

set_param('sm_ssci_electric_lift_trsn/Hard Stop Friction','LinkStatus','none')
open_system('sm_ssci_electric_lift_trsn/Hard Stop Friction','force')

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
set_param('sm_ssci_electric_lift_trsn/Four Bar','LinkStatus','none')
open_system('sm_ssci_electric_lift_trsn/Four Bar','force')

%% Simulation Results from Simscape Logging
%
% The table is lifted and lowered in stages.  The upper and lower limits on
% the actuator extension indicates that the leadscrew has reached the ends
% of its range of travel.
sm_ssci_electric_lift_trsn_plot1ext;

%% Mechanics Explorer Animation
%
% <<sm_ssci_electric_lift_trsn_mechexp.gif>>


%%

%clear all
close all
bdclose all
