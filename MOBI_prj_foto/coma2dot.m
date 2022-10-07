function output = coma2dot(dir,len)
i = 0;
    for c = 1 : len
        i = i + 1;
        s3 = strfind(dir(i).name,'.DTA');
        if length(s3) ~= 0
            s3 = dir(i).name;
            s3_len = length(s3);
            s3_len = s3_len - 3;
            s1 = s3(1:s3_len);
            s1 = strcat(s1,'txt');
            copyfile(s3,s1);
            output{1,i} = s1;
            clear s3 s3_len s1;
        else
           s2 = strfind(dir(i).name,'comma_');
            if length(s2) == 0
                s1 = strcat('comma_',dir(i).name);
                if exist(s1) == 0
                    Data = fileread(dir(i).name);
                    Data = strrep(Data, ',', '.');
                    FID = fopen(s1, 'w');
                    fwrite(FID, Data, 'char');
                    fclose(FID);
                else
                    % do nothing
                end
            output{1,i} = readmatrix(s1);
            clear s1 s2 Data
            else
                % do nothing
            end
        end
    end
end

