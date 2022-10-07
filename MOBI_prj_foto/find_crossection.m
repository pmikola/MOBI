function [output] = find_crossection(WT1,WT2,BetaT1,precision,number_of_modes) 
m = number_of_modes;
solution_array = zeros(length(m),length(m));
i = 1;
j = 1;
    while i <= length(m) && j <= length(m)
         poc = find(abs(WT1(i,:)-WT2(j,1))<precision) %position of crossection - search for W that are same for two TEm modes nex to each other
        if length(poc) > 1
            precision = precision - precision*0.001;
                j = j - 1;
            clear poc1
            if precision <= 1e-10
                j = j + 1;
                solution_array(i,j) = 0;
                precision = 1e-8;
                clear poc1
            end
        elseif length(poc) == 1
            if real(BetaT1(i,poc)) < C.k0*C.n_s
                solution_array(i,j) = C.k0*C.n_s;
            elseif real(BetaT1(i,poc)) > C.k0*C.n_f
                solution_array(i,j) = C.k0*C.n_f;
            else
            solution_array(i,j) =  real(BetaT1(i,poc))
            clear poc1
            end
        elseif isempty(poc) == 1
            precision = precision + precision*1.001;
            j = j - 1;
            if precision >= 1e-7
                j = j + 1;
                solution_array(i,j) = 0;
                precision = 1e-8;
                clear poc1
            end
        end
        j = j + 1;
        if j <= length(m)
            % do nothing
        else
            j = 1;
            i = i + 1;
        end
    end
    output = solution_array;
end


