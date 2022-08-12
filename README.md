# Panoramic Image Stitching
Here is the Comptuer Vision Course Project. It is the implementation of stitching several images into a panoramic image. There are basically two methods, one is mutual method, the other is automatic method. 
## Mutual Method
To execute the mutual stitching, you just need to execute the file `mutual_main.m` in the folder `code`, and select 10 correspondences in a pair of images very carefully. 
## Automatic Method
To execute the automatic stitching, basically you need to execute the file `auto_main.m` in the folder `code`.  However, there are two main methods to implement the automatic stitching. You can modify the code in the file `processImagePairs.m`.  
For example, in the following case, the program will use the RANSAC algorithm to compute the Homographic matrix rather than using the Gold Standard algorithm. 
```bash
%H = computeHomoGold(p1, p2);
H = computeHomoRANSAC(p1, p2)
```