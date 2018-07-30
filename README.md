# Realtime Implementation of JAABA
Modified version of offline The Janelia Automatic Animal Behavior Annotator (JAABA) to achieve realtime behavioral classification for *Drosophila* larva.

Original JAABA developed by https://github.com/kristinbranson/JAABA

Modified by Ajinkya Deogade (ajideo05_at_gmail.com)

#### Important changes compared to offline version are as follows:
1. ##### Subset of perframe features computed realtime
To speedup the classifcation the program only computes the top 5 important features extracted by performing offline cross-validation.

2. ##### Window features computed using only the past information
As only the information from the present frame and the past frames is available, the program computes the window features using only the past information. 

3. ##### Modified the spine computation to speed-up the perframe computation 10x

4. ##### Compiled the code in Java for real-time classification
To further speed up the real-time classification, the program is compiled on Java using Matlab Java compiler. Further information regarding the compilation procedure can be found at JAABA_Realtime/compute_perframe/README.md 
