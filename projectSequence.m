function [ZSeq] = projectSequence(Mu, Eig, Seq)
% projectSequence projects a data sequence onto one of its eigenvectors.
% INPUT Seq: [NFrames x NFeatures]
%           Input data sequence
%       Mu: [NFeatures x 1]
%           Average of the features in the data sequence
%       Eig: [NFeatures x 1]
%           Column eigenvector
% OUTPUT ZSeq: [NFrames x 1]
%           The projected sequence
[NFrames, ~] = size(Seq);
ZSeq = zeros([NFrames 1], class(Seq));
for i = 1 : NFrames
    % Find length of the projection of the frame's deviation from the mean
    ZSeq(i) = dot(Seq(i, :)' - Mu, Eig);
end