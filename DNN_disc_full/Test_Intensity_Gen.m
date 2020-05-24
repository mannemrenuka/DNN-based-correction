%Test Data Generator
Segment='Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'F1'};
% strfold = {'Fold1'};
load(['./'  Segment  '/best_per_all.mat']);
 for sub=1:length(strsub)
     for fold=1:length(strfold)
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data.mat']);
         per = best_per_all{sub,1}{1,fold};
         load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per) '.mat'],'pxl_np');
         np = pxl_np(fold).np;
         N = [];
        for i = 1:np+1
            M = [];
            for frames = 1:length(Test_Complete_Data)
                M = [M;Test_Complete_Data{frames,3}(:,i:i+np)];
            end
            N = [N M];
        end
         csvwrite(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Intensity_Data.csv'],N);
     end
 end
     