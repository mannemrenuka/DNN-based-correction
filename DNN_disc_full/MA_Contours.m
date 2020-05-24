Segment='Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'M2'};
% strfold = {'Fold1'};
wins=4;
load(['./'  Segment  '/best_per_all.mat']);
load(['./'  Segment  '/best_rad_all.mat'],'best_rad_all');
 for sub=1:length(strsub)
     for fold=1:length(strfold)
         per = best_per_all{sub,1}{1,fold};
         load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per) '.mat'],'pxl_np');
         np = pxl_np(fold).np;
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Set.mat']);
         Pred1 = {};
         Pred = {};
         for frame=1:length(Pred_Set)
%              i = floor((np/2) + 1);
%                i = 2;
              xg1=Pred_Set{1,frame}(:,1);
              yg1=Pred_Set{1,frame}(:,2);
              xg = Pred_Set{2,frame}(:,1);
              yg = Pred_Set{2,frame}(:,2);
              if length(xg1) < best_rad_all{sub,1}{1,fold}
                  xg1=Pred_Set{1,frame-1}(:,1);
                  yg1=Pred_Set{1,frame-1}(:,2);
                  xg = Pred_Set{2,frame-1}(:,1);
                  yg = Pred_Set{2,frame-1}(:,2);                  
              end
              [xs1 ys1] = smooth_contours(xg1, yg1, best_rad_all{sub,1}{1,fold});
              [xs ys] = smooth_contours(xg, yg, best_rad_all{sub,1}{1,fold});
               Pred1{1,frame}= [xs1 ys1];
               Pred{1,frame} = [xs ys];
         end
         Pred_Cont_GridWise_MA = [Pred1; Pred];
         save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Cont_GridWise_MA.mat'],'Pred_Cont_GridWise_MA');
     end
 end
     