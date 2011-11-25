function [NewSeq] = projectSequence(Mu, Eig, Seq)
% projectSequence projects a data sequence onto one of its eigenvectors.
% INPUT Seq: [NFrames x NFeatures]
%           Input data sequence
%       Mu: [NFeatures x 1]
%           Average of the features in the data sequence
%       Eig: [NFeatures x 1]
%           Column eigenvector
% OUTPUT NewSeq: [NFrames x NFeatures]
%           The projected sequence
[NFrames, ~] = size(Seq);
NewSeq = zeros(size(Seq), class(Seq));
for i = 1 : NFrames
    % Find length of the projection of the frame's deviation from the mean
    Z = dot(Seq(i, :)' - Mu, Eig);
    % Reconstruct frame based on that length alone
    NewSeq(i, :) = Mu + Z * Eig;
end