function [dist,graph] = generate_graph(gplot)
%% Generate graph structure, Figure 1A
%
% dist_42: distance between any two objects on the graph. Diagonal removed
%
%%

% Set up objects that are directly linked
% graph(1,[2,3,4])        = 1;
% graph(2,[1,4,5])        = 1;
% graph(3,[1,4,6,7])      = 1;
% graph(4,[1,2,3,5,7])    = 1;
% graph(5,[2,4,8,9])      = 1;
% graph(6,[3,7,10])       = 1;
% graph(7,[3,4,6,8,10,11]) = 1;
% graph(8,[5,7,9,11,12])  = 1;
% graph(9,[5,8,12])       = 1;
% graph(10,[6,7,11])      = 1;
% graph(11,[7,8,10,12])   = 1;
% graph(12,[8,9,11])      = 1;
% graph                   = graphallshortestpaths(sparse(graph));

% Set up objects that are directly linked
graph(1,[2,3,8])        = 1;
graph(2,[1,3,9])        = 1;
graph(3,[1,2,4,5,8,9])  = 1;
graph(4,[3,6,8,10,12])   = 1; 
graph(5,[3,7,9,11,12])   = 1;
graph(6,[4,10,12])      = 1;
graph(7,[5,11,12])       = 1;
graph(8,[1,3,4,10])     = 1;
graph(9,[2,3,5,11])     = 1;
graph(10,[4,6,8])       = 1;
graph(11,[5,7,9])       = 1;
graph(12,[4,5,6,7])     = 1;
graph                   = graphallshortestpaths(sparse(graph));


% Plot graph if gplot == 'on'
if strcmp(gplot,'on')
    % Plot graph
    Y       = mdscale(graph,2);
    figure;
    [i,j] = find(graph == 1); l=line([Y(i,1),Y(j,1)]',[Y(i,2),Y(j,2)]');
    set(l,'color','k'); hold on
    scatter(Y(:,1),Y(:,2),'r','filled'), text(Y(:,1),Y(:,2),num2str((1:length(graph))'))
    set(gcf,'color','w'), axis off
end

% Only objects 1:7 presented on day 2
dist     = graph(1:7,1:7);     % distance between pairs of objects presented on day 2
