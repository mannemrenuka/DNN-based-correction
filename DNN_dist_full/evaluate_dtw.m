    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EVALALUATE USING DTW
%  INPUT:  Two arrays containing coordinates
%  OUTPUT: Single Score Value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [score] = evaluate_dtw(contour1, contour2)
    c1=contour1;c2=contour2;
%     tic
%     [c1, c2] = equal_length(contour1, contour2);
%     toc
    
%     tic
    d = find_distance_matrix(c1, c2);
%     toc
    
%     tic
    [map, Dist] = dtw_general(d);
%     toc
    score = Dist;
    
%     figure; grid on;
%     plot(map(:, 1), map(:, 2), 'r*');
    
    return;
end