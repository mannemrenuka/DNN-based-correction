function R= fn_NormalGen(p1,p2,p3,n,pxl)
m=(p3(2)-p1(2))/(p3(1)-p1(1));
mn=-1/m;
if (m~=0)
    deltax=pxl/(n*sqrt(1+mn^2));
    x=p2(1)+deltax*(-n:n);
    y=mn*x+(p2(2)-mn*p2(1));
    R=[x' y'];
else
    x=p2(1)*ones(1,2*n +1);
    y=p2(2)+ (pxl/n)*(-n:n);
    R=[x' y'];
end

end

