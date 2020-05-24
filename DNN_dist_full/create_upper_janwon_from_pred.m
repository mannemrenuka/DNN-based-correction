%% Make Janwon Contours from my predicted contours

function create_upper_janwon_from_pred(sub)

% contour3_start = [23, 26, 18, 25];
hard_palate = {[24, 26; 25, 26; 26, 26; 27, 26; 28, 25; 29, 25; 30, 25; 31, 25; 32, 25; 33, 25], ...
                [24, 27; 25, 27; 26, 26; 27, 26; 28, 25; 29, 25; 30, 24; 31, 24; 32, 24; 33, 23; 34, 23; 35, 23], ...
                [24, 23; 25, 23; 26, 23; 27, 22; 28, 22; 29, 22; 30, 21; 31, 21; 32, 20; 33, 20; 34, 20; 35, 20; 36, 20; 37, 20; 38, 20], ...
                [24, 28; 25, 28; 26, 28; 27, 27; 28, 26; 29, 26; 30, 25; 31, 24; 32, 23; 33, 23; 34, 23; 35, 23; 36, 23; 37, 23]};
for s = 1:size(sub, 2)
%     if sub{s} == 'F1', c3_st_idx = contour3_start(1);
%         elseif strcmp(sub{s}, 'F2'), c3_st_idx = contour3_start(2);
%         elseif strcmp(sub{s}, 'M1'), c3_st_idx = contour3_start(3);
%         elseif strcmp(sub{s}, 'M2'), c3_st_idx = contour3_start(4); end
    if strcmp(sub{s}, 'F1'), hard_palate_sub = hard_palate{1}; 
    elseif strcmp(sub{s}, 'F2'), hard_palate_sub = hard_palate{2}; 
    elseif strcmp(sub{s}, 'M1'), hard_palate_sub = hard_palate{3}; 
    elseif strcmp(sub{s}, 'M2'), hard_palate_sub = hard_palate{4}; end
     load(['./' sub{s} '_template.mat'], 'contour3', 'GLTBpt');
     
     for fold = 1:4
         filepath1 = '/home/spire/Documents/ncc_2019_conference/Autorun_New_Linux_16 vid_janwon/';
         upper_contour_smooth = struct;
         
        file_path = ['./Upper_contours_dnn/' sub{s} '/Fold' num2str(fold)];
        mkdir(file_path);
        upper_contour_smooth = struct;
        % Loading Ground truth janwon
        load([filepath1 'Contours_Janwon_My_dataset_16videos/' sub{s} '/Fold' num2str(fold) '/fold' num2str(fold) '_janwon_' sub{s} '.mat']);
        % Loading Predicted Full
        load(['./Upper/' sub{s} '/Fold' num2str(fold) '/Pred_Cont_GridWise_MA.mat'],'Pred_Cont_GridWise_MA');
        
        %load([file_path '/fold' num2str(fold) '_janwon_' sub{s} '_annotation.mat']);
        
        for f = 1:length(fold_str)
%             vel_search = length(Pred_Cont_GridWise_MA{1,f}) - 10;
%             [~, vel_idx] = max(Pred_Cont_GridWise_MA{1,f}(vel_search:end, 2));
%             vel_idx = vel_search - 1 + vel_idx;
            hard_idx = nearestneighbour(hard_palate_sub(5,:)',Pred_Cont_GridWise_MA{1,f}');
            [~, vel_idx] = max(Pred_Cont_GridWise_MA{1,f}(hard_idx:end, 2));
            vel_idx = vel_idx + hard_idx - 1;
            c3_st_idx = find(contour3(:, 2) > Pred_Cont_GridWise_MA{1,f}(vel_idx, 2), 1, 'first');
            %c3_end_idx = nearestneighbour(fold_str(f).c_up(end, :)', annotation_for_janwon(f).contour3');
            c3_end_idx = GLTBpt;
            st_idx = nearestneighbour(fold_str(f).c_up(1,:)', Pred_Cont_GridWise_MA{1,f}');
            
            
            
            
            
%             disp([sub{s} ' ' num2str(fold) ' ' num2str(f)]);
%             imagesc(fold_str(f).Frame); hold on;
%             plot(fold_str(f).c_up(:, 1), fold_str(f).c_up(:, 2), 'g-');
%             plot(Pred_Cont_GridWise_MA{1,f}(st_idx:end, 1), Pred_Cont_GridWise_MA{1,f}(st_idx:end, 2), 'r-');
%             pause;
%             hold off;
            
            upper_contour_smooth(f).upper_contour = [Pred_Cont_GridWise_MA{1,f}(st_idx:vel_idx, :); contour3(c3_st_idx:c3_end_idx, :)];
            upper_contour_smooth(f).upper_contour_without_c3 = [Pred_Cont_GridWise_MA{1,f}(st_idx:vel_idx, :)];
            
            end_idx_gnd_tr = nearestneighbour(upper_contour_smooth(f).upper_contour_without_c3(end, :)', fold_str(f).c_up');
            fold_str(f).c_up_without_c3 = fold_str(f).c_up(1:end_idx_gnd_tr, :);
%             ul_ind_ann = find( (annotation_for_janwon(f).UL(1) == annotation_for_janwon(f).contour1(:, 1)) .* (annotation_for_janwon(f).UL(2) == annotation_for_janwon(f).contour1(:, 2)));
%             fold_str(f).c_up_without_c3 = annotation_for_janwon(f).contour1(ul_ind_ann:end, :);
            
            imagesc(fold_str(f).Frame); hold on;
            plot(fold_str(f).c_up(:, 1), fold_str(f).c_up(:, 2), 'g-');
            plot(upper_contour_smooth(f).upper_contour(:, 1), upper_contour_smooth(f).upper_contour(:, 2), 'r*');
            pause(0.005);
            hold off;
            

        end
        save([file_path '/Upper_' sub{s} '_fold' num2str(fold) '_sm.mat'], 'upper_contour_smooth');
        %save(['../Autorun/Contours_Janwon_My_dataset/' sub{s} '/Fold' num2str(fold) '/fold' num2str(fold) '_janwon_' sub{s} '.mat'], 'fold_str');
    end
end
