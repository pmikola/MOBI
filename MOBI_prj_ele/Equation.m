classdef Equation %< handle
    %Equations for the Newton - Raphson Method / finFet
    properties
    %
    end
    methods (Static)
        function out = p(psi)
            %p type carriers concentration near contacts
            out = C.ni.*exp((- psi)./C.V_t);
        end
        function out = n(psi)
            %n type carriers concentration near contacts
            out = C.ni.*exp((psi)./C.V_t);
        end
        function out = poisson_discrete(psi)
            %right side of discrete Poisson eq in i net node
            out = ((-C.h.^2 .* C.q) ./ C.eps_si) .* (Equation.p(psi) - Equation.n(psi) - C.Na);
        end
        function out = poisson_first_d(psi)
            %first derivative of discrete Poisson equation
            out = ((-C.h.^2 .* C.q) ./ C.eps_si ./ C.V_t) .* (Equation.p(psi) - Equation.n(psi));
        end
    end
end

