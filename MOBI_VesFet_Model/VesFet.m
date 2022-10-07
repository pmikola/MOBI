classdef VesFet
    %VESFET Summary of this class goes here
    %VESFET analitical model
    properties
      r %[nm] wymiar charakterystyczny
      tox % [nm] grubość tlenku
      h % wysokość tranzystora
      Nsub % koncentracja podłożu krzemowym (kanał typu n)
      Npoly % koncentracja domieszek w bramce (typ p)
      Wch % szerokość kanału
      Xd1 % Warstwa zubożona 1
      Xd2 % Warstwa zubożona 2
      Xdef% delta między Xd1 a Xd2 -> + nachodzą na siebie, 0 równe, - są oddalone warstwą aktywną kanału wch
      %Xdelta 
      Ws % szerokość szczeliny pionowej
      Idiff %Składowa dyfuzyjna prądu
      Idrift1 %Składowa unoszenia prądu
      Idrift2 %Składowa unoszenia prądu
      Id %prąd drenu
      un % ruchliwość elektronów w kanale (typ n)
      Vds % napięcie dren-źródło
      Vgs % napięcie bramki-źródło
      Cd % pojemność kondensatora MOS
      nCoeff % współczynnik n 
      Vth % napięcie włączenia
    end
    methods
        function obj = VesFet(Vds,Vgs)
            %VESFET konstrukt
            obj.Vds = Vds;
            obj.Vgs = Vgs;
            %obj.Xd1 = sqrt((2*C.eps_0*C.eps_si*(Vgs./C.q))./(C.q*C.Nsub));
            obj.Xd1 = C.X .* ((-C.Y ./ 2) + sqrt((C.Y ./ 2) .^ 2 - (Vgs - C.Vfb)));
            obj.Xdef = 2 .* (min(obj.Xd1,C.s0));
            obj.Cd = C.eps_si ./ obj.Xdef;
            obj.nCoeff = 1 + obj.Cd / C.C_ox;
            obj.Vth = C.Vth0 - C.av * (abs(Vds) .^ C.v);
            obj.Xd2 = obj.Xd1; % wersja dla takich samych napięć na obydwu bramkach
            obj.Idiff = VesFet.diffiusionCurrent(Vds,Vgs,obj.Vth,obj.nCoeff);
            obj.Idrift1 = VesFet.driftCurrent1(Vds,Vgs,obj.Vth,obj.nCoeff);
            obj.Idrift2 = VesFet.driftCurrent2(Vds,Vgs,obj.Vth,obj.nCoeff);
        end
    end
    methods (Static)
        function out = diffiusionCurrent(Vds,Vgs,Vth,nCoeff)
            %out = I0.*(C.Ws./C.L).*exp((Vgs-Vth)./(nCoeff.*C.V_t)).*(1-exp(-(Vds./C.V_t)));
            out = C.I0.*(C.Ws./C.L).* (((C.coeff1*Vds + C.coeff2).^C.coeff3) + exp((Vgs-Vth)./(nCoeff.*C.V_t))) .* (1-exp(-(Vds./C.V_t)));
        end
        function out = driftCurrent1(Vds,Vgs,Vth,nCoeff)
            % 0.05 V
            %Vsat = Vgs - C.Vfb - 2.*C.coeff3 + (C.eps_si.*C.q.*C.Nsub./(Cd.^2)) .* (1 - sqrt(1 + (2.*(Cd.^2).*(Vgs - C.Vfb))./(C.eps_si.*C.q.*C.Nsub)));
            %out = C.coeff7 * C.u_p * C.C_ox * C.Ws / C.L * (C.coeff10 * (((Vgs+C.coeff8) - Vth).^ C.coeff9)) / 2;
            temp_arr = ones(1,length(Vgs));
            for i = 1:length(Vgs)
                if Vgs(i) >= 0.5
                     temp = C.coeff8 .* C.u_p .* C.C_ox .* C.Ws ./ C.L .* (C.coeff10 .* (((Vgs(i)+C.coeff9) - Vth).^ C.coeff7)) ./ 2;
                 else
                     temp = C.I0 .* exp(C.coeff12.*Vgs(i)+C.coeff13.*Vds-Vth*(C.coeff14)./(nCoeff(i).*C.V_t)) .* (1-exp(-(Vds./C.V_t)));
                end
                temp_arr(i) = real(abs(temp));
                clear temp;
            end
            out = temp_arr;
         end
        function out = driftCurrent2(Vds,Vgs,Vth,nCoeff)
            % 0.8 v
            %Vsat = Vgs - C.Vfb - 2.*C.coeff3 + (C.eps_si.*C.q.*C.Nsub./(Cd.^2)) .* (1 - sqrt(1 + (2.*(Cd.^2).*(Vgs - C.Vfb))./(C.eps_si.*C.q.*C.Nsub)));
            temp_arr = ones(1,length(Vgs));
            for i = 1:length(Vgs) 
                if Vgs(i) >= 0.5
                    temp = C.coeff5 * C.u_p * C.C_ox * C.Ws / C.L * (C.coeff11 * (((Vgs(i)+C.coeff6) - Vth).^ C.coeff4)) / 2;
                else
                    temp = C.I0 .* exp(C.coeff15.*Vgs(i)+C.coeff16.*Vds-Vth*(C.coeff17)./(nCoeff(i).*C.V_t)) .* (1-exp(-(Vds./C.V_t)));
                end
                temp_arr(i) = real(abs(temp));
                clear temp;
            end
            out = temp_arr;
        end
    end
end

