%compute length of inflheadvector

function [trx]=compute_inflheadmag(trx,outputfolder)

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
inflheadmag=cell(1,numlarvae);

for i=1:numlarvae
    inflheadmag{1,i}=bsxfun(@hypot,xhead_mm{1,i}-xinflection_mm{1,i},yhead_mm{1,i}-yinflection_mm{1,i});
end

units=struct('num','mm','den',[]);
data=inflheadmag;
filename=[outputfolder, 'inflheadmag.mat'];
save(filename, 'data', 'units')