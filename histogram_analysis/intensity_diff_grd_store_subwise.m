%Intensity Profile Generator
np=5;
Segment = 'Lower';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4','Fold5'};
% strsub = {'F1'};
 for sub=1:length(strsub)
     diff_sub = [];
     for fold=1:length(strfold)
         c = 1;
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_lower_pxl_np_5_grd.mat']);
         data = Dev_Complete_Data_lower_pxl_5;
         for frame=1:length(data)
             for p=1:length(data{frame,3}(:,1))
                 for n=2:size(data{frame,3},2)-1
                     a = data{frame,3};
                     %diff_sub = [diff_sub a(n+1)-a(n) a(n)-a(n-1)];
                     diff_sub = [diff_sub a(n)-a(n+1) a(n-1)-a(n)];
                 end
             end
         end
     end
     save(['./'  Segment '/' strsub{sub} '/diff_sub_lower.mat'],'diff_sub');
 end
                     