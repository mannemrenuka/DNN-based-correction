per = [80:99,99.25,99.5,99.75,100];
% per = [99.25,99.5,99.75,100];
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
Segment = 'Lower';
for perc = 1:length(per)
     for sub=1:length(strsub)
        load(['./'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per(perc)) '.mat'],'pxl_np');
         for fold=1:length(strfold)
             load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_' num2str(per(perc)) '.mat']);
             np = pxl_np(fold).np;
             l = length(Dev_Complete_Data);
             l1 = floor(0.25*l);
             N = [];
             for i = 1:np+1
                 M = [];
                 for frames = l-l1+1:l
                     M = [M;Dev_Complete_Data{frames,3}(:,i:i+np)];
                 end
                 N = [N M];
             end
             csvwrite(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Intensity_Data_' num2str(per(perc)) '.csv'],N);
         end
     end
end
     
