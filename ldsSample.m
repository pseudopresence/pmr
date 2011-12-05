function [SeqY, SeqZ] = ldsSample(NFrames, Net, Noise)
% TODO
[NFeatures NLatent] = size(Net.C);
SeqY = zeros(NFrames, NFeatures);
SeqZ = zeros(NFrames, NLatent);
SeqZ(1, :) = Net.x0;
for I = 2 : NFrames
    SeqZ(I, :) = Net.A * SeqZ(I - 1, :)' + Noise * gsamp(zeros([1 NLatent]), Net.Q, 1)';
end
for I = 1 : NFrames
    SeqY(I, :) = Net.C * SeqZ(I, :)' + Net.Mu';
end

