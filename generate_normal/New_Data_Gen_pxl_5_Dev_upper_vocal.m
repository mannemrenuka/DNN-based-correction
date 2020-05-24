np=14;
pxl=5;
strsub={'F1','F2','M1','M2'};
Segment = 'Upper';
strfold={'Fold1','Fold2','Fold3','Fold4'};
     for sub=1:length(strsub)
        for fold=1:length(strfold)
            Dev_Complete_Data_upper_pxl_5={};
            filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
            filepath1 = './Autorun/';
            dir = ['./DNN_Data_dist_vocal/' Segment '/' strsub{sub} '/' strfold{fold} '/'];
            mkdir(dir);
            load([filepath1 'Upper/' strsub{sub} '/' strfold{fold} '/Upper_' strsub{sub} '_fold' num2str(fold)  '_sm_dev.mat'], 'upper_contour_smooth');
            load([filepath 'Autorun_Ton1/' strsub{sub} '/' strfold{fold} '/Dev.mat']);
            for frm=1:length(upper_contour_smooth)
                p=upper_contour_smooth(frm).upper_contour;
                p1=p(1:end-2,:);
                p2=p(2:end-1,:);
                p3=p(3:end,:);
                Mx=zeros(length(p),2*np+1);
                My=zeros(length(p),2*np+1);
                MI=zeros(length(p),2*np+1);
                tmp=fn_NormalGen(p1(1,:),p1(1,:),p1(2,:),np,pxl);
                Mx(1,:)=tmp(:,1)';
                My(1,:)=tmp(:,2)';
                tmp=fn_NormalGen(p3(end-1,:),p3(end,:),p3(end,:),np,pxl);
                Mx(end,:)=tmp(:,1)';
                My(end,:)=tmp(:,2)';
                for n=1:length(p1);
                    tmp=fn_NormalGen(p1(n,:),p2(n,:),p3(n,:),np,pxl);
                    Mx(n+1,:)=tmp(:,1)';
                    My(n+1,:)=tmp(:,2)';
                end
                for i=1:length(p(:,1))
                    for j=1:2*np+1
                        if isnan(Mx(i,j))
                            Mx(i,j) = Mx(i+2,j);
                            My(i,j) = My(i+2,j);
                            MI(i,j)=hfn_get_val([Mx(i,j) My(i,j)],Dev(frm).Frame);
%                         elseif isnan(Mx(i,j)) && i==1
%                             mx = Dev_Complete_Data_upper_pxl_5{frm-1,1};
%                             my = Dev_Complete_Data_upper_pxl_5{frm-1,2};
%                             Mx(i,j) = mx(i,j);
%                             My(i,j) = my(i,j);
%                             MI(i,j) = hfn_get_val([Mx(i,j) My(i,j)],Dev(frm).Frame);
                        else
                            MI(i,j)=hfn_get_val([Mx(i,j) My(i,j)],Dev(frm).Frame);
                        end
                    end
                end
                Dev_Complete_Data_upper_pxl_5{frm,1}=Mx;
                Dev_Complete_Data_upper_pxl_5{frm,2}=My;
                Dev_Complete_Data_upper_pxl_5{frm,3}=MI;
            end
            save(['./DNN_Data_dist_vocal/Upper/' strsub{sub} '/' strfold{fold} '/Dev_Complete_Data_upper_pxl_5.mat'],'Dev_Complete_Data_upper_pxl_5');
        end
     end

