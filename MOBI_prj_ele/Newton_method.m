function [psi_iter,err_iter] = Newton_method(electric_vector_potential,L)
psi = electric_vector_potential;
err = 1;
i = 1;
psi_iter = zeros(C.num_net,C.num_net*2); %*2
err_iter = zeros(C.num_net);

    while  err > C.err_accuracy
        
        s = size(L);
        index = 1:s(1)+1:s(1)*s(2);
        J = L;
        J(index) = transpose(full(L(index))) - Equation.poisson_first_d(psi);
        
        %Boundary conditions on Si-SiO2 interface
        J(1,1) = 1 + (C.eps_si .* C.tox ./ (C.eps_ox .* C.h));
        J(1,2) = -(C.eps_si .* C.tox ./ (C.eps_ox .* C.h));
        
        %Boundary conditions in center of the finfet structure ( 0 )
        %For zero we need coeficcent vector in J matrix
        J(end,end) = -1;
        J(end,end - 1) =  1;
        
        b = minus((Equation.poisson_discrete(psi)),(Equation.poisson_first_d(psi) .* (psi))); % right side of the eq
        b(1) = C.Vg; % poisson first value
        b(end) = 0; %last poisson value
        psi_previous_iteration = psi;
        psi = linsolve(J,b); %solves the matrix equation AX = B, where B is a column vector.
        
        psi_flip = flip(psi); % mirrors of half finFet structure band diagram
        
        psi_cat = cat(1,psi,psi_flip); %glue for whole band diagram
        
        psi_iter(i,:) = psi_cat; %psi_cat %save values of psi
        
        err = max(abs((psi_previous_iteration - psi))); %error calc
        err_iter(i) = err;    % save error div
        i = i + 1;
    end
end



