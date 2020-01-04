#  [Aggregation Signature for Small Object Tracking](https://arxiv.org/abs/1910.10859)  #
---
Chunlei Liu, Wenrui Ding, Jinyu Yang, Vittorio Murino, Baochang Zhang, Jungong Han, Guodong Guo:
Aggregation Signature for Small Object Tracking. IEEE Transactions on Image Processings 2019

## Link ##
---
There are the links to annotation file and datasets.

annotation file:

https://drive.google.com/open?id=1o8IVbmjmoWm37cRBqmlu2RKrWVtS2AW8

datasets small90:

https://drive.google.com/open?id=1Ybw_FALmQMA-c4Qm7VWKm9iNbp6Dv7Vu

datasets small112:

https://drive.google.com/open?id=1lUVt_tlHrsroofVfUL0LxrI_GUCMaUn-

## Abstract
---
Small object tracking becomes an increasingly important task, which however has been largely unexplored in computer vision. The great challenges stem from the facts that: 1) small objects show extreme vague and variable appearances, and 2) they tend to be lost easier as compared to normal-sized ones due to the shaking of lens. In this paper, we propose a novel aggregation signature suitable for small object tracking, especially aiming for the challenge of sudden and large drift. We make three-fold contributions in this work. First, technically, we propose a new descriptor, named aggregation signature, based on saliency, able to represent highly distinctive features for small objects. Second, theoretically, we prove that the proposed signature matches the foreground object more accurately with a highprobability.Third,experimentally,theaggregationsignature achieves a high performance on multiple datasets, outperforming the state-of-the-art methods by large margins. Moreover, we contribute with two newly collected benchmark datasets, i.e., small90 and small112, for visually small object tracking. 

## Introduction
---
In this paper, small objects mean that the targets in images have sizes of less than 1% of the whole image. The challenge of small object tracking mainly roots in two main facts: ﬁrst, the visual features of small objects are extremely ﬁckle, thus making feature representation difﬁcult; second, sudden and large drift always occurs to small objects in tracking because of the shaking of the lens, compared to the normal-sized objects. The so-called sudden and large drift is that the target distance between two adjacent frames in the image coordinate system is two times larger than the target size.
The aggregation signature uses the target as a prior to adaptively locate the salient object, which is deployed to re-detect the tracked objects when drifting. It is generic and can be used in conjunction with other trackers.


## Architecture
---
See the JPG file entitles structure above.

## Preparation
---
Please first install Matlab.
Our code is written in Matlab2018a.



