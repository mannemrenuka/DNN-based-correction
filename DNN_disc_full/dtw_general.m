function [map, Dist]=dtw_general(d)
% DTW parameters --> w1 --> right, W2 45-degree W3 down; x-axis: n; y-axis m; 
w1=1; w2=1; w3=1;
r=Inf;
%
[N,M]=size(d);

% d
%%%%% initialization %%%%% 
D=round(max(max(d))*100)*ones(size(d));
bkptrn=zeros(size(d));
bkptrm=zeros(size(d));
wght=zeros(size(d)); 
D(1,1)=d(1,1);
wght(1,1) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=2:N %r+1
    D(n,1)=D(n-1,1)+w1*d(n,1);
    bkptrn(n,1)=n-1;bkptrm(n,1)=1;wght(n,1)=w1+wght(n-1,1);
end
for m=2:M %r+1
    D(1,m)=D(1,m-1)+w3*d(1,m);
    bkptrn(1,m)=1;bkptrm(1,m)=m-1;wght(1,m)=w3+wght(1,m-1);
end
% D'
% pause
for n=2:N
    for m=2:M
        if abs(n*M/N-m)<=r
%             [n m]
%             [D(n-1,m) ,D(n-1,m-1) ,D(n,m-1) ]
%             d(n,m)
%             [D(n-1,m)+w1*d(n,m),D(n-1,m-1)+w2*d(n,m),D(n,m-1)+w3*d(n,m)]
            D(n,m)=min([D(n-1,m)+w1*d(n,m),D(n-1,m-1)+w2*d(n,m),D(n,m-1)+w3*d(n,m)]);
            if D(n,m)==D(n-1,m)+w1*d(n,m)
                bkptrn(n,m)=n-1;bkptrm(n,m)=m;wght(n,m)=w1+wght(bkptrn(n,m),bkptrm(n,m));
            end
            if D(n,m)==D(n-1,m-1)+w2*d(n,m)
                bkptrn(n,m)=n-1;bkptrm(n,m)=m-1;wght(n,m)=w2+wght(bkptrn(n,m),bkptrm(n,m));
            end
            if D(n,m)==D(n,m-1)+w3*d(n,m)
                bkptrn(n,m)=n;bkptrm(n,m)=m-1;wght(n,m)=w3+wght(bkptrn(n,m),bkptrm(n,m));
            end
        end
%         wght(1:5,1:5)'
%         D'
%         pause;
    end % for -m 
end

% D

Dist = D(N,M);% / wght(N,M);


mapn=N;mapm=M;
while bkptrn(mapn(1),mapm(1))>1 || bkptrm(mapn(1),mapm(1))>1
    tempn=mapn(1);tempm=mapm(1);
    mapn=[bkptrn(tempn,tempm);mapn];mapm=[bkptrm(tempn,tempm);mapm];
end
mapn=[1;mapn];mapm=[1;mapm];
map=[mapn mapm];

Dist=Dist/length(mapn);