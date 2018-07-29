%compute darea
function [trx]=compute_darea(trx,outputfolder)
inputfilename=[outputfolder,'area_mm.mat'];
if ~exist(inputfilename,'file')
    compute_area_mm(trx,outputfolder);
end
load([outputfolder,'area_mm.mat'],'data');
area_mm=data;

numlarvae=size(trx,2);
darea=cell(1,numlarvae);
for i=1:numlarvae
    darea{1,i}=(area_mm{1,i}(2:end)-area_mm{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num','mm2','den','s');
data=darea;
filename=[outputfolder, 'darea.mat'];
save(filename, 'data', 'units')