function [ro,fi] = fileVariant(dir,j)
f1 = strfind(dir(j).name,'F1');
f2 = strfind(dir(j).name,'F2');
f3 = strfind(dir(j).name,'F3');
f4 = strfind(dir(j).name,'F4');
r01 = strfind(dir(j).name,'R01');
r1 = strfind(dir(j).name,'R1');
r2 = strfind(dir(j).name,'R2');
r3 = strfind(dir(j).name,'R3');
r4 = strfind(dir(j).name,'R4');
r5 = strfind(dir(j).name,'R5');
        
    if r01 ~= 0
        ro = 0.01;
    else
        if r1 ~= 0
            ro = 0.1;
        else
            if r2 ~= 0
                ro = 0.2;
            else
                if r3 ~= 0
                    ro= 0.3;
                else
                    if r4 ~= 0
                        ro= 0.4;
                    else
                        ro = 0.5;
                    end
                end
            end
        end
    end
    if f1 ~= 0
        fi = 0;
    else
        if f2 ~= 0
            fi = 1/(2*pi);
        else
            if f3 ~= 0
                fi= pi;
            else
                fi = 3/(2*pi);
            end
        end
    end
end

