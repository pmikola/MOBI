function [len,output] = struct2cellArr(dir)
    i = 1;
    len = length(dir);
    for c = 1 : len;
        output{i} = dir(i).name;
        i = i+1;
end
