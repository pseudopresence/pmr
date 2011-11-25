% PMR assignment 2
% Nov 2011
% S. M. Ali Eslami
% s.m.eslami@sms.ed.ac.uk

% Remember, there are only a limited number of licences for MATLAB. After 
% you have finished using MATLAB, quit from the MATLAB session so that 
% others can work.

% INITIALISATION ----------------------------------------------------------

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

% DEMO --------------------------------------------------------------------

% visualise the loaded data
% skelPlayData(skeleton, sequence_X, frame_length);

% PART 1 ------------------------------------------------------------------

% Q1: getEigenvectors.m
% Q2:
[Mu, E, Lambda, P] = getEigenvectors(sequence_X);
% Get the value of the first element in P which is >= 95
%Y = P(find(P >= 95, 1));
%plot(P);
%line([4 4], [0 Y]);
%line([0 4], [Y Y]);
% Q3:
sequence_Y = projectSequence(Mu, E(:, 1), sequence_X);
skelPlayData(skeleton, sequence_Y, frame_length);

% PART 2 ------------------------------------------------------------------

% PART 3 ------------------------------------------------------------------

% PART 4 ------------------------------------------------------------------
