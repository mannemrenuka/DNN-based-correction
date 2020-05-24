Segment='Lower';
strsub={'F1','F2','M1','M2'};
% strsub = {'M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
per = [80:99,99.25,99.5,99.75,100];
% per = 91:99;
for perc = 1:length(per)
     for sub=1:length(strsub)
         load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per(perc)) '.mat'],'pxl_np');
         for fold=1:length(strfold)
             load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_' num2str(per(perc)) '.mat']);
             l = length(Dev_Complete_Data);
             l1 = floor(l*0.25);
             np = pxl_np(fold).np;
%              pt=length(Dev_Complete_Data{1,1}(:,np+1));
%              xx = Dev_Complete_Data{1,1}(1,:);
%              yy = Dev_Complete_Data{1,2}(1,:);
%              n = pdist2([xx(1),yy(1)],[xx(np+1),yy(np+1)]);
%              n1 = n/2;
%              del = pdist2([xx(1),yy(1)],[xx(2),yy(2)]);
             M = (np+1)*csvread(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Data_Grid_' num2str(per(perc)) '.csv']);
             Pred_Set = {};
             for i = 1:np+1
                 s=size(Dev_Complete_Data{l-l1+1,1});
                 pt = s(1);
                 c = 1;
%                  v = reshape(M(i,:),[pt,length(M)/pt]);
                 pred_cont = {};
                 for frames = l-l1+1:l
                     v1 = M(i,:);
                     v1(v1<1) = 1;
                     v = round(v1(1,c:pt)) + (i-1);
                     for p = 1:s(1)
                         if v(1,p) > 2*np+1
                             v(1,p) = 2*np+1;
                         end
                         pred_cont{frames-l+l1}(p,:) =  [Dev_Complete_Data{frames,1}(p,v(1,p)) Dev_Complete_Data{frames,2}(p,v(1,p))];
                     end
                     c = pt + 1;
                     if frames ~= l
                        s=size(Dev_Complete_Data{frames+1,1});
                        pt = pt + s(1);
                     end
                 end
                 Pred_Set{1,i} = pred_cont; 
             end
%              Pred_Set={pred_cont_1,pred_cont_2,pred_cont_3};
             save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Set_' num2str(per(perc)) '.mat'],'Pred_Set');
         end
     end
end