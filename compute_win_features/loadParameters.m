function [perframedata, fastPredict, tStartAll, tEndAll] = loadParameters(fileNameClassifier, expDir, featureListFile)

    featureList = load(featureListFile);
    featureList = featureList.feature_names_all;
    [perframedata, fastPredict, tStartAll, tEndAll] = readDataAndLoadClassifier_3(fileNameClassifier, expDir, featureList);

end