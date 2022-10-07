classdef C
    properties (Constant = true)
       %transistor stucture params
       num_net = 500; %Net element number
       h = C.tsi ./ C.num_net; %step size
       err_accuracy = 1e-13;
       T = 300; %[K] temperature
       k_B = 1.380658e-23; % [J/K] %Boltzman constant
       q = 1.602177335e-19; %[C] elementary charge
       V_t = (C.k_B*C.T)/C.q; %thermal voltage
       tox = 1.3e-9; % thickness of Sillicon Oxide
       tsi = 16e-9; % thickness of Si
       phi_ms = 0; %WORK difference betwen metal gate and semiconductor
       Na = 2e+24; % [m^-3] acceptor concentration of admixture in the active area
       
       ni = 1e+10; % [m^-3] intrinsic concentration of semiconductor
       Vg = 0.8; %[V] Gate Voltage
       
       eps_0 = 8.854187717e-12; %[F/m] electric permeability of the vaccum 
       eps_ox = 3.9 * C.eps_0; % electric permeability SiO2
       eps_si = 11.7 * C.eps_0; %electric permeability Si
    end
end

