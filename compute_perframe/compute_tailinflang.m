%compute ang of tailinflvector

function [trx]=compute_tailinflang(trx,outputfolder)

inputfilename=[outputfolder,'xtail_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xtail_mm.mat'], 'data')
xtail_mm=data;
load([outputfolder,'ytail_mm.mat'], 'data')
ytail_mm=data;

inputfilenamexin=[outputfolder,'xinflection_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_xinflection_mm(trx,outputfolder);
end
load(inputfilenamexin, 'data')
xinflection_mm=data;

inputfilenameyin=[outputfolder,'yinflection_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_yinflection_mm(trx,outputfolder);
end
load(inputfilenameyin, 'data')
yinflection_mm=data;

numlarvae=size(trx,2);
tailinflang=cell(1,numlarvae);

for i=1:numlarvae
    tailinflang{1,i}=bsxfun(@atan2,yinflection_mm{1,i}-ytail_mm{1,i},xinflection_mm{1,i}-xtail_mm{1,i});
end

units=struct('num','rad','den',[]);
data=tailinflang;
filename=[outputfolder, 'tailinflang.mat'];
save(filename, 'data', 'units')