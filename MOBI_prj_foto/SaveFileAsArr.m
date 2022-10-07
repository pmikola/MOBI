function [output] = SaveFileAsArr(varName,accessType,format)
        d = uigetdir(pwd, 'Select a folder');
        dir_txt = dir(fullfile(d, '*.txt'));
        dir_DTA = dir(fullfile(d, '*.DTA'));
        
        dir_txt = {dir_txt.name};
        dir_DTA = {dir_DTA.name};
        
        i = length(dir_txt);
        j = length(dir_DTA);
        for c = 1:i
            Data = fileread(dir_txt{c});
            Data = strrep(Data, ',', '.');
            s = strcat('comma_',dir_txt{c});
            FID = fopen(s, 'w');
            fwrite(FID, Data, 'char');
            fclose(FID);
        end
        
        fileID = fopen(fileName,accessType);
        formatSpec = format;
        output = fscanf(fileID,formatSpec);
        fclose(fileID);
end

