classdef C
    properties (Constant)
        L = 1e-2; % [ cm ]
        k = dlmread('comma_KL.txt');
        k0 = 2.*pi./C.lambda;
        %n_f = 2.1;
        %n_s = 2.80;
        n_f = 1.82;
        n_s = 1.808;
        n_c = 1;
        q = 1
        kappa = 0.292307692307691e-6;% [m]
        %lambda = (2*C.kappa*C.n_f)/C.q; % [ m ]
        lambda = 1.064e-6;
        alfa_L = [0.001,0.01,0.1,1]./C.L;
        ro = [0.1:0.1:0.5];
        fi = [0,1./2.*pi,pi,3./2.*pi];
        PumpPower = [0.001,0.01,0.1,1];
        Beta = linspace(C.k0.*C.n_s,C.k0.*C.n_f,1150);
    end
end

