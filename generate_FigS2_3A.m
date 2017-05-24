%% Figure 2 - Figure supplement 3A
%
% Plot number of times a transition was encountered during training
%
%%
clear all
close all

load('exp_settings.mat');       % loads variable transition_count: number of times a transition was experienced during training

% Plot transitions
ct = sum(transition_count,3);
figure; bar(mean(ct),'facecolor',[0.5 0.5 0.5])
hold on 
errorbar(1:12,mean(ct),std(ct),'k','linestyle','none')
set(gcf,'color','w')
box off
xlabel('Object')
ylabel('Number of times presented during training')
