# Dominant-Sets-Clustering
## Source code for the tutorial on how to use graph-theoretic clustering to detect sparse-firing neurons in spike-sorting

**A short intro**

The decision about the actual number of active neurons is an open issue in spike sorting, with sparsely firing neurons and background activity the most influencing factors. Dominant-sets clustering algorithm is a graph-theoretical algorithmic procedure that successfully tackles this issue. The quality of grouping in the data is evaluated with the estimation of ‘cohesiveness’, i.e. a cluster-quality measure, for each group.

[The tutorial is available here](http://neurobot.bio.auth.gr/2013/dominant-sets-clustering-for-spike-sorting/). Therein, simulated spikes from 3 neurons, one being a sparsely-firing one, are used.

To reproduce this tutorial in MATLAB you will need :
1. Memo script for MATLAB and sample data to reproduce the results shown in the tutorial.


**Remarks**

In the provided example in the tutorial, clustering will be applied on the coordinates of the data (spikes) in ISOMAP space.
Any other multidimensional coordinates/features (even raw waveforms) may be used. Results will not be identical each time, as the algorithm is randomly initialized when approaching the adjacency matrix of the graph.

For further details and to cite this work, see:

**Adamos DA**, Laskaris NA, Kosmidis EK, Theophilidis G, “[In quest of the missing neuron: Spike sorting based on dominant-sets clustering](http://dx.doi.org/10.1016/j.cmpb.2011.10.015)“. Computer Methods and Programs in Biomedicine 2012, vol.107 (1), pp.28-35. 

For more information see: [http://neurobot.bio.auth.gr/spike-sorting](http://neurobot.bio.auth.gr/spike-sorting/)
