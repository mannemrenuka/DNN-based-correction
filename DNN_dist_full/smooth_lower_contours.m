function lower_contour_sm = smooth_lower_contours(contour)            
%% Pre processing
avr_ridge = contour.avr_ridge;
x = [avr_ridge(1, 1)]; y = [avr_ridge(1, 2)];
for i = 1:size(avr_ridge,1)-1
    if avr_ridge(i, 1) < avr_ridge(i+1, 1) && avr_ridge(i+1, 1) < avr_ridge(end, 1)
        x = [x; avr_ridge(i+1, 1)];
        y = [y; avr_ridge(i+1, 2)];
        % plot(x, y, 'r*');
    end
end
x = [x; avr_ridge(end, 1)];
y = [y; avr_ridge(end, 2)];

x_new = [x(end)]; y_new = [y(end)];
i = length(x);
while i > 1
    if x(i) > x(i-1) && x(i-1) > x(1)
        x_new = [x_new; x(i-1)];
        y_new = [y_new; y(i-1)];
    end
    i = i - 1;
end
x_new = [x_new; x(1)]; y_new = [y_new; y(1)];
x = x_new; y = y_new;
clear x_new; clear y_new;

temp = [x, y];
temp = remDuplicates(temp);
%% QuadProg phase
x = temp(:, 1); y = temp(:, 2); clear temp;
fin = my_func(x, y);

c_down_smooth = [contour.c_down(1:contour.avr_start, :); flip(x), flip(fin); contour.c_down(length(avr_ridge)+(contour.avr_start-1):end, :)];
c_down_smooth = remDuplicates(c_down_smooth);

contour_janwon.c_down = c_down_smooth;
contour_janwon.Frame = contour.Frame;

lower_contour_sm = contour_janwon.c_down;

% imagesc(contour_janwon.Frame); hold on;
% plot(contour_janwon.c_down(:, 1), contour_janwon.c_down(:, 2), 'r-');
% plot(contour.c_down(:, 1), contour.c_down(:, 2), 'g*');
% pause%(0.01);
% hold off;
