function [output] = cutOffWMin(m,k,i)

output = ((m.*pi + atan((C.n_s.^2 - 1)./(C.n_f.^2 - C.n_s.^2)).^(1./2)).*(C.n_f.^2 - C.n_s.^2).^(1./2))./(k(i,4)./C.L);

end

