%% Compare janwon Like Contours


function compare_janwon_contours(sub)

% mkdir('./Results_Janwon_Pred_contours');

for s = 1:size(sub, 2)
    score_sub = struct;
    score_sub.score_sub_upper = [];
    score_sub.score_sub_lower = [];
    mkdir(['./Results_Janwon_Pred_contours/' sub{s}]);
    filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
    res_struct_sub = struct;
    ifold_iter = 1;
    for fold = 1:4
        %Loading actual
        load([filepath 'Contours_Janwon_My_dataset_16videos/' sub{s} '/Fold' num2str(fold) '/fold' num2str(fold) '_janwon_' sub{s} '.mat']);
        %Loading predicted and smoothed - Upper
        load(['./Upper_contours_dnn/' sub{s} '/Fold' num2str(fold) '/Upper_' sub{s} '_fold' num2str(fold) '_sm.mat']);
        
         load(['./Lower_contours_dnn/' sub{s} '/Fold' num2str(fold) '/Lower_' sub{s} '_fold' num2str(fold) '_sm.mat']);
        
         score_lower = zeros(length(lower_contour_smooth), 1);
        score_upper = zeros(length(upper_contour_smooth), 1);
        
        %ifold_iter = ifold_iter + length(lower_contour_smooth);
        
        for f = 1:length(upper_contour_smooth)
            
             score_lower(f) = evaluate_dtw(fold_str(f).c_down, lower_contour_smooth(f).contour_smooth);
            score_upper(f) = evaluate_dtw(fold_str(f).c_up, upper_contour_smooth(f).upper_contour);
            %score_upper(f) = evaluate_dtw(fold_str(f).c_up_without_c3, upper_contour_smooth(f).upper_contour_without_c3);
            
             res_struct_sub(ifold_iter).lower_smooth = lower_contour_smooth(f).contour_smooth;
            res_struct_sub(ifold_iter).upper_smooth = upper_contour_smooth(f).upper_contour;
            res_struct_sub(ifold_iter).upper_smooth_without_c3 = upper_contour_smooth(f).upper_contour_without_c3;
            res_struct_sub(ifold_iter).Frame = fold_str(f).Frame;
            ifold_iter = ifold_iter + 1;
            
%             imagesc(fold_str(f).Frame); hold on
%             plot(fold_str(f).c_down(:, 1), fold_str(f).c_down(:, 2), 'g-');
%             plot(fold_str(f).c_up(:, 1), fold_str(f).c_up(:, 2), 'g-');
%             plot(upper_contour_smooth(f).upper_contour(:, 1), upper_contour_smooth(f).upper_contour(:, 2), 'r-');
%             plot(lower_contour_smooth(f).contour_smooth(:, 1), lower_contour_smooth(f).contour_smooth(:, 2), 'r-');
%             
%             pause;
%             hold off;

        end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %         [val, f] = max(score_upper + score_lower);
% % %         disp(num2str(f));
% % %         
% % %         figure(1);
% % %         title(['FisherAlgo']);
% % %         imagesc(fold_str(f).Frame); hold on
% % %         plot(fold_str(f).c_down(:, 1), fold_str(f).c_down(:, 2), 'g-');
% % %         plot(lower_contour_smooth(f).contour_smooth(:, 1), lower_contour_smooth(f).contour_smooth(:, 2), 'r-');
% % %         plot(fold_str(f).c_up(:, 1), fold_str(f).c_up(:, 2), 'g-');
% % %         plot(upper_contour_smooth(f).upper_contour(:, 1), upper_contour_smooth(f).upper_contour(:, 2), 'r-');
% % %         pause;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %        

         score_sub.score_sub_lower = [score_sub.score_sub_lower; score_lower];
        score_sub.score_sub_upper = [score_sub.score_sub_upper; score_upper];
        

        

        
    end
    score_sub.av_upper = mean(score_sub.score_sub_upper);
    score_sub.std_upper = std(score_sub.score_sub_upper);
     score_sub.av_lower = mean(score_sub.score_sub_lower);
     score_sub.std_lower = std(score_sub.score_sub_lower);
    
%      save(['./Results_Janwon_Pred_contours_without_MA/' sub{s} '/Ctrs_pred_' sub{s} '_janwon.mat'], 'res_struct_sub');
    save(['./Results_Janwon_Pred_contours/' sub{s} '/Score_pred_' sub{s} '_janwon.mat'], 'score_sub');
end
