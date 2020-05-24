%Intensity Profile Generator
np= 5;
pxl = 5;
Segment = 'Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4','Fold5'};
% strsub = {'F1'};
thre = (2*pxl)/(2*np);
 for sub=1:length(strsub)
     diff_sub_fdm = [];
     diff_sub_ma = [];
     diff_sub_grd = [];
     for fold=1:length(strfold)
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_upper_pxl_np_5_grd.mat']);
         load(['/home/spire/Documents/DNN_journal/Autorun_New_Linux/Autorun_Ton1/' strsub{sub} '/' strfold{fold} '/Dev.mat']);
         load(['../Autorun/Upper_contours_Dev/' strsub{sub} '/' strfold{fold} '/Upper_' strsub{sub} '_fold' num2str(fold)  '_sm.mat'], 'upper_contour_smooth');
         fdm = upper_contour_smooth;
         clear upper_contour_smooth;
         load(['/home/spire/Documents/DNN_journal/ATB_trainining_janwon_contours/Autorun/Upper_contours_Dev/' strsub{sub} '/' strfold{fold} '/Upper_' strsub{sub} '_fold' num2str(fold)  '_sm.mat'], 'upper_contour_smooth');
         ma = upper_contour_smooth;
         clear upper_contour_smooth;
         for frame=1:length(Dev_Complete_Data_upper_pxl_5)
             for p=1:length(Dev_Complete_Data_upper_pxl_5{frame,3}(:,1))
                x_c = Dev_Complete_Data_upper_pxl_5{frame,1}(p,:);
                y_c = Dev_Complete_Data_upper_pxl_5{frame,2}(p,:);
                ins = Dev_Complete_Data_upper_pxl_5{frame,3}(p,:);
                gridpoints=[x_c;y_c];
                xy_f = hfn_interX(fdm(frame).upper_contour',gridpoints);
                if ~isempty(xy_f)
                    nind_f = ceil((pdist2([x_c(1),y_c(1)],[xy_f(1),xy_f(2)]))/thre);
                    if nind_f-1~=0 && nind_f+2<=10
                        diff_sub_fdm = [diff_sub_fdm ins(nind_f)-ins(nind_f+1) ins(nind_f-1)-ins(nind_f+1) ins(nind_f)-ins(nind_f+2)];
                    end
                end
                xy_m = hfn_interX(ma(frame).upper_contour',gridpoints);
                if ~isempty(xy_m)
                    nind_m = ceil((pdist2([x_c(1),y_c(1)],[xy_m(1),xy_m(2)]))/thre);
                    if nind_m-1~=0 && nind_m+2<=10
                        diff_sub_ma = [diff_sub_ma ins(nind_m)-ins(nind_m+1) ins(nind_m-1)-ins(nind_m+1) ins(nind_m)-ins(nind_m+2)];
                    end
                end
                diff_sub_grd = [diff_sub_grd ins(np)-ins(np+2)];
             end
         end
     end
     save(['./'  Segment '/' strsub{sub} '/diff_sub_fdm.mat'],'diff_sub_fdm');
     save(['./'  Segment '/' strsub{sub} '/diff_sub_ma.mat'],'diff_sub_ma');
     save(['./'  Segment '/' strsub{sub} '/diff_sub_grd.mat'],'diff_sub_grd');
 end