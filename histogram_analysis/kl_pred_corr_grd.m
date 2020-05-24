strsub={'F1','F2','M1','M2'};
Segment1 = 'Upper';
kl_upper = {};
for sub=1:length(strsub)
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_fdm_norm.mat']);
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_ma_norm.mat']);
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_seg_norm.mat']);
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_grd_norm.mat']);
    mg = mean(diff_sub_grd);
    sg = std(diff_sub_grd);
    mf = mean(diff_sub_fdm);
    sf = std(diff_sub_fdm);
    mm = mean(diff_sub_ma);
    sm = std(diff_sub_ma);
    ms = mean(diff_sub_seg);
    ss = std(diff_sub_seg);
    kl_upper{sub,1} = KL(mg,mm,sg,sm);
    kl_upper{sub,3} = KL(mg,mf,sg,sf);
    kl_upper{sub,5} = KL(mg,ms,sg,ss);
    clear diff_sub_fdm;
    clear diff_sub_ma;
    clear diff_sub_seg;
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_fdm_norm_pred.mat']);
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_ma_norm_pred.mat']);
    load(['./'  Segment1 '/' strsub{sub} '/diff_sub_seg_norm_pred.mat']);
    mf = mean(diff_sub_fdm);
    sf = std(diff_sub_fdm);
    mm = mean(diff_sub_ma);
    sm = std(diff_sub_ma);
    ms = mean(diff_sub_seg);
    ss = std(diff_sub_seg);
    kl_upper{sub,2} = KL(mg,mm,sg,sm);
    kl_upper{sub,4} = KL(mg,mf,sg,sf);
    kl_upper{sub,6} = KL(mg,ms,sg,ss);
end
save('./kl_upper.mat','kl_upper')
function value = KL(mp,mq,sp,sq)
    value = log(sq/sp) + ((sp^2)+(mp-mq)^2)/(2*sq^2) - 0.5;
end