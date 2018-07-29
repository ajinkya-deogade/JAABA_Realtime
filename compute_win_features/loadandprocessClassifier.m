function [fastPredict] = loadandprocessClassifier(fileNameAbs, featureList)
[classifier_data] = load(fileNameAbs, '-mat');
fastPredict = FindFastPredictParams_2(classifier_data, featureList);
end
