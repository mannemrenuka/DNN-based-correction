Segment='Upper';
% np=14;
% pxl=5;
lambda=[0, 0.001, 0.002, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.5, 1, 5, 10];
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'F1'};
% strfold = {'Fold1'};
load(['./DNN_Data_discrete_vocal/'  Segment  '/best_per_all.mat']);
     for sub=1:length(strsub)
        for fold=1:length(strfold)
            Test_Complete_Data={};
            filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
            filepath1 = './Autorun/';
            per = best_per_all{sub,1}{1,fold};
            load(['./DNN_Data_dist_vocal/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per) '.mat'],'pxl_np');
            load([filepath  'Autorun_Ton1/' strsub{sub} '/' strfold{fold} '/Test.mat']);
            load([filepath1 Segment '/' strsub{sub} '/' strfold{fold} '/Upper_' strsub{sub} '_fold' num2str(fold)  '_sm.mat'], 'upper_contour_smooth');
            np = pxl_np(fold).np;
            pxl = pxl_np(fold).pxl;
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
                for n=1:length(p1)
                    tmp=fn_NormalGen(p1(n,:),p2(n,:),p3(n,:),np,pxl);
                    Mx(n+1,:)=tmp(:,1)';
                    My(n+1,:)=tmp(:,2)';
                end
                for i=1:length(p(:,1))
                    for j=1:2*np+1
                        if isnan(Mx(i,j))
                            Mx(i,j) = Mx(i+2,j);
                            My(i,j) = My(i+2,j);
                            MI(i,j)=hfn_get_val([Mx(i,j) My(i,j)],Test(frm).Frame);
                        else
                            if My(i,j) < 0
                                Mx(i,j) = Mx(i+2,j);
                                My(i,j) = My(i+2,j);
                            end
                            MI(i,j)=hfn_get_val([Mx(i,j) My(i,j)],Test(frm).Frame);
                        end
                    end
                end
                Test_Complete_Data{frm,1}=Mx;
                Test_Complete_Data{frm,2}=My;
                Test_Complete_Data{frm,3}=MI;
            end
            save(['./DNN_Data_discrete_vocal/'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data.mat'],'Test_Complete_Data');
        end
     end


