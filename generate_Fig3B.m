%% Figure 3B
%
% transition_count: number of times a given transition was experienced
% during training for each subject
% subject x object on trial t-1 x object on trial t
%
%%
clear all
close all

load('exp_settings.mat');

%% Generate graph
% dist: distance between objects 
[dist,graph] = generate_graph('off');   % 'on': plot graph structure, 'off': do not plot graph structure

transition_count = transition_count(:,1:7,1:7);

% plot hexagon for symmetry
for subj = 1:23
    % number of times each transition was experienced by a subject during 
    % training
    m      = squeeze(transition_count(subj,:,:));            
    
    % Asymmetry index: Absolute difference in the number of times a 
    % transition was visited in one vs. the other direction, normalized 
    % by the total number of visits of that transition
    m     = abs(triu(m) - triu(m'))./(triu(m) + triu(m'));
    
    % Asymmetry index across subjects
    as_ix(subj,:) = m(triu(dist==1));
end

% Plot histogram
figure; bar([0:0.05:0.5],histc(as_ix(:),[0:0.05:0.5]),'facecolor',[0.5 0.5 0.5])
set(gca,'TickDir','out')
ylabel('Number of occurrences')
xlabel('Asymmetry index')
box off
set(gcf,'color','w')
xlim([-0.05 0.5])
set(gca,'XTick',0:0.1:0.5,'YTick',0:10:40)
