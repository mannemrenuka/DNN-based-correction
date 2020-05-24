%Intensity Profile Generator
np=5;
Segment = 'Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'F1'};
l = np;
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
 for sub=1:length(strsub)
     diff_sub = [];
     for fold=1:length(strfold)
         c = 1;
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data_upper_pxl_np_5_grd.mat']);
         data  = Test_Complete_Data_upper_pxl_5;
         for frame=1:length(data)
             for p=1:length(data{frame,3}(:,1))
                 for n=3:size(data{frame,3},2)-2
%                     a = data{frame,3};
                    x_c1 = data{frame,1}(p,:);
                    y_c1 = data{frame,2}(p,:);
                    ins1 = data{frame,3}(p,:);
                    xv = [1  1 data{frame,1}(:,l+1)' 68 68 1];
                    yv = [1 data{frame,2}(1,l+1) data{frame,2}(:,l+1)' data{frame,2}(end,l+1) 1 1];
                    [in,on] = inpolygon(x_c1(1),y_c1(1),xv,yv);
                    %if y_c(1)>data{frame,2}(p,l+1)
                    if ~in
                        x_c = x_c1(end:-1:1);
                        y_c = y_c1(end:-1:1);
                        a = ins1(end:-1:1);
                    else
                        x_c = x_c1;
                        y_c = y_c1;
                        a = ins1;
                    end
                     %diff_sub = [diff_sub a(n+1)-a(n) a(n)-a(n-1)];
                     x = [n-3 n-2 n-1 n n+1];
                     y = [a(n-2) a(n-1) a(n) a(n+1) a(n+2)];
                     w = polyfit(x,y,3);
                     di = (3*w(1)*((n-1)^2))+(2*w(2)*(n-1))+w(3);
                     diff_sub = [diff_sub di];
                 end
             end
         end
     end
     save(['./'  Segment '/' strsub{sub} '/diff_sub_upper_norm.mat'],'diff_sub');
 end
                     