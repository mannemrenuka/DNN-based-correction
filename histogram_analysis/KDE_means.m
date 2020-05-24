strsub={'F1','F2','M1','M2'};
% strsub = {'F2'};
Segment = 'Lower';
figure;
cfl = 18;
c = 2;
fo = 20;
close all;
x_all = [];
for sub=1:length(strsub)
    load(['./'  Segment '/' strsub{sub} '/diff_sub_fdm_lower_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_ma_lower_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_seg_lower_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_grd_lower_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_lower_norm.mat']);
    x_list = [];
    x_list = [x_list round(mean(diff_sub),3)];
    x_list = [x_list round(mean(diff_sub_ma),3)];
    x_list = [x_list round(mean(diff_sub_fdm),3)];
    x_list = [x_list round(mean(diff_sub_seg),3)];
    x_list = [x_list round(mean(diff_sub_grd),3)];
    x_all = [x_all; x_list];
end