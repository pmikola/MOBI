function [output] = f_Sq(gamma_q,i,m)
    if (mod(m,2))
        output = @(z)sinh(-gamma_q(i,1).*(z-(C.L./2))) + gamma_q(i,2).*exp(gamma_q(i,3).*1i).*sinh(gamma_q(i,1).*(z + (C.L./2)));
    else
        output = @(z)sinh(gamma_q(i,1).*(z-(C.L./2))) + gamma_q(i,2).*exp(gamma_q(i,3).*1i).*sinh(gamma_q(i,1).*(z + (C.L./2)));
    end
end

