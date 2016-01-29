function [sel_list,rest_list,ordered_list,memberships,cost_function]=dominant_set_extraction(A)
%
%  [sel_list,rest_list,ordered_list,memberships,cost_function]=dominant_set_extraction(A)
%                  A is a similarity (weighted adjacency) matrix
%  sel_list is the set of selected nodes forming the most prominent graph component  
%  rest_list is the compement of the above list
%  cost_function tabulates the corresponding 'cluster-quality' for the detected component
%  
%
%  additional outputs ---> an ordered list of all nodes and the
%  corresponding list of memberships to the dominant setordered_list,memberships 
%
%  The algorithm has been adapted from
%  PAMI, vol.29(1),2007,pp.167 ---> Dominant Sets & Pairwise Clustering
%  and can be called recursively for hierarchical extraction of clusters    
%
%  Original adaptation by N.A. Laskaris
%  Updated version here by D.A. Adamos
%
%  For citation use: 
%  Adamos et al., "In quest of the missing neuron: Spike sorting based on dominant-sets clustering",
%  Computer methods and programs in biomedicine (2012) vol.107(1), pp.28-35 
%  http://dx.doi.org/10.1016/j.cmpb.2011.10.015
% 
%  For more information see: http://neurobot.bio.auth.gr/spike-sorting/
%
