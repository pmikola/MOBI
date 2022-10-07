function [output] = beta_TEm(W,m)

fun = @(x)W.*sqrt(C.n_f.^2.*C.k0.^2 - x.^2) - m.*pi...
- atan(sqrt((x.^2 - C.n_s.^2.*C.k0.^2)./(C.n_f.^2.*C.k0.^2 - x.^2)))...
- atan(sqrt((x.^2 - C.n_c.^2.*C.k0.^2)./(C.n_f.^2.*C.k0.^2 - x.^2)));

x0 = C.k0.*C.n_c;

x = fsolve(fun,x0);

output = x;

end

