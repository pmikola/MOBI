function [output] = integral_Em(betaTEm,W)

qm = sqrt((betaTEm.^2) - (C.n_c.^2).*(C.k0.^2));
hm =  sqrt((C.n_f.^2).*(C.k0.^2) - (betaTEm.^2));
pm = sqrt((betaTEm.^2) - (C.n_s.^2).*(C.k0.^2));

part1 = 1./(2.*qm);
part2 = 1./(2.*pm);
part3 = W./2.*(1 + ((qm./hm).^2) );
part4 = 1./hm.*( 1./2 - (qm.^2)./(2.*(hm.^2)) + qm./pm ) .* sin(hm.*W).*cos(hm.*W);
part5 = ( qm./(hm.^2) - 1./(2.*pm) + (qm.^2)./(2*pm.*(hm.^2)) ).*((sin(hm.*W)).^2);

output = part1 + part2 + part3 + part4 + part5;


end

