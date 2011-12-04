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
fprintf(1, 'Eigenvalue %d: %4.1f\n', 1, Lambda(1));
fprintf(1, 'Eigenvalue %d: %4.1f\n', 2, Lambda(2));
% Get the index of the first element in P which is >= 95.
NComponents = find(P >= 95, 1);
% Get its value.
Y = P(NComponents);
%figure;
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
%figure;
%skelPlayData(skeleton, sequence_Y0, frame_length);
% Visualise the first component.
sequence_Y1 = makeSequence(num_frames, Mu, Lambda(1), E(:, 1));
%figure;
%skelPlayData(skeleton, sequence_Y1, frame_length);
% Visualise the second component.
sequence_Y2 = makeSequence(num_frames, Mu, Lambda(2), E(:, 2));
%figure;
%skelPlayData(skeleton, sequence_Y2, frame_length);
%% Q4:
% Z: [NFrames x 2]
Z = projectSequence(Mu, E, sequence_X, 2);
%figure;
%line('XData', Z(:, 1), 'YData', Z(:, 2));
%xlabel('Component 1');
%ylabel('Component 2');
% skelPlayData(skeleton, sequence_Y, frame_length);

%% PART 2 ------------------------------------------------------------------
%% Q1:
% figure;
% Net = gtm1dinittrain(sequence_X, E, 50, 7, 200);
%% Q2:
% P: [NFrames x 1]
% P = gtmprob(Net, sequence_X);
% LL = sum(log(P));
% fprintf(1, 'Log likelihood of GTM model: %1.3e\n', LL);
%% Q3:
% LLs = [];
% CtrValues = [2 3 5 7 11 23];
% for NCtrs = CtrValues
%     LLs(size(LLs) + 1) = gtmTrainAndReport(sequence_X, E, 50, NCtrs);
% end
% figure;
% plot(CtrValues, LLs);
% LLs = [];
% PtValues = [10 30 50 100 150];
% for NPts = PtValues
%     LLs(size(LLs) + 1) = gtmTrainAndReport(sequence_X, E, NPts, 7);
% end
% figure;
% plot(PtValues, LLs);
%% Q4:
% Net2D = gtm2dinittrain(sequence_X, 50, 10, 50);
% Means = gtmlmean(Net2D, sequence_X);
% figure;
% line('XData', Means(:, 1), 'YData', Means(:, 2));
%% PART 3 ------------------------------------------------------------------
%% Q1:
% [F,Mu,DiagPsi,LL] = fa(sequence_X, 2, 50);
% MMu = repmat(Mu', [num_frames 1]);
% sequence_Z_FA = (sequence_X - MMu) * pinv(F)';
% figure;
% line('XData', sequence_Z_FA(:, 1), 'YData', sequence_Z_FA(:, 2));
%% Q2:
% [Deleted]
%% Q3:
% [No code]
%% Q4:
% LL = fallikelihood(sequence_X, F, DiagPsi, Mu);
% fprintf(1, 'Log likelihood of FA model: %1.3e\n', LL);
%% Q5:
% Compute a random permutation of the frames
NFrames = num_frames;
% Idx : 1 x NFrames
Idx = randperm(NFrames);
% RandSeq: [NFrames x NFeatures]
RandSeq = sequence_X(Idx, :);

NFolds = 7;
FoldSize = NFrames/NFolds;
Ms = [1 2 5 10 15 20 25]';
LLTrain = zeros(size(Ms));
LLTest = zeros(size(Ms));
LLFull = zeros(size(Ms));
for MIdx = 1:size(Ms)
    M = Ms(MIdx);
    LLTrainTot = 0;
    LLTestTot = 0;
    LLFullTot = 0;
    for V = 1:NFolds
        TestSet = RandSeq(1 : FoldSize, :);
        TrainSet = RandSeq(FoldSize + 1 : NFrames, :);
        RandSeq = circshift(RandSeq, 83);
        
        [F,Mu,DiagPsi,~] = fa(TrainSet, M, 50);
        
        LLTestTot = LLTestTot + fallikelihood(TestSet, F, DiagPsi, Mu);
        LLTrainTot = LLTrainTot + fallikelihood(TrainSet, F, DiagPsi, Mu);
    end
    LLTest(MIdx) = LLTestTot/NFolds;
    LLTrain(MIdx) = LLTrainTot/NFolds;
end
figure;
plot(Ms, LLTest*NFolds);
hold on;
plot(Ms, LLTrain);
    

%% Q6:
% [No code]
%% PART 4 ------------------------------------------------------------------
%% Q1:
% [No code]
%% Q2:
% rand('seed', 0);
% randn('seed', 0);
% Net = lds(sequence_X, 2);
% LL = lds_cl(Net, sequence_X, 2);
% fprintf(1, 'Log likelihood of LDS model: %1.3e\n', LL);
%% Q3:
% [No code]
%% Q4:
% [sequence_Z_LDS, V] = ldspost(sequence_X, Net);
% figure;
% line('XData', -sequence_Z_LDS(:, 2), 'YData', -sequence_Z_LDS(:, 1));
%% Q5:
% MMu = repmat(Net.Mu, [num_frames 1]);
% SeqRX = sequence_Z_LDS * Net.C' + MMu;
% skelPlayData(skeleton, SeqRX, frame_length);
%% Q6:
% TODO
%% Q7:
% TODO
%% Q8:
% TODO