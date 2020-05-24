%% Create upper contour from annotated data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function lower_contour_sm = make_janwon_contours(c_down_contour, Frame)
    contour_jang = struct;
    % trim start of contour
    avr_start = 1;

    c_down_contour_full = c_down_contour;
%     while c_down_contour(1, 2) > c_down_contour(2, 2)
%         c_down_contour = c_down_contour(2:end, :);
%         avr_start = avr_start + 1;
%     end
    count = 0;
    thre = 2;
    for i = 1:5
        if c_down_contour(i,2) > c_down_contour(i+1,2) && count <= thre
%             c_down_contour = c_down_contour(2:end, :);
            avr_start = avr_start + 1;
            count = 0;
        elseif count <= thre
            count = count + 1;
%             c_down_contour = c_down_contour(2:end, :);
            avr_start = avr_start + 1;
        else 
            break;
        end
    end
    avr_start = avr_start - count;
    c_down_contour = c_down_contour(avr_start:end,:);
    j = 1;
    y = c_down_contour(j, 2);
%     while (j < length(c_down_contour) && (c_down_contour(j, 2) >= y-0.3) && c_down_contour(j, 1) < 32)
%         j = j + 1;
%     end
    count = 0;
    thre = 2;
    for k = 1:length(c_down_contour)
        if j<length(c_down_contour) && c_down_contour(j,1)<32
            if c_down_contour(j, 2) >= y-0.3 && count <= thre
                j = j + 1;
                count = 0;
            elseif count <= thre
                count = count + 1;
                j = j + 1;
            else
                j = j - count;
                break
            end
        end
    end
    avr_ridge = c_down_contour(1:j, :);
    avr_ridge =remDuplicates(avr_ridge);


    %contour_jang.c_up = [annotation(f).contour1(ul_ind:v_ind, :); annotation(f).contour3(contour3_start(s):glt_ind, :)];
    contour_jang.c_down = c_down_contour_full;
    contour_jang.avr_ridge = avr_ridge;
    contour_jang.avr_start = avr_start;
    contour_jang.Frame = Frame;



%     imagesc(Frame); hold on;
%     plot(contour_jang.c_down(:, 1), contour_jang.c_down(:, 2), 'g*');
% %             pause(0.02);
% %             hold off;
% %             imagesc(vid(f).cdata); hold on;
%     plot(contour_jang.avr_ridge(:, 1), contour_jang.avr_ridge(:, 2), 'r--');
%     hold off;
%     pause%(0.01);
    
    lower_contour_sm = smooth_lower_contours(contour_jang);
%     prun = c_down_contour;
%     data_inv = -prun(:,2);
%     [mini loc] = findpeaks(data_inv);
%     subplot(1,3,1);
%     imagesc(Frame); hold on;
%     plot(prun(:,1),prun(:,2),'r*');
%     plot(c_down_contour_full(:, 1), c_down_contour_full(:, 2), 'go');
%     hold off;
%     subplot(1,3,2);
%     imagesc(Frame); hold on;
%     plot(lower_contour_sm(:, 1), lower_contour_sm(:, 2), 'r*');
%     hold off;
%     subplot(1,3,3);
%     plot(prun(:,2),'go-');hold on;
%     plot(prun(loc,2),'r*');
%     hold off;
%     pause;

