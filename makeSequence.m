function [NewSeq] = makeSequence(NFrames, Mu, Lambda, Eig)
% makeSequence makes a sequence showing 1 stdev along Eig.
% INPUT NFrames: [1]
%           The number of frames to generate
%       Mu: [NFeatures x 1]
%           The average pose
%       Lambda: [1]
%           The variance along Eig
%       Eig: [NFeatures x 1]
%           The eigenvector along which to animate
% OUTPUT NewSeq: [NFrames x NFeatures]
%           The generated sequence
Z_max = sqrt(Lambda);
Z_min = -Z_max;
NewSeq = zeros([NFrames size(Eig, 1)], class(Eig));
for i = 1 : NFrames
    % Linear interpolation
    Z = Z_min + (Z_max - Z_min)*(i - 1)/(NFrames - 1);
    % Pose resonstruction
    NewSeq(i, :) = Mu + Z * Eig;
end