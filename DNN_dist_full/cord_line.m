function C = cord_line(A,B,AP)

%// Use atan2!
th = atan2( B(2)-A(2) , B(1)-A(1) );

%// Distance from A to the point of interest

%// The point of interest
C = [
    A(1) + AP*cos( th )
    A(2) + AP*sin( th )];

%// Verify correctness with plots
% figure(1), clf, hold on
% line([A(1); B(1)], [A(2); B(2)])
% plot(...
%     A(1), A(2), 'r.',... 
%     B(1), B(2), 'b.',...
%     C(1), C(2), 'k.', 'markersize', 20)