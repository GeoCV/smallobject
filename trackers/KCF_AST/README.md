## Output Constraint Transfer for Kernelized Correlation Filter in Tracking

________________
### Introduction
This is a MATLAB implementation of algorithm presented in "Output Constraint Transfer for Kernelized Correlation Filter in Tracking" paper [1]. The implementation is built upon the code provided by [2]. The code provided by [3] is used for computing the HOG features.


________________
### Instructions

1) Run the "run_tracker.m" script in MATLAB.

2) Choose sequence (only "Jogging-1" is included).

________________
### Notes
According to the visual tracker benchmark, the start frame of video “Tiger1” should be 6. So we added some code on the 56th line of the script “load_video_info.m”.

To get the results consistent with our paper, you need to download the latest version of our source code, and modify the “groundtruth_rect.txt” file of “Tiger1” by deleting the first 5 lines.


________________
### Contact

Baochang Zhang

bczhang@buaa.edu.cn

________________
### References
[1] B. Zhang, Z. Li, X. Cao, Q. Ye, C. Chen, L. Shen, A. Perina, and R. Ji,
    "Output Constraint Transfer for Kernelized Correlation Filter in Tracking," IEEE Transactions on Systems, Man, and Cybernetics:system, 2016.

[2] J. Henriques, R. Caseiro, P. Martins, and J. Batista.
    "High-Speed Tracking with Kernelized Correlation Filters."
     IEEE Transactions on Pattern Analysis and Machine Intelligence, 2015

[3] Piotr Dollár.
    "Piotr’s Image and Video Matlab Toolbox (PMT)."
    http://vision.ucsd.edu/~pdollar/toolbox/doc/index.html.
