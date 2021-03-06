strsub={'F1','F2','M1','M2'};
% strsub = {'F2'};
Segment = 'Upper';
figure;
cfl = 18;
c = 2;
fo = 20;
close all;
for sub=1:length(strsub)
    load(['./'  Segment '/' strsub{sub} '/diff_sub_fdm_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_ma_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_seg_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_grd_norm.mat']);
    load(['./'  Segment '/' strsub{sub} '/diff_sub_upper_norm.mat']);
    subplot(2,2,sub);
    x_list = [];
    [f x] = ksdensity(diff_sub,'Function','pdf');
%     trapz(f,xi)
    x_list = [x_list mean(diff_sub)];
    plot(x,f,'k','LineWidth',c);hold on;
    [f2 x2] = ksdensity(diff_sub_ma,'Function','pdf');
%     trapz(f2,xi)
    x_list = [x_list mean(diff_sub_ma)];
    plot(x2,f2,'r','LineWidth',c);hold on;
    [f1 x1] = ksdensity(diff_sub_fdm,'Function','pdf');
%     trapz(f1,xi)
    x_list = [x_list mean(diff_sub_fdm)];
    plot(x1,f1,'b','LineWidth',c);hold on;
    [f4 x4] = ksdensity(diff_sub_seg,'Function','pdf');
%     trapz(f4,xi)
    x_list = [x_list mean(diff_sub_seg)];
    plot(x4,f4,'m','LineWidth',c);
    [f3 x3] = ksdensity(diff_sub_grd,'Function','pdf');
%     trapz(f3,xi)
    x_list = [x_list mean(diff_sub_grd)];
    plot(x3,f3,'g','LineWidth',c);
%     title(['Upper corrected ' strsub{sub} '  ' num2str(x_list) ]);
    set(gca,'FontSize',cfl, 'FontWeight', 'bold')
    title(strsub{sub},'fontweight','bold','fontsize',fo);
%     leg = legend('\boldmath ${K_{agr}}$','\boldmath $K_{mcr}$','\boldmath $K_{fcr}$','\boldmath $K_{scr}$','\boldmath $K_{gr}$');
leg = legend('\boldmath ${K_{agr}}$','\boldmath $K_{mpr}$','\boldmath $K_{fpr}$','\boldmath $K_{spr}$','\boldmath $K_{gr}$');
    set(leg,'Interpreter','latex');
    set(leg,'FontSize',cfl);
%     $K_{agr}$, $K_{gr}$, $K_{mpr}$, $K_{fpr}$, $K_{spr}$, $K_{mcr}$, $K_{fcr}$, and $K_{scr}$
    ax = gca
    % Make the x axis only have a font size of 9 and text weight of bold
    % Make the x axis (line) and tick marks have a line width of 2 and color red.
    ax.XAxis.LineWidth = 2;
    ax.YAxis.LineWidth = 2;
end
text(-2.58  , 15, 'Predicted Upper contours','FontSize',20,'FontWeight','bold'); %% corrected upper
text(-2.58  , -1, 'Intensity difference', 'FontSize', 20, 'FontWeight', 'bold'); %% corrected upper
h = text(-5  , 4, 'Kernel density estiamted value', 'FontSize', 20, 'FontWeight', 'bold'); %% corrected upper

% text(-2.1  , 12.5, 'Predicted Upper contours','FontSize',20,'FontWeight','bold'); %% corrected lower
% text(-2.0  , -1, 'Intensity difference', 'FontSize', 20, 'FontWeight', 'bold'); %% corrected lower
% h = text(-4.6  , 3, 'Kernel density estiamted value', 'FontSize', 20, 'FontWeight', 'bold'); %% corrected lower
set(h,'Rotation',90);
% suptitle('Corrected Upper contours');
hold off;