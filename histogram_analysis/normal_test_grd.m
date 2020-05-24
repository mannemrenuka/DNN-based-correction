np=5;
pxl=5;
strsub={'F1','F2','M1','M2'};
Segment = 'Autorun_Ton1';
strfold={'Fold1','Fold2','Fold3','Fold4'};
c = 0;
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
     for sub=1:length(strsub)
        for fold=1:length(strfold)
            Test_Complete_Data_upper_pxl_5={};
            load([filepath 'Contours_Janwon_My_dataset_16videos/' strsub{sub} '/' strfold{fold} '/fold' num2str(fold) '_janwon_' strsub{sub} '.mat']);
            load([filepath Segment '/' strsub{sub} '/' strfold{fold} '/Test.mat']);
            for frm=1:length(Test)
                p=fold_str(frm).c_up;
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
                    if sum(isnan(tmp)) > 1
                        c = c+1;
                        Mx(n+1,:) = Mx(n,:);
                        My(n+1,:) = My(n,:);
                    end
                end
                if frm==20 && sub==1 && fold==1
                    Mx(9,:) = Mx(10,:);
                    My(9,:) = My(10,:);
                end
                for i=1:length(p(:,1))
                    for j=1:2*np+1
                        MI(i,j)=hfn_get_val([Mx(i,j) My(i,j)],Test(frm).Frame);
                    end
                end
                Test_Complete_Data_upper_pxl_5{frm,1}=Mx;
                Test_Complete_Data_upper_pxl_5{frm,2}=My;
                Test_Complete_Data_upper_pxl_5{frm,3}=MI;
            end
            mkdir(['./Upper/' strsub{sub} '/' strfold{fold} '/']);
            save(['./Upper/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data_upper_pxl_np_5_grd.mat'],'Test_Complete_Data_upper_pxl_5');
        end
     end


