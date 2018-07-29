function [scores] = predictAllBehavior_scores(fileNameClassifier, expDir, featureListFile)

    [perframedata, fastPredict, tStartAll, tEndAll] = loadParameters(fileNameClassifier, expDir, featureListFile);
    tEndAll_window = tEndAll;
    tStartAll_window = tStartAll;

    perframe_data_window = perframedata;
    [~, scores] = predictBehavior(tStartAll_window, tEndAll_window, perframe_data_window, fastPredict);

end