seg1 = 'Autorun_UL';
seg2 = 'Autorun_Ton1';
sub = {'F1', 'F2', 'M1', 'M2'};
filepath = '/home/spire/Documents/ncc_2019_conference/Autorun_16vid_Segnet_binary/';
for s = 1:size(sub, 2)
    for fold = 1:4
        load([filepath seg1 '/' sub{s} '/Fold' num2str(fold) '/Dev_MatVid.mat']);
        load([filepath seg1 '/' sub{s} '/Fold' num2str(fold) '/Test_MatVid.mat']);
        filepathu = ['./Autorun/Upper/' sub{s} '/Fold' num2str(fold)];
        mkdir(filepathu);
        save([filepathu '/Test_MatVid.mat'],'Test_MatVid');
        save([filepathu '/Dev_MatVid.mat'],'Dev_MatVid');
        clear Dev_MatVid;
        clear Test_MatVid;
        load([filepath seg2 '/' sub{s} '/Fold' num2str(fold) '/Dev_MatVid.mat']);
        load([filepath seg2 '/' sub{s} '/Fold' num2str(fold) '/Test_MatVid.mat']);
        filepathl = ['./Autorun/Lower/' sub{s} '/Fold' num2str(fold)];
        mkdir(filepathl);
        save([filepathl '/Test_MatVid.mat'],'Test_MatVid');
        save([filepathl '/Dev_MatVid.mat'],'Dev_MatVid');
        clear Dev_MatVid;
        clear Test_MatVid;
    end
end