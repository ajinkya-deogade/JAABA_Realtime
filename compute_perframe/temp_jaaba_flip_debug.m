clear all
tic
outputfolderorg='F:\TRX_Files\kinDataCS_newtracker_noOdor_1\';
load([outputfolderorg,'trx.mat'])
filename=[outputfolderorg,'oldtrx.mat'];
save(filename,'trx');
mkdir(outputfolderorg,'perframe')
outputfolder=[outputfolderorg,'perframe/'];
compute_velang(trx,outputfolder)
compute_eccentricity(trx,outputfolder);
xspine_mm = trx.xspine_mm;
yspine_mm = trx.yspine_mm;
xspine_px = trx.xspine;
yspine_px = trx.yspine;
velang = load(fullfile(outputfolder,'velang.mat'));
velang = velang.data{1} ;
ecc = load(fullfile(outputfolder,'velang.mat'));
ecc = ecc.data{1};
curvtips = trx.curvtips;
[xspine_mm, yspine_mm, curvtips, xspine_px, yspine_px] = choose_orientationslarvae_highres(xspine_mm,yspine_mm,velang,ecc,curvtips,xspine_px,yspine_px);
for i = 1:length(xspine_px)
    plot(xspine_px(:,i), yspine_px(:,i),'g.-')
    hold on
    plot(xspine_px(1,i), yspine_px(1,i),'r^')
    hold off
    pause
end
toc