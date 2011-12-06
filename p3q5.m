% Compute a random permutation of the frames
% NFrames = NFrames;
% Idx : 1 x NFrames
Idx = randperm(NFrames);
% RandSeq: [NFrames x NFeatures]
RandSeq = sequence_X(Idx, :);

NFolds = 7;
FoldSize = NFrames/NFolds;
Ms = [1 2 5 10 15 20 25]';
LLTrain = zeros(size(Ms));
LLTest = zeros(size(Ms));
for MIdx = 1:size(Ms)
    M = Ms(MIdx);
    LLTrainTot = 0;
    LLTestTot = 0;
    for V = 1:NFolds
        TestSet = RandSeq(1 : FoldSize, :);
        TrainSet = RandSeq(FoldSize + 1 : NFrames, :);
        RandSeq = circshift(RandSeq, 83);
        
        [W,Mu,DiagPsi,~] = fa(TrainSet, M, 50);
        
        LLTestTot = LLTestTot + fallikelihood(TestSet, W, DiagPsi, Mu);
        LLTrainTot = LLTrainTot + fallikelihood(TrainSet, W, DiagPsi, Mu);
    end
    % Compute the average across the NFolds runs
    LLTest(MIdx) = LLTestTot/NFolds;
    LLTrain(MIdx) = LLTrainTot/NFolds;
end
% We need to scale the log likelihoods by the number of instances in order
% to make them comparable.
LLTest = LLTest * NFolds;
LLTrain = LLTrain * NFolds / (NFolds-1);
figure;
plot(Ms, LLTest, 'g');
hold on;
plot(Ms, LLTrain, 'b');
writeFigurePDF('p3q5.pdf');
