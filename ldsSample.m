function [SeqY, SeqZ] = ldsSample(NFrames, Net, Noise)
% ldsSample samples a sequence from the provided LDS model.
% INPUT NFrames: [1 x 1]
%           The number of frames to sample.
%       Net: [1 x 1] structure
%           The structure containing the trained model.
%       Noise: [1 x 1]
%           A scaling to apply to the noise in the model.
% OUTPUT SeqY: [NFrames x NFeatures]
%           The sampled sequence in data space.
%        SeqZ: [NFrames x NLatent]
%           The sampled sequence in latent space.

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

