%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIND DISTANCE BETWEEN EACH PAIR OF POINTS
%  INPUT:  Two arrays of dimensions - Mx2 and Nx2
%  OUTPUT: Distance matrix of dimensions -MxN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function d = hfn_find_distance_matrix(c1, c2)
    l1 = length(c1);
    l2 = length(c2);
    
% % %     d = zeros(l1, l2);
% % %     
% % %     for i = 1:l1
% % %         for j = 1:l2
% % %             p1 = c1(i, :);
% % %             p2 = c2(j, :);
% % %             d(i, j) = find_distance(p1, p2);
% % %         end
% % %     end
    
    d=-ones(l1,l2);
    for i=1:l1
        temp=c2-repmat(c1(i,:),l2,1);
        d(i,:)=sqrt(sum(temp.^2,2))';
    end
    
% % %     pause
    return;
end

function d_val = find_distance(p1, p2)
    %d_val = sqrt(sum((p1 - p2).^2));
     d_val = (sum((p1 - p2).^2));
end
