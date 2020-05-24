Segment='Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'M2'};
% strfold = {'Fold1'};
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
load(['./'  Segment  '/best_per_all.mat']);
distplot={};
 for sub=1:length(strsub)
%         m1 = [];
%         m2 = [];
%         m3 = [];
%         m4 = [];
%         m5 = [];
        v1=[];
        v2=[];
        v3=[];
        v4=[];
        v5=[];
        v6=[];
     for fold=1:length(strfold)
        load([filepath 'Ground_Truth_Full/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Upper_' strsub{sub} '_fold_' num2str(fold) '_org.mat'], 'gnd_tr_upper_org');
%         load([filepath 'Ground_Truth_Full/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Lower_' strsub{sub} '_fold_' num2str(fold) '.mat'], 'gnd_tr_lower');
        load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Set.mat']);
        load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data.mat']);
        load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Cont_GridWise_MA.mat']);
        per = best_per_all{sub,1}{1,fold};
        load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per) '.mat'],'pxl_np');
        np = pxl_np(fold).np;
%         i = floor((np/2) + 1);
%          i = 2;
%         v1=[];
%         v2=[];
%         v3=[];
%         v4=[];
%         v5=[];
%         v6=[];
        for frame=1:length(gnd_tr_upper_org)
%             gtc=gnd_tr_lower(frame).full_lower;
            gtc=gnd_tr_upper_org(frame).full_upper;
            pdc_opt1=[Test_Complete_Data{frame,1}(:,np+1) Test_Complete_Data{frame,2}(:,np+1)];
            pdc_gridwise1=Pred_Set{1,frame};
            pdc_gridwise_MA1=Pred_Cont_GridWise_MA{1,frame};
            pdc_gridwise=Pred_Set{2,frame};
            pdc_gridwise_MA=Pred_Cont_GridWise_MA{2,frame};
            distM=hfn_find_distance_matrix(gtc,pdc_opt1);
            [~,score1]=hfn_dtw_general(distM);
            distM=hfn_find_distance_matrix(gtc,pdc_gridwise1);
            [~,score2]=hfn_dtw_general(distM);
            distM=hfn_find_distance_matrix(gtc,pdc_gridwise_MA1);
            [~,score3]=hfn_dtw_general(distM);
            distM=hfn_find_distance_matrix(gtc,pdc_gridwise);
            [~,score4]=hfn_dtw_general(distM);
            distM=hfn_find_distance_matrix(gtc,pdc_gridwise_MA);
            [~,score5]=hfn_dtw_general(distM);          
            v1 = [v1 score1];
            v2 = [v2 score2];
            v3 = [v3 score3];
            v4 = [v4 score4];
            v5 = [v5 score5];
        end
%           m1 = [m1 mean(v1)];
%           m2 = [m2 mean(v2)];
%           m3 = [m3 mean(v3)];
%           m4 = [m4 mean(v4)];
%           m5 = [m5 mean(v5)];
     end
%       distplot{sub,1} = m1;
%       distplot{sub,2} = m2;
%       distplot{sub,3} = m3;
%       distplot{sub,4} = m4;
%       distplot{sub,5} = m5;
      distplot{sub,1} = mean(v1);
      distplot{sub,2} = mean(v2);
      distplot{sub,3} = mean(v3);
      distplot{sub,4} = mean(v4);
      distplot{sub,5} = mean(v5);
      distplot{sub+4,1} = std(v1);
      distplot{sub+4,2} = std(v2);
      distplot{sub+4,3} = std(v3);
      distplot{sub+4,4} = std(v4);
      distplot{sub+4,5} = std(v5);
 end
 save(['./'  Segment  '/DWT_DisData_Performance_sub.mat'],'distplot');
            

