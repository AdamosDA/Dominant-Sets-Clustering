% - Matlab memo for using Dominant-Sets (graph-theoretic) clustering in spike sorting -
% 
% If you find this useful, please cite: 
%
% [1] Adamos et al., "In quest of the missing neuron: Spike sorting based on dominant-sets clustering",
% Computer methods and programs in biomedicine (2012) vol.107(1), pp.28-35 
% http://dx.doi.org/10.1016/j.cmpb.2011.10.015
% 
% For more information see: http://neurobot.bio.auth.gr/spike-sorting/
% (C) D.A. Adamos, 2012.

% load waveforms & ISOMAP coordinates (features)
% Note. The number of waveforms has been kept small to facilitate efficient processing
load data.mat;
% Projection coordinates are kept in 'Y'. 'R' denotes residual variance.
% For details see 'Using ISOMAP for feature extraction in spike
% sorting' at http://neurobot.bio.auth.gr/spike-sorting


[rx,ry]=min(R);
REDUCED_DIMENSIONALITY=ry;

% Clustering will be applied on the coordinates of the data (spikes) in
% ISOMAP(ry-dimension) space. 
% (Any other multidimensional coordinates/features may be used)
%
% Please note that results will not be identical each time as the algorithm
% is randomly initialized when approaching the adjacency matrix of the graph.
X_data=Y.coords{REDUCED_DIMENSIONALITY}';
 
% Euclidean inter-point distances
d=(dmatrix(X_data));

% Distances are transformed to similarity weights, below.
% 'sigma' (ó) is a real positive number reflecting the ¡radius of influence¢ algorithm 
% which it controls the clustering resolution. A high value -> under-clustering, while a low value -> over-clustering.
% For details see [1].
%
% Optimum values of 'sigma' may be investigated using a grid optimization process, or 
% empirically based on experimental data (as in [1]). 
% Here, for the sake of proximateness, we will use a simpler approach based on 'd' matrix.

 
% Altering 'factor' values, affects the output of the algorithm. 
% (Typical values in [2,6] seem to work well.)
factor=5;
sigma=factor*mean(mean(d));

% A is a similarity (weighted adjacency) matrix
clear A; A=exp(-d/sigma); A=A-diag(diag(A));

% Let us apply one iteration of the dominant-sets algorithm (look for the most dominant set). 
% 'Cost_function' tabulates the quality of each estimated cluster.

[sel_list,rest_list,ordered_list,memberships,cost_function]=dominant_set_extraction(A);

% Plotting the result
figure(2);hold;grid
% original data
plot3(Y.coords{3}(1,1:300),Y.coords{3}(2,1:300),Y.coords{3}(3,1:300),'ob','markersize',8);
plot3(Y.coords{3}(1,301:600),Y.coords{3}(2,301:600),Y.coords{3}(3,301:600),'or','markersize',8);
plot3(Y.coords{3}(1,601:650),Y.coords{3}(2,601:650),Y.coords{3}(3,601:650),'og','markersize',8);
plot3(Y.coords{3}(1,651:680),Y.coords{3}(2,651:680),Y.coords{3}(3,651:680),'oy','markersize',8);
% mark the dominant set in black color
plot3(X_data(sel_list,1),X_data(sel_list,2),X_data(sel_list,3),'*k','markersize',8);



% ..proceed to the complete solution below



% Apply the dominant-sets algorithm iteratively.
clear groups no_groups cost_function f_ini;
[groups,no_groups,cost_function,f_ini]=iterative_dominant_set_extraction(A);


% Plot some figures..
% If ry=2, please adjust (plot3->plot) accordingly

figure(1),clf,plot([1:no_groups],cost_function,'o-',[1:no_groups],f_ini*ones(1,no_groups),'g.-'),title('group-cohesiveness'),xlabel('group number')
coords=X_data;clear myaxis; colors=[0 0 1 ; 1 0 0 ; 0 1 0 ;  0 1 1 ; 1 1 0 ; 1 0 1  ; 0.25 0.75 0; 0.75 0 0.25; 0 0.25 0.75; 0.75 0.5 0.25; 0 0 0];

figure(2);hold;figure(3);hold;grid;
myaxis(1)=0;myaxis(2)=size(spikes,2);myaxis(3)=min(min(spikes));myaxis(4)=max(max(spikes));
for i=1:no_groups
    figure(2);
    axis(myaxis);
    subplot(3,ceil(no_groups/3)+1,i);hold;grid;
    plot(spikes(find(groups==i),:)','color',colors(i,:));
    plot(mean(spikes(find(groups==i),:)),'k','linewidth',1.5);
    text(30,myaxis(4)*0.8,int2str(length(find(groups==i))));
    figure(3);plot(coords(find(groups==i),1),coords(find(groups==i),2),'.','markersize',8,'color',colors(i,:));
end
figure(2);
subplot(3,ceil(no_groups/3)+1,i+1);hold;grid;
    plot(spikes(find(groups==0),:)','color','black');
    text(30,myaxis(4)*0.8,int2str(length(find(groups==0))));

figure(3);plot(coords(find(groups==0),1),coords(find(groups==0),2),'.k','markersize',8);



