% PMR assignment 2
% Nov 2011
% S. M. Ali Eslami
% s.m.eslami@sms.ed.ac.uk

% Remember, there are only a limited number of licences for MATLAB. After 
% you have finished using MATLAB, quit from the MATLAB session so that 
% others can work.

%% INITIALISATION ----------------------------------------------------------

% clear the console
clc;
clear;
close all;

% add the toolboxes that we'll need for visualisation and data processing
addtoolboxes;

% load the motion capture data
[skeleton, sequence_X, frame_length] = bvhReadFile('data/mocap-anchored.bvh');
num_frames      = size(sequence_X, 1);
num_dimensions  = size(sequence_X, 2);

%% DEMO --------------------------------------------------------------------

% visualise the loaded data
% skelPlayData(skeleton, sequence_X, frame_length);

%% PART 1 ------------------------------------------------------------------

%% Q1: getEigenvectors.m
%% Q2:
[Mu, E, Lambda, P] = getEigenvectors(sequence_X);
% Get the index of the first element in P which is >= 95.
NComponents = find(P >= 95, 1);
% Get its value.
Y = P(NComponents);
%figure(1);
%plot(P);
%line([4 4], [0 Y]);
%line([0 4], [Y Y]);
%xlabel('number of components');
%ylabel('cumulative % variance');
%set(gca,'XTick',sort([0:10:num_dimensions NComponents]));
%set(gca,'YTick',sort([0:10:100 Y]));
%% Q3:
% Visualise the mean pose.
sequence_Y0 = makeSequence(num_frames, Mu, 0, E(:, 1));
%figure(2);
%skelPlayData(skeleton, sequence_Y0, frame_length);
% Visualise the first component.
sequence_Y1 = makeSequence(num_frames, Mu, Lambda(1), E(:, 1));
%figure(3);
%skelPlayData(skeleton, sequence_Y1, frame_length);
% Visualise the second component.
sequence_Y2 = makeSequence(num_frames, Mu, Lambda(2), E(:, 2));
%figure(4);
%skelPlayData(skeleton, sequence_Y2, frame_length);
%% Q4:
% Z: [NFrames x 2]
Z = projectSequence(Mu, E, sequence_X, 2);
%figure(5);
%line('XData', Z(:, 1), 'YData', Z(:, 2));
%xlabel('Component 1');
%ylabel('Component 2');
% skelPlayData(skeleton, sequence_Y, frame_length);

%% PART 2 ------------------------------------------------------------------
%% Q1:
figure(6);
Net = gtm1dinittrain(sequence_X, E, 50, 7, 200);
%% Q2:
P = gtmprob(Net, sequence_X)
L = sum(log(P));
%% PART 3 ------------------------------------------------------------------

%% PART 4 ------------------------------------------------------------------
