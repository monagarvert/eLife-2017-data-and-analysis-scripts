# eLife-2017-data-and-analysis-scripts
These Matlab scripts &amp; data files can be used to reproduce the figures from Garvert et al., eLife 2017, https://elifesciences.org/content/6/e17086

Dependencies:
- Matlab (we used 2014a but it should all work with previous versions)
- bioinformatics toolbox (for script graphallshortestpaths.m in different scripts, e.g. generate_Fig3C.m)

Data files:
All neural data files come in the following format: subjects x runs x object trial t-1 x object trial t
- ROI1.mat: 
parameter estimates extracted from entorhinal ROI1 (contrast used to define ROI: associated < non-associated)
- ROI2.mat: 
parameter estimates extracted from entorhinal ROI2 (contrast used to define ROI: length 2 < length 3)
- ROI3.mat: 
parameter estimates extracted from entorhinal ROI3 (contrast used to define ROI: Chadwick et al. peak coordinate)
- ROI4.mat: 
parameter estimates extracted from entorhinal ROI depicted in Figure 4B
- ROI5.mat: 
parameter estimates extracted from anatomically defined region of interest depicted in Figure 2 – figure supplement 1.
- lOFC.mat: 
parameter estimates extracted from OFC ROI (contrast used to define ROI: associated < non-associated)
- subgenual.mat: 
parameter estimates extracted from OFC ROI (contrast used to define ROI: associated < non-associated)
- visual.mat: 
parameter estimates extracted from OFC ROI (contrast used to define ROI: main effect of object onset)
- RT.mat: 
log-transformed and demeaned response times, format: subj x runs x object on trial t-1 x object on trial t

behaviour.mat:
- rt_train: response times in the training blocks (subjects x training blocks)
- cr_train: % correct in the training blocks (subjects x training blocks)
- rt_object: response times of cover task during the scan for the seven different objects (subjects x runs x object)
- rt_object: % correct of cover task during the scan for the seven different objects (subjects x runs x object)
- rt_trans: Average response time across blocks for the different object transitions (subjects x object on trial t-1 x object on trial t)

exp_settings.mat:
- path_dist: time: average number of objects during training between any pair of objects (subjects x object A x object B)
- transition_count: number of times a transition between two objects was experienced during training (subjects x object A x object B). Note this contains transitions between all 12 objects on the full graph.
