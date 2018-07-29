%compute velang_tailhead
function [trx]=compute_velangtailhead(trx,outputfolder)
inputfilename=[outputfolder,'dxtailhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_dxtailhead_mm(trx,outputfolder);
end
load([outputfolder,'dxtailhead_mm.mat'], 'data')
dxtailhead_mm=data;
inputfilename=[outputfolder,'dytailhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_dytailhead_mm(trx,outputfolder);
end
load([outputfolder,'dytailhead_mm.mat'], 'data')
dytailhead_mm=data;
numlarvae=size(trx,2);
velangtailhead=cell(1,numlarvae);
for i=1:numlarvae
    velangtailhead{1,i}=bsxfun(@atan2,dytailhead_mm{1,i},dxtailhead_mm{1,i});
end

units=struct('num','rad','den','s');
data=velangtailhead;
filename=[outputfolder, 'velangtailhead.mat'];
save(filename, 'data', 'units') 