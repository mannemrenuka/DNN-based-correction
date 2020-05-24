function fin = my_func(x, y)
    N = length(x)
    H = [N, sum(x), sum(x.*x); sum(x), sum(x.*x), sum((x.*x).*x); sum(x.*x), sum((x.*x).*x), sum((x.*x).*(x.*x))]
    e = eig(H)
    f = -2*[sum(y); sum(x.*y); sum(y.*x.*x)];
    
    A = [ones(N, 1), x, x.*x];
    b = y;
    
    Aeq = [1, x(1), x(1)*x(1); 1, x(end), x(end)*x(end)];
    beq = [y(1); y(end)];
    %Hnew = H + eye(3)*0.000001;
    options = optimset('Algorithm','interior-point-convex');
    a = quadprog(H, f, A, b, Aeq, beq,[], [], [], options);
    fin = a(1) + (a(2).*x) + (a(3).*x.*x);
    
end