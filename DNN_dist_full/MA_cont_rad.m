Segment='Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
rad = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
per = [60:99,99.25,99.5,99.75,100];
load(['./'  Segment  '/dtw_mean_all.mat']);
dtw_rad_all = {};
best_per_all = {};
best_rad_all = {};
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
for sub=1:length(strsub)
    dtw_rad_sub = {};
    best_per = {};
    best_rad = {};
%     if sub == 4
%         per = per2;
%     else
%         per = per1;
%     end
    for fold=1:length(strfold)
        load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Upper_' strsub{sub} '_fold_' num2str(fold) '_org.mat'], 'gnd_tr_upper_org');
%             load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Lower_' strsub{sub} '_fold_' num2str(fold) '.mat'], 'gnd_tr_lower');
        dtw_rad_mean = {};
%         dtw_rad_std = {};
%         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/dtw_mean.mat']);
        [M ind]=min(cell2mat(dtw_mean_all{sub,1}{fold,1}));
        p = per(ind);
        load(['./'  Segment  '/' strsub{sub} '/pxl_np_' num2str(p) '.mat'],'pxl_np');
        np = pxl_np(fold).np;
        best_per{1,fold} = p;
        load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Set_' num2str(p) '.mat']);
%         l = length(Pred_Set{1,2});
        l = length(gnd_tr_upper_org);
        l1 = floor(l*0.25);
        dtw_rad = zeros(l1,1);
        i = floor((np/2) + 1);
        for r = 1:length(rad)
            for frame=l-l1+1:l
                gtc = gnd_tr_upper_org(frame).full_upper;
%                 gtc = gnd_tr_lower(frame).full_lower;
                xg=Pred_Set{1,i}{1,frame-l+l1}(:,1);
                yg=Pred_Set{1,i}{1,frame-l+l1}(:,2);
                [xs ys] = smooth_contours(xg, yg, rad(r));
                MA_cont =  [xs ys];
                distM=hfn_find_distance_matrix(gtc,MA_cont);
                [~,score] = hfn_dtw_general(distM);
                dtw_rad(frame-l+l1)=score;
            end
            dtw_rad_mean{1,r} = mean(dtw_rad);
%             dtw_rad_std{1,r} = std(dtw_rad);
        end
        dtw_rad_sub{fold,1} = dtw_rad_mean;
%         save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/dtw_rad_mean.mat'],'dtw_rad_mean');
%         save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/dtw_rad_std.mat'],'dtw_rad_std');
        [N ind1]=min(cell2mat(dtw_rad_mean));
        r1 = rad(ind1);
        best_rad{1,fold} = r1;
    end
    dtw_rad_all{sub,1} = dtw_rad_sub;
    best_per_all{sub,1} = best_per;
    best_rad_all{sub,1} = best_rad;
%     save(['./'  Segment  '/' strsub{sub} '/best_per.mat'],'best_per');
%     save(['./'  Segment  '/' strsub{sub} '/best_rad.mat'],'best_rad');
end
save(['./'  Segment  '/dtw_rad_all.mat'],'dtw_rad_all');
save(['./'  Segment  '/best_per_all.mat'],'best_per_all');
save(['./'  Segment  '/best_rad_all.mat'],'best_rad_all');
        
        