% compute head, tail and center of the spine in px and mm

function [trx]=compute_spinerelevantpositions(trx,outputfolder)
inputfilename=[outputfolder,'tailheadang.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
numlarvae=size(trx,2);
xhead_mm=cell(1,numlarvae);
xtail_mm=cell(1,numlarvae);
xcentral_mm=cell(1,numlarvae);
yhead_mm=cell(1,numlarvae);
ytail_mm=cell(1,numlarvae);
ycentral_mm=cell(1,numlarvae);
if isfield(trx,'xmidposition_mm')
    for i=1:numlarvae
        xhead_mm{1,i}=trx(i).xspine_mm(1,:);
        xtail_mm{1,i}=trx(i).xspine_mm(end,:);
        xcentral_mm{1,i}=trx(i).xmidposition_mm;
        yhead_mm{1,i}=trx(i).yspine_mm(1,:);
        ytail_mm{1,i}=trx(i).yspine_mm(end,:);
        ycentral_mm{1,i}=trx(i).ymidposition_mm;
    end
else
    for i=1:numlarvae
        xhead_mm{1,i}=trx(i).xspine_mm(1,:);
        xtail_mm{1,i}=trx(i).xspine_mm(11,:);
        xcentral_mm{1,i}=trx(i).xspine_mm(6,:);
        yhead_mm{1,i}=trx(i).yspine_mm(1,:);
        ytail_mm{1,i}=trx(i).yspine_mm(11,:);
        ycentral_mm{1,i}=trx(i).yspine_mm(6,:);
    end
end

units=struct('num','mm','den',[]);
filename=[outputfolder, 'xhead_mm.mat'];
data=xhead_mm;
save(filename, 'data', 'units')
filename=[outputfolder, 'yhead_mm.mat'];
data=yhead_mm;
save(filename, 'data', 'units')
filename=[outputfolder, 'xtail_mm.mat'];
data=xtail_mm;
save(filename, 'data', 'units')
filename=[outputfolder, 'ytail_mm.mat'];
data=ytail_mm;
save(filename, 'data', 'units')
filename=[outputfolder, 'xcentral_mm.mat'];
data=xcentral_mm;
save(filename, 'data', 'units')
filename=[outputfolder, 'ycentral_mm.mat'];
data=ycentral_mm;
save(filename, 'data', 'units')

