%% Figure 4 - figure supplement 1A
%
% Display multi-dimensional scaling of successor representation
% 
%%
clear all
close all

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

[V,D]   = eig(double(graph==1));
gamma   = 0.85/max(D(:));

% Successor representation
to_mds       = 1 - (V * (eye(12) - gamma*D)^-1 * V^-1);

% Make it a valid matrix for MDS
% > needs to be symmetric
% > all values need to be positive
% Note: adding a constant only scales the resulting plot, but does not
% change the relationship between elements.

to_mds              = (to_mds + to_mds')/2;     % symmetrize matrix
to_mds              = to_mds + 10;               % add constant to make matrix entries positive 
to_mds(eye(12) == 1) = 0;                        % set diagonal to 0

% Multi-dimensional scaling
Y                   = mdscale(to_mds,2);        

% 2D
figure;

% Connect the objects that were experienced during training
[i,j] = find(graph==1);
l=line([Y(i,1),Y(j,1)]',[Y(i,2),Y(j,2)]');
set(l,'color','k');
axis equal
hold on
scatter(Y(:,1),Y(:,2),200,'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r')
text(0.2+Y(:,1),0.2+Y(:,2),num2str((1:12)'))   % label objects
set(gcf,'color','w')
set(findobj(gcf, 'type','axes'), 'Visible','off')


