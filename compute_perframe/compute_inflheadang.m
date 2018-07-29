%compute ang of inflheadvector

function [trx]=compute_inflheadang(trx,outputfolder)

inputfilename=[outputfolder,'xhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xhead_mm.mat'], 'data')
xhead_mm=data;
load([outputfolder,'yhead_mm.mat'], 'data')
yhead_mm=data;

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
inflheadang=cell(1,numlarvae);

for i=1:numlarvae
    inflheadang{1,i}=bsxfun(@atan2,yhead_mm{1,i}-yinflection_mm{1,i},xhead_mm{1,i}-xinflection_mm{1,i});
end

units=struct('num','rad','den',[]);
data=inflheadang;
filename=[outputfolder, 'inflheadang.mat'];
save(filename, 'data', 'units')