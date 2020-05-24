%Intensity Profile Generator
np= 5;
pxl = 5;
Segment = 'Lower';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'F1'};
thre = (2*pxl)/(2*np);
l = np;
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
filepath1 = '/home/spire/Documents/DNN_journal_16videos/dist_DNN_FDM_DP_jangwon_type/DNN_Data/';
filepath2 = '/home/spire/Documents/DNN_journal_16videos/dist_discrete_DNN_MG/DNN_Data/';
filepath3 = '/home/spire/Documents/DNN_journal_16videos/Autorun_dist_DNN_SegNet/DNN_Data_dist_vocal/';
 for sub=1:length(strsub)
     diff_sub_fdm = [];
     diff_sub_ma = [];
     diff_sub_seg = [];
     diff_sub_grd = [];
     for fold=1:length(strfold)
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data_lower_pxl_np_5_grd.mat']);
         load([ filepath 'Autorun_Ton1/' strsub{sub} '/' strfold{fold} '/Test.mat']);
         load([ filepath1 Segment '/' strsub{sub} '/' strfold{fold} '/Pred_Cont_GridWise_MA.mat'], 'Pred_Cont_GridWise_MA');
         fdm = Pred_Cont_GridWise_MA;
         clear Pred_Cont_GridWise_MA;
         load([ filepath2 Segment '/' strsub{sub} '/' strfold{fold} '/Pred_Cont_GridWise_MA.mat'], 'Pred_Cont_GridWise_MA');
         ma = Pred_Cont_GridWise_MA;
         clear Pred_Cont_GridWise_MA;
         load([ filepath3  Segment '/' strsub{sub} '/' strfold{fold} '/Pred_Cont_GridWise_MA.mat'], 'Pred_Cont_GridWise_MA');
         seg = Pred_Cont_GridWise_MA;
         clear Pred_Cont_GridWise_MA;
         data = Test_Complete_Data_lower_pxl_5;
         for frame=1:length(Test_Complete_Data_lower_pxl_5)
             for p=1:length(Test_Complete_Data_lower_pxl_5{frame,3}(:,1))
                x_c1 = Test_Complete_Data_lower_pxl_5{frame,1}(p,:);
                y_c1 = Test_Complete_Data_lower_pxl_5{frame,2}(p,:);
                ins1 = Test_Complete_Data_lower_pxl_5{frame,3}(p,:);
                xv = [1  1 data{frame,1}(:,l+1)' 68 68 1];
                yv = [1 data{frame,2}(1,l+1) data{frame,2}(:,l+1)' data{frame,2}(end,l+1) 1 1];
                [in,on] = inpolygon(x_c1(1),y_c1(1),xv,yv);
                %if y_c(1)>data{frame,2}(p,l+1)
                if ~in
                    x_c = x_c1(end:-1:1);
                    y_c = y_c1(end:-1:1);
                    ins = ins1(end:-1:1);
                else
                    x_c = x_c1;
                    y_c = y_c1;
                    ins = ins1;
                end
                gridpoints=[x_c;y_c];
                xy_f = hfn_interX(fdm{1,frame}',gridpoints);
                if ~isempty(xy_f)
%                     nind_f = ceil((pdist2([x_c(1),y_c(1)],[xy_f(1),xy_f(2)]))/thre);
%                     if nind_f-1~=0 && nind_f+2<=10
%                         diff_sub_fdm = [diff_sub_fdm ins(nind_f)-ins(nind_f+1) ins(nind_f-1)-ins(nind_f+1) ins(nind_f)-ins(nind_f+2)];
%                     end
                  itx = hfn_get_val([xy_f(1) xy_f(2)],Test(frame).Frame);
                  nind_f = (pdist2([x_c(1),y_c(1)],[xy_f(1),xy_f(2)]))/thre;
                  nc = ceil(nind_f);
                  nf = floor(nind_f);
                  if nf>0 && nc+2<=11
                    x = [nf-1 nf nind_f nc nc+1];
                    y = [ins(nf) ins(nf+1) itx ins(nc+1) ins(nc+2)];
                    w = polyfit(x,y,3);
                    di = (3*w(1)*(nind_f^2))+(2*w(2)*nind_f)+w(3);
                    diff_sub_fdm = [diff_sub_fdm di];
                  end
                end
                xy_m = hfn_interX(ma{1,frame}',gridpoints);
                if ~isempty(xy_m)
%                     nind_m = ceil((pdist2([x_c(1),y_c(1)],[xy_m(1),xy_m(2)]))/thre);
%                     if nind_m-1~=0 && nind_m+2<=10
%                         diff_sub_ma = [diff_sub_ma ins(nind_m)-ins(nind_m+1) ins(nind_m-1)-ins(nind_m+1) ins(nind_m)-ins(nind_m+2)];
%                     end
                  itx = hfn_get_val([xy_m(1) xy_m(2)],Test(frame).Frame);
                  nind_m = (pdist2([x_c(1),y_c(1)],[xy_m(1),xy_m(2)]))/thre;
                  nc = ceil(nind_m);
                  nf = floor(nind_m);
                  if nf>0 && nc+2<=11
                    x = [nf-1 nf nind_m nc nc+1];
                    y = [ins(nf) ins(nf+1) itx ins(nc+1) ins(nc+2)];
                    w = polyfit(x,y,3);
                    di = (3*w(1)*(nind_m^2))+(2*w(2)*nind_m)+w(3);
                    diff_sub_ma = [diff_sub_ma di];
                  end
                end
                xy_s = hfn_interX(seg{1,frame}',gridpoints);
                if ~isempty(xy_s)
%                     nind_m = ceil((pdist2([x_c(1),y_c(1)],[xy_m(1),xy_m(2)]))/thre);
%                     if nind_m-1~=0 && nind_m+2<=10
%                         diff_sub_ma = [diff_sub_ma ins(nind_m)-ins(nind_m+1) ins(nind_m-1)-ins(nind_m+1) ins(nind_m)-ins(nind_m+2)];
%                     end
                  itx = hfn_get_val([xy_s(1) xy_s(2)],Test(frame).Frame);
                  nind_s = (pdist2([x_c(1),y_c(1)],[xy_s(1),xy_s(2)]))/thre;
                  nc = ceil(nind_s);
                  nf = floor(nind_s);
                  if nf>0 && nc+2<=11
                    x = [nf-1 nf nind_s nc nc+1];
                    y = [ins(nf) ins(nf+1) itx ins(nc+1) ins(nc+2)];
                    w = polyfit(x,y,3);
                    di = (3*w(1)*(nind_s^2))+(2*w(2)*nind_s)+w(3);
                    diff_sub_seg = [diff_sub_seg di];
                  end
                end
                    x = [np-2 np-1 np np+1 np+2];
                    y = [ins(np-1) ins(np) ins(np+1) ins(np+2) ins(np+3)];
                    w = polyfit(x,y,3);
                    di = (3*w(1)*(np^2))+(2*w(2)*np)+w(3);
                    diff_sub_grd = [diff_sub_grd di];
                %diff_sub_grd = [diff_sub_grd ins(np)-ins(np+2)];
             end
         end
     end
     save(['./'  Segment '/' strsub{sub} '/diff_sub_fdm_norm_pred.mat'],'diff_sub_fdm');
     save(['./'  Segment '/' strsub{sub} '/diff_sub_ma_norm_pred.mat'],'diff_sub_ma');
     save(['./'  Segment '/' strsub{sub} '/diff_sub_seg_norm_pred.mat'],'diff_sub_seg');
     save(['./'  Segment '/' strsub{sub} '/diff_sub_grd_norm_pred.mat'],'diff_sub_grd');
 end