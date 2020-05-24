%Intensity Profile Generator
per = [80:99,99.25,99.5,99.75,100];
strsub={'F2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
Segment = 'Lower';
for perc = 1:length(per)
    for sub=1:length(strsub)
         load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per(perc)) '.mat'],'pxl_np');
         for fold=1:length(strfold)
             filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
             load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_' num2str(per(perc)) '.mat'],'Dev_Complete_Data');
             load([filepath 'Ground_Truth_Full_Dev/' strsub{sub} '/' strfold{fold} '/Gnd_Tr_Lower_' strsub{sub} '_fold_' num2str(fold) '.mat'], 'gnd_tr_lower');
             intensity_profile_frame={};
             pxl = pxl_np(fold).pxl;
             np = pxl_np(fold).np;
             mkdir(['./Lower/' strsub{sub} '/' strfold{fold} '/']);
             for frame=1:length(Dev_Complete_Data)
                 %Set's Row Contains all allowed intensity sequence for a
                 %point on Predicted contour
                 intensity_profile_set={};
                 for p=1:length(Dev_Complete_Data{frame,3}(:,1))
                     gridpoints=[Dev_Complete_Data{frame,1}(p,:);Dev_Complete_Data{frame,2}(p,:)]';
                     xy = hfn_interX(gridpoints',gnd_tr_lower(frame).full_lower');
                     index=hfn_find_gntr_idx(gridpoints,gnd_tr_lower(frame).full_lower);
                     [seq,nindx,flag]=fn_Sub_Index_Generator(index,np+1);
                     %From Seq we will figure out Intensity Profile
                     %nindx will give the corresponding output normalised
                     %index
                     seqt=seq+np+1;
                     for t=1:length(seqt(:,1))
                         if flag~=1
                             intensity_profile_set{p,t}=[Dev_Complete_Data{frame,3}(p,seqt(t,:)) nindx(t)];
                         else
                             intensity_profile_set{p,t}=[];
                         end
                     end
                 end
                 intensity_profile_frame{frame}=intensity_profile_set;
             end
             save(['./Lower/' strsub{sub} '/' strfold{fold} '/Intensity_Set_' num2str(per(perc)) '.mat'],'intensity_profile_frame');
         end
    end
end
