function [ZSeq] = projectSequence(Mu, E, Seq, ZDims)
% projectSequence projects a data sequence onto the first ZDims components.
% INPUT Seq: [NFrames x NFeatures]
%           Input data sequence
%       Mu: [NFeatures x 1]
%           Average of the features in the data sequence
%       E: [NFeatures x NFeatures]
%           Column eigenvector matrix
% OUTPUT ZSeq: [NFrames x ZDims]
%           The projected sequence
[NFrames, ~] = size(Seq);
% Transformation to the reduced space
W = E(:, 1:ZDims);
% Replicate the mean into a matrix
MMu = repmat(Mu', [NFrames 1]);
% Perform the transformation
ZSeq = (Seq - MMu) * W;
