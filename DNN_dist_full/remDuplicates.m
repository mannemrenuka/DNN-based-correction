function [arr]=remDuplicates(arr)
    i=1; x=size(arr,1);
    while i<=(x-1),
        if sum(arr(i,:)==arr(i+1,:))==2,
            arr(i,:)=[]; x=x-1;
        else
            i=i+1;
        end
    end
end