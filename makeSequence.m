function [NewSeq] = makeSequence(NFrames, Mu, Lambda, Eig)
% makeSequence makes a sequence showing 1 stdev along Eig.
% INPUT NFrames: [1]
%           The number of frames to generate.
%       Mu: [NFeatures x 1]
%           The average pose.
%       Lambda: [1]
%           The variance along Eig.
%       Eig: [NFeatures x 1]
%           The eigenvector along which to animate.
% OUTPUT NewSeq: [NFrames x NFeatures]
%           The generated sequence.

% Replicate the mean into a matrix. MMu: [NFrames x NFeatures]
MMu = repmat(Mu', [NFrames 1]);
% Lambda is the variance along the eigenvector; take the standard dev.
StDev = sqrt(Lambda);
% Linear interpolation from -StDev to +StDev. Z: [NFrames x 1]
Z =  2 * StDev * (0 : NFrames-1)'/(NFrames - 1) - StDev;
% Pose reconstruction.
NewSeq = MMu + Z * Eig';