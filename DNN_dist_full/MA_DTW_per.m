Segment='Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
dtw_mean_all = {};
dtw_veri_all = {};
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
filepath1 = '../Autorun/';
per = [60:99,99.25,99.5,99.75,100];
% per = 60:99;
for sub=1:length(strsub)
    dtw_mean_sub = {};
    dtw_veri_sub = {};
    for fold=1:length(strfold)
        dtw_mean = {};
        dtw_veri = {};
%         dtw_std = {};
        load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Upper_' strsub{sub} '_fold_' num2str(fold) '_org.mat'], 'gnd_tr_upper_org');
        load([filepath1 Segment '/' strsub{sub} '/' strfold{fold} '/full_smooth_dev.mat'], 'full_smooth_dev');
%         load([filepath 'Lower_contours_Dev/' strsub{sub} '/' strfold{fold} '/Lower_' strsub{sub} '_fold' num2str(fold)  '.mat'], 'lower_contour');
%         load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Lower_' strsub{sub} '_fold_' num2str(fold) '.mat'], 'gnd_tr_lower');
        for perc = 1:length(per)
            load(['./'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per(perc)) '.mat'],'pxl_np');
            np = pxl_np(fold).np;
            load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Set_' num2str(per(perc)) '.mat']);
            l = length(gnd_tr_upper_org);
            l1 = floor(l*0.25);
%             l = length(Pred_Set{1,2});
            dtw_per = zeros(l1,1);
            dtw_per1 = zeros(l1,1);
            for frame=l-l1+1:l
%                 pre = lower_contour(frame).contour;
                gtc = gnd_tr_upper_org(frame).full_upper;
                pre = full_smooth_dev{frame,1};
%                 gtc = gnd_tr_lower(frame).full_lower;
                i = floor((np/2) + 1);
                distM = hfn_find_distance_matrix(gtc,Pred_Set{1,i}{1,frame-l+l1});
                distD = hfn_find_distance_matrix(gtc,pre);
                [~,score] = hfn_dtw_general(distM);
                [~,score1] = hfn_dtw_general(distD);
                dtw_per(frame-l+l1)=score;
                dtw_per1(frame-l+l1) = score1; 
            end
            dtw_mean{1,perc} = mean(dtw_per);
            dtw_veri{1,perc} = (mean(dtw_per)< mean(dtw_per1));
%             dtw_std{1,perc} = std(dtw_per);
        end
%         save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/dtw_mean.mat'],'dtw_mean');
%         save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/dtw_std.mat'],'dtw_std');
        dtw_mean_sub{fold,1} = dtw_mean;
        dtw_veri_sub{fold,1} = dtw_veri;
    end
    dtw_mean_all{sub,1} = dtw_mean_sub;
    dtw_veri_all{sub,1} = dtw_veri_sub;
end
save(['./'  Segment '/dtw_mean_all.mat'],'dtw_mean_all');