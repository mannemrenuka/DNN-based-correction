%Intensity Profile Generator
np=14;
Segment = 'Lower';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'F1'};
% strfold = {'Fold1'};
 for sub=1:length(strsub)
     for fold=1:length(strfold)
         c = 1;
         filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_lower_pxl_5.mat']);
%          load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Upper_' strsub{sub} '_fold_' num2str(fold) '_org.mat'], 'gnd_tr_upper_org');
        load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Lower_' strsub{sub} '_fold_' num2str(fold) '.mat'], 'gnd_tr_lower');
         dist_hist_dev={};
         data = Dev_Complete_Data_lower_pxl_5;
         for frame=1:length(data)
             for p=1:length(data{frame,3}(:,1))
                 gridpoints=[data{frame,1}(p,:);data{frame,2}(p,:)]';
                 xy = hfn_interX(gridpoints',gnd_tr_lower(frame).full_lower');
                 x_c = data{frame,1}(p,:);
                 y_c = data{frame,2}(p,:);
                 n = pdist2([x_c(1),y_c(1)],[x_c(np+1),y_c(np+1)]);
                 if ~isempty(xy)
                     nm = pdist2([x_c(1),y_c(1)],[xy(1),xy(2)]);
                     if nm>n
                          n1 = nm-n;
                          dist_hist_dev{c} = (-1*n1)/n;
                     elseif nm<=n
                          n1 = n-nm;
                          dist_hist_dev{c} = n1/n;
                     end
                 end
                 c = c + 1;
             end
         end
         save(['./'  Segment '/' strsub{sub} '/' strfold{fold} '/distance_dev.mat'],'dist_hist_dev');
     end
 end
                     
