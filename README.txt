Connecting Simscape 1-D mechanical models and 3D models in Simscape Multibody.


This file contains example models showing how to connect 3D and 1D mechanical models. 
Connecting the models using Simscape Physical Signals ensures a lossless transfer 
of mechanical power between the two systems. This submission contains a library
that contains the interface blocks (rotational, translational), and example models
showing how to use them.

You need to ensure that your use of this interface is physically valid.  Connecting
a 3D mechanical model to a 1D mechanical model requires that you follow a few basic
rules:


1. Never add inertia directly to the node on the Simscape side of the interface.
  
   All masses in Simscape models live in an implicit inertial reference frame. A Simscape mechanical 
   circuit interfaced to a Simscape Multibody machine in general moves in an accelerated frame. A simulation 
   with such a circuit does not include the pseudoforces acting on the Simscape mass and inertia elements 
   as experienced in such a noninertial frame and thus violates Newton's second law of mechanics.

2. If you must model inertia in the Simscape network, connect it to the interface element 
   via a spring and damper connected in parallel.  Be aware that a Simscape circuit does not model 
   the motion of such bodies along or about axes orthogonal to the coupled primitive axis chosen 
   in the interfaced Joint.

3. Quantities sensed in Simscape (like translation at a node) may be offset from comparable quantities
   measured in Simscape Multibody.  This is because the initial position of the Simscape Multibody joint,
   which is determined during the assembly process, is not automatically conveyed to the Simscape network.
   Once you know this value (after updating the diagram), you can enter it into the Simscape network.



Copyright 2013-2016 The MathWorks, Inc.

