%%CODE TO OBTAIN THE GRAY VALUE AT A GIVEN X-Y COORDINATE IN A CERTAIN
%%FRAME, USING BILINEAR INTERPOLATION

function [val]=getVal(points,frame)
    x=points(1); y=points(2);
    arx(1)=floor(x); arx(2)=ceil(x);
    ary(1)=floor(y); ary(2)=ceil(y);
    v=zeros(4,1);
    if ((ary(1)>68)||(ary(2)>68)||(arx(1)>68)||(arx(2)>68))
        val=0;
        return
    end
    v(1)=frame(ary(1),arx(1));
    v(2)=frame(ary(1),arx(2));
    v(3)=frame(ary(2),arx(1));
    v(4)=frame(ary(2),arx(2));
    
    if arx(1)==arx(2),
            val=v(1)+(y-ary(1))*(v(4)-v(1))/(ary(2)-ary(1));
    elseif ary(1)==ary(2),
            val=v(1)+(x-arx(1))*(v(4)-v(1))/(arx(2)-arx(1));
    else
        val=[arx(2)-x, x-arx(1)]*[v(1),v(2);...
        v(3),v(4)]*[ary(2)-y; y-ary(1)]/((arx(2)-arx(1))*(ary(2)-ary(1)));
    end
end