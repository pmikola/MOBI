classdef C
    properties (Constant = true)
      % p type transistor VeSFET
      r = 50e-7; %[cm] promień bramki
      tox = 4e-7; % [cm] grubość tlenku
      h = 200e-7; %wysokość tranzystora
      Nsub = 5e+17; %[cm^-3] koncentracja domieszek w podłożu
      Npoly=5e+18; %[cm^-3] koncentracja domieszek w bramce
      T = 300; %[K] temperature
      k_B = 1.380658e-23; % [J/K] %Stała Boltzmana
      q = 1.602177335e-19; %[C] ładunek elementarny
      V_t = (C.k_B*C.T)./C.q; %napięcie termiczne
      u_p = 470; %ruchliwość elektronów w kanale (typ n) LD
      vtherm = 3./2.*C.k_B.*C.T; % prętkość termiczna nośników - w pasmie przewodnictwa 1/2*me*vth^2 = 3/2*kb*T (Średnia
      ni = 1e+10; % [m^-3] intrinsic concentration of semiconductor
      eps_0 = 8.854187717e-12; %[F/m] electric permeability of the vaccum 
      eps_ox = 3.9 * C.eps_0; %[F/m] electric permeability SiO2
      eps_si = 11.7 * C.eps_0; %[F/m] electric permeability Si
      C_ox = C.eps_ox/C.tox; % poj tlenku krzemu
      
      rdiag = 2*(C.r * sqrt(4+2*sqrt(2))); % wybrany współczynnik do szerokości kanału ws
      
      phi_f = -C.V_t*log(C.Nsub./C.ni); %
      phi_m = 4.1; %[eV] Aluminium
      Eg_si = 1.12; %[eV] Si przerwa energetyczna
      Vbs = 0; % napięcie podłoże źródło
      Vfb = C.V_t*log(C.Nsub.*C.Npoly./((C.ni).^2)); %
      Qb = -(sqrt(2*C.q.*C.Nsub.*C.eps_si*(abs(2*C.phi_f) - C.Vbs)));
      K = C.u_p.*C.C_ox;
      Beta = C.K.*C.Ws./C.L;
      Qss = C.Qb; % przyjęte tymczasowo
      gamma = (sqrt(2*C.q*C.eps_si*C.Nsub))./C.C_ox;
      phi_ms = -0.56-C.phi_f; % typ p w Si
      Vth = abs(C.Vfb + 2.*C.phi_f + sqrt(4.*C.eps_si.*C.q.*C.Nsub.*C.phi_f)./(C.C_ox));
      xi = (2 - pi/2)./(sqrt(2)-1);
      s0 = C.xi*C.r./2;
      Cd0 = C.eps_si ./ (2 .* C.s0);
      X = sqrt(2 .* C.eps_si ./ (C.q .* C.Nsub));
      eff = C.q .* C.Nsub ./ C.C_ox;
      Y = C.X .* C.eff;
      Vth0 = C.Vfb - C.eff*C.s0 - ((C.s0/C.X).^2);
      av = 0.35;
      v = 0.75;
      p = 0.04e+10; % przewdoność
      fc = 2.6; %współczynnik dopasowania 0
      Go = C.h ./ C.p; %konduktancja kanału
      L = 2 .* C.s0; %długość kanału - bok oktagonu z promienia r
      Ws = 2 .* C.s0; %sqrt(2*C.eps_si./C.q.*C.Nsub); % szerokość szczeliny pionowej
      
      %współczynnik dopasowania prądu wyłączenia
      coeff1 = 52; 
      coeff2 = 16; 
      coeff3 = 1.94; 
      
      %Współczynniki dopasowania dla charakterystyki przejściowej dla Vds
      %0.05 V
      coeff4 = 1.87;
      coeff5 = 0.11;
      coeff6 = 0.44;
      coeff11 = 0.02;
      coeff12 = 28;
      coeff13 = 117;
      coeff14 = 0.001;
      
      %Współczynniki dopasowania dla charakterystyki przejściowej dla Vds
      %0.8 V
      coeff7 = 3.1;
      coeff8 = 0.79;
      coeff9 = 0.91;
      coeff10 = 0.00042;
      coeff15 = 29;
      coeff16 = 10;
      coeff17 = 0.001;
      
      I0 = (C.fc .*C.Go.*C.Cd0) ./ C.C_ox; % current zero
      
      
      %Dane z pliku referencyjnego
      UGS1 = [0:0.05:0.8]; % Vgs
      ID1 = [8.31453018294765e-12,3.64116710481484e-11,1.54744569220292e-10,6.33951215800772e-10,2.47724415943447e-09,9.07219524796212e-09,3.02897787312306e-08,8.84327327983666e-08,2.15853074676509e-07,4.31857232936063e-07,7.23134868603505e-07,1.05826066341566e-06,1.41141097842751e-06,1.76838964720238e-06,2.12343483216778e-06,2.47531225210931e-06,2.82395071306287e-06]; % Ids
      UDS1 = 0.05; % Vds
      UGS2 = [0:0.05:0.8]; % Vgs
      ID2 = [8.18923026385424e-11,3.68068809220443e-10,1.60114093506645e-09,6.65531948591136e-09,2.58753490338899e-08,9.04361043273878e-08,2.70254173714001e-07,6.64670321431447e-07,1.34952314983997e-06,2.34285812871811e-06,3.61722618646915e-06,5.13831064653462e-06,6.87076785185443e-06,8.78280014339926e-06,1.08482399599072e-05,1.30426437033822e-05,1.53414961127756e-05]; %Ids
      UDS2 = 0.8; % Vds
      UGS3 = 0; %Ugs off
      UDS3 = [0,0.0250000000000000,0.0500000000000000,0.0750000000000000,0.100000000000000,0.150000000000000,0.200000000000000,0.250000000000000,0.300000000000000,0.350000000000000,0.400000000000000,0.450000000000000,0.500000000000000,0.550000000000000,0.600000000000000,0.650000000000000,0.700000000000000,0.750000000000000,0.800000000000000] % Vds
      ID3 = [0,5.41471507358454e-12,8.31453795239097e-12,1.01742883201573e-11,1.20000000000000e-11,1.42665657739777e-11,1.70253312730962e-11,2.00710004754229e-11,2.34379097886104e-11,2.71474159432280e-11,3.12424913339258e-11,3.57481029175905e-11,4.06974623721326e-11,4.61276164514214e-11,5.20907391006411e-11,5.86312577037610e-11,6.55000000000000e-11,7.34000000000000e-11,8.18923026385424e-11]; %Ioff
      
    end
end

