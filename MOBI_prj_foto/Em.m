function [output] = Em(betaTEm,W,X)

qm = sqrt(betaTEm.^2 - C.n_c.^2.*C.k0.^2);
hm = sqrt(C.n_f.^2 .* C.k0.^2 - betaTEm.^2);
pm = sqrt(betaTEm.^2 - C.n_s.^2 .* C.k0.^2);

fun = {@(x)exp(-qm.*x);
       @(x)cos(hm.*x) - (qm./hm).*sin(hm.*x);
       @(x)(cos(hm.*W) + (qm./hm).*sin(hm.*W)).*exp(pm.*(x+W))};

 if X >= 0
     x = fun{1}(X);
 elseif -W < X && X < 0
     x = fun{2}(X); 
 elseif X <= -W
     x = fun{3}(X);
 end
 output = x;
end

