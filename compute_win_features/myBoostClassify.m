function scores = myBoostClassify(data, model)

numEx = size(data,1);
scores = zeros(numEx,1);
for j = 1:length(model)
  curWk = model(j);
  tr = curWk.tr;
  dir = curWk.dir;
  dim = curWk.dim;

  if dir>0,
    tt = ((data(:,dim)> tr)-0.5)*2;
  else
    tt = ((data(:,dim)<= tr)-0.5)*2;
  end

  addScores = tt*curWk.alpha;
  scores = scores + addScores;

end
