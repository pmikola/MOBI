function [output] = g_zero(integralEmField,gamma_q,alfaLindex,pPindex,i,m,W,Windex,betaTEm,lim)

fSq = f_Sq(gamma_q,i,m); 
fRq = f_Rq(gamma_q,i,m);
constC = C_const(gamma_q,i);

qm = sqrt(betaTEm(m,Windex).^2 - C.n_c.^2.*C.k0.^2);
hm = sqrt(C.n_f.^2 .* C.k0.^2 - betaTEm(m,Windex).^2);
pm = sqrt(betaTEm(m,Windex).^2 - C.n_s.^2 .* C.k0.^2);

g_nom = @(z)((abs(fRq(z)).^2) + (abs(fSq(z)).^2));

EM_FieldAP = {@(x)(abs(exp(-qm.*x))).^2;
             @(x)(abs(cos(hm.*x) - (qm./hm).*sin(hm.*x))).^2;
             @(x)(abs((cos(hm.*W(m,Windex)) + (qm./hm).*sin(hm.*W(m,Windex))).*exp(pm.*(x + W(m,Windex))))).^2};

fun{1} = @(x,z)(g_nom(z).*EM_FieldAP{1}(x))...
    ./...
    (1+C.PumpPower(pPindex).*g_nom(z).*EM_FieldAP{1}(x)./constC);

fun{2} = @(x,z)(g_nom(z).*EM_FieldAP{2}(x))...
    ./...
    (1+C.PumpPower(pPindex).*g_nom(z).*EM_FieldAP{2}(x)./constC);

fun{3} = @(x,z)(g_nom(z).*EM_FieldAP{3}(x))...
    ./...
    (1+C.PumpPower(pPindex).*g_nom(z).*EM_FieldAP{3}(x)./constC);

fun4int_pokrycie = fun{1};
fun4int_falowod = fun{2}; 
fun4int_podloze = fun{3};

fun0 = g_nom;
fun1Integral = integral(fun0,0,C.L,'AbsTol',1e-12);

fun11 = integral2(fun4int_pokrycie,0,lim,0,C.L,'RelTol',1e-12);
fun12 = integral2(fun4int_falowod,-W(m,Windex),0,0,C.L,'RelTol',1e-12);
fun13 = integral2(fun4int_podloze,-lim,-W(m,Windex),0,C.L,'RelTol',1e-12);

fun1 = fun11 + fun12 + fun13;

fun2 = 2./real(integralEmField(m,Windex));

numerator = constC + 2.*C.alfa_L(alfaLindex).*fun1Integral;
denominator = (fun2.*fun1);

output = numerator./denominator;

end

