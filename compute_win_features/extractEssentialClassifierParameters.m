function [filePath] = extractEssentialClassifierParameters(fileName, outputFolder, prefix)

[classifier_data] = load(fileName, '-mat');
classifier = struct;
classifier.featureLexiconName = classifier_data.x.featureLexiconName;
classifier.featureLexicon = classifier_data.x.featureLexicon;
classifier.behaviors = classifier_data.x.behaviors;
classifier.sublexiconPFNames = classifier_data.x.sublexiconPFNames;
classifier.featureNames = classifier_data.x.classifierStuff.featureNames;
classifier.timeStamp = classifier_data.x.classifierStuff.timeStamp;
classifier.params = classifier_data.x.classifierStuff.params;
classifier.type = classifier_data.x.classifierStuff.type;
classifier.trainingParams = classifier_data.x.classifierStuff.trainingParams;
classifier.windowFeaturesParams = classifier_data.x.windowFeaturesParams;

[filePath] = addDateToFilename(outputFolder, fileName, prefix);
save(filePath,'-struct','classifier','-mat');

end