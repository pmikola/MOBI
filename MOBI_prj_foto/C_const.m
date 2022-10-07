function [output] = C_const(gamma_q,i)

output = 2.* (abs(1 - gamma_q(i,2).*...
exp(1i.*gamma_q(i,3))).^2).*...
((abs(sinh(gamma_q(i,1).*C.L))).^2);

end  