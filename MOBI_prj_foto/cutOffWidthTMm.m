function [output] = cutOffWidthTMm(m,Beta,i)

m = m - 1;

fun = @(W)-atan(sqrt((Beta(i).^2 - C.n_c.^2.*C.k0.^2)./ (C.n_f.^2.*C.k0.^2 - Beta(i).^2)) .*(C.n_f.^2./C.n_c.^2))... 
- atan(sqrt((Beta(i).^2 - C.n_s.^2.*C.k0.^2)./ (C.n_f.^2.*C.k0.^2 - Beta(i).^2)) .*(C.n_f.^2./C.n_s.^2))...
 + W .* sqrt(C.n_f.^2.*C.k0.^2 - Beta(i).^2) - m .* pi;

w0 = 0;
opts = optimoptions(@fsolve,'Algorithm', 'levenberg-marquardt');
W = fsolve(fun,w0,opts);

output = real(W);

end

