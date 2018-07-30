# Realtime Implementation of JAABA
Modified the offline version of The Janelia Automatic Animal Behavior Annotator (JAABA) for realtime behavioral classification for *Drosophila* larva.

Original JAABA developed by https://github.com/kristinbranson/JAABA

Modified by Ajinkya Deogade (ajideo05_at_gmail.com)

#### Important changes compared to offline version are as follows:
1. ##### Subset of perframe features computed realtime
The program uses the perframe fearures computed realtime and applies the window features using only the past information.

4. ##### Window features computed using only the past information
To speedup the classifcation the program only computes the top 5 important features extracted by performing offline cross-validation.

7. ##### Modified the spine computation to speed-up the perframe computation 10x

9. ##### Compiled the code in Java for real-time classification
