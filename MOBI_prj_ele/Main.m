clear all
%coefficents of the left side of numerical equation
coeff_vec = [1,-2,1];
e = ones(C.num_net,1);
%L matrix
L = full(spdiags(coeff_vec.*e,-1:1,C.num_net,C.num_net));
x = linspace(0,16,C.num_net*2); %*2

psi = linspace(0,0,C.num_net);
psi = transpose(psi);

[psi_iter,err_iter] = Newton_method(psi,L);

figure(1)
for c = 1:200
    plot(x,psi_iter(c,:))
    hold on
end
xlabel('x [nm]')
ylabel('psi [V]')

clear c
figure(2)
c = 1:200;
semilogy(c,err_iter(c));
hold on

xlabel('Liczba iteracji')
ylabel('Błąd')




