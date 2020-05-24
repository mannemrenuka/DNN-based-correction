%% Finds the index of the point on GnTr contour (GnTr_ctr) on the grid line (gLine)
%% Input:
% pred_pt := the point on the predicted contour
% gLine := grid line containing 'K' points
% GnTr := ground truth contour
%% Output:
% if gLine intersects Gntr_ctr at at least one point:
% idx := index of the point on gLine (-floor(K/2) <= idx <= floor(K/2))
% else:
% idx := -floor(K/2) or floor(K/2) depending which end point of gLine is
% closer to GnTr_ctr
%% Dependent Functions:
% hfn_nearestneighbor, hfn_interX

function idx = hfn_find_gntr_idx(gLine, GnTr_ctr)


% plot(gLine(:, 1), gLine(:, 2), '*-'); hold on; plot(GnTr_ctr(:, 1), GnTr_ctr(:, 2), '*-');

K = length(gLine);
pred_pt = gLine(ceil(K/2), :);

% find intersection pt(s) of gLine and GnTr_ctr
itx_pt = hfn_interX(gLine', GnTr_ctr');
itx_pt = itx_pt';

% if gLine intersects the GnTr on atleast at point
if ~isempty(itx_pt)
    
    % If gLine intersects gntr on multiple points
    if length(itx_pt) > 1
        %Choose point closest to the pt on pred contour
        itx_idx = hfn_nearestneighbour(pred_pt', itx_pt');
        itx_pt = itx_pt(itx_idx, :);
    end
    
    idx = hfn_nearestneighbour(itx_pt', gLine');
    idx = idx - ceil(K/2);
    
else
    % checks the distance to the GnTr_ctr from the two end points of gLine
    % and chooses the point which is closer to GnTr_ctr
%     mapxy = [gLine(1, :); gLine(K, :)];
%     curvexy = GnTr_ctr;
%     
%     [~, dist_to_gntr, ~] = hfn_distance2curve(curvexy, mapxy);
%     
%     if dist_to_gntr(1) > dist_to_gntr(2)
%         idx = 0 - floor(K/2);
%     else
%         idx = 0 + floor(K/2);
%     end
    idx=1000;
    
end