%% Make Janwon Contours from my predicted contours

function create_lower_janwon_from_pred_without_MA(sub)
filepath1 = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
for s = 1:size(sub, 2)
    for fold = 1:4
        lower_contour_smooth = struct;
        % Loading Ground truth janwon
        load([filepath1 'Contours_Janwon_My_dataset_16videos/' sub{s} '/Fold' num2str(fold) '/fold' num2str(fold) '_janwon_' sub{s} '.mat']);
        % Loading Predicted Full
        load(['./Lower/' sub{s} '/Fold' num2str(fold) '/Pred_Set.mat'],'Pred_Set');
        %load(['Lower_contours/' sub{s} '/Fold' num2str(fold) '/Lower_' sub{s} '_fold' num2str(fold) '.mat']);
        file_path = ['./Lower_contours_dnn_without_MA/' sub{s} '/Fold' num2str(fold)];
        mkdir(file_path);
        load([filepath1 'Autorun_Ton1/' sub{s} '/Fold' num2str(fold) '/Test.mat'],'Test');
        for f = 1:length(fold_str)
            disp([sub{s} ' ' num2str(fold) ' ' num2str(f)]);
            st_idx = nearestneighbour(fold_str(f).c_down(1,:)', Pred_Set{1,f}');
            end_idx = nearestneighbour(fold_str(f).c_down(end,:)', Pred_Set{1,f}');
%             imagesc(fold_str(f).Frame); hold on;
%             plot(fold_str(f).c_down(:, 1), fold_str(f).c_down(:, 2), 'g-');
%             plot(lower_contour(f).contour(st_idx:end_idx, 1), lower_contour(f).contour(st_idx:end_idx, 2), 'r-');
%             pause;
%             hold off;
            
            lower_contour_smooth(f).contour_smooth = make_janwon_contours(Pred_Set{1,f}(st_idx:end_idx, :), Test(f).Frame);
            imagesc(fold_str(f).Frame); hold on;
            plot(fold_str(f).c_down(:, 1), fold_str(f).c_down(:, 2), 'g');
            plot(Pred_Set{1,f}(:,1), Pred_Set{1,f}(:,2),'b');
            plot(lower_contour_smooth(f).contour_smooth(:, 1), lower_contour_smooth(f).contour_smooth(:, 2), 'r');
            pause(0.01);
            hold off;
        end
        save(['./Lower_contours_dnn_without_MA/' sub{s} '/Fold' num2str(fold) '/Lower_' sub{s} '_fold' num2str(fold) '_sm.mat'], 'lower_contour_smooth');
        
    end
end