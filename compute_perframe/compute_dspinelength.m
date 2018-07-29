%compute dspinelength
function [trx]=compute_dspinelength(trx,outputfolder)
inputfilename=[outputfolder,'spinelength.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinelength(trx,outputfolder);
end
load([outputfolder,'spinelength.mat'],'data');
spinelength=data;

numlarvae=size(trx,2);
dspinelength=cell(1,numlarvae);
for i=1:numlarvae
    dspinelength{1,i}=(spinelength{1,i}(2:end)-spinelength{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num','mm','den','s');
data=dspinelength;
filename=[outputfolder, 'dspinelength.mat'];
save(filename, 'data', 'units')