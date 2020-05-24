function [s,y,flag]= fn_Sub_Index_Generator(index,kernal)
    s=[];
    flag=0;
    if index==1000;
        s=zeros(1,kernal);
        y=100;
        flag=1;
        return;
    end
    if index>=0
        for i=(index-kernal+1:0)
            s=[s;(i:i+kernal-1)];
        end
        y=(kernal:-1:index+1)'/kernal;
    else
        for i=(-index-kernal+1:0)
            s=[s;-(i:i+kernal-1)];
        end 
        s=fliplr(s);
        y=(1:kernal+index)'/kernal;
    end
end