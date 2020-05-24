Segment='Upper';
strsub={'F1','F2','M1','M2'};
strfold={'Fold1','Fold2','Fold3','Fold4'};
% strsub = {'M2'};
% strfold = {'Fold1'};
load(['./'  Segment  '/best_per_all.mat']);
 for sub=1:length(strsub)
     for fold=1:length(strfold)
         load(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Test_Complete_Data.mat']);
         per = best_per_all{sub,1}{1,fold};
         load(['../DNN_Data_dist_DNN_Full/'  Segment  '/' strsub{sub} '/pxl_np_' num2str(per) '.mat'],'pxl_np');
         np = pxl_np(fold).np;
         l = length(Test_Complete_Data);
         M = (np+1)*csvread(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Data_Grid.csv']);
%          Pred_Set = {};
%          predf = {};
%          for i = 1:np+1
%              v = reshape(M(i,:),[pt,length(M)/pt]);
%              v = v + (i-1)*del;
%              pred = {};
%              pred_cont = {};
%              for frames = 1:l
%                  s=size(Test_Complete_Data{frames,1});
%                  for p = 1:s(1)
%                      x_c = Test_Complete_Data{frames,1}(p,:);
%                      y_c = Test_Complete_Data{frames,2}(p,:);
%                      pred{frames}(p,:) = v(p,frames);
%                      pred_cont{frames}(p,:) = cord_line([x_c(1),y_c(1)],[x_c(end),y_c(end)],v(p,frames));
%                  end
%              end
%              Pred_Set{1,i} = pred_cont; 
%              predf{1,i} = pred;
%          end
         pred_cont = {};
         pred_cont1 = {};
         i1 = floor((np/2) + 1);
         s=size(Test_Complete_Data{1,1});
         pt = s(1);
         c = 1;
         for frames = 1:l
%              v1 = reshape(M(i1,:),[pt,length(M)/pt]);
%              v1 = v1 + (i1-1)*del;
             v11 = M(i1,:);
             v11(v11<1) = 1;
             v1 = round(v11(1,c:pt)) + (i1-1);
             for p = 1:s(1)
                 pred_cont1{frames}(p,:) = [Test_Complete_Data{frames,1}(p,v1(1,p)) Test_Complete_Data{frames,2}(p,v1(1,p))];
                 cks = [];
                 for i = 1:np+1
%                      v = reshape(M(i,:),[pt,length(M)/pt]);
%                      v = v + (i-1)*del;
                     v22 = M(i,:);
                     v22(v22<1) = 1;
                     v2 = round(v22(1,c:pt)) + (i-1); 
                     cks = [cks v2(1,p)];
                 end
                 [f,xi] = ksdensity(cks);
                 [m ind] = max(f);
                 pred_cont{frames}(p,:) = [Test_Complete_Data{frames,1}(p,round(xi(ind))) Test_Complete_Data{frames,2}(p,round(xi(ind)))];
             end
             c = pt + 1;
             if frames ~= length(Test_Complete_Data)
                s=size(Test_Complete_Data{frames+1,1});
                pt = pt + s(1);
             end
         end
         Pred_Set = [pred_cont1;pred_cont];
         save(['./'  Segment  '/' strsub{sub} '/' strfold{fold} '/Pred_Set.mat'],'Pred_Set');
     end
 end
