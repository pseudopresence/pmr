function [NewSeq] = projectSequence(Mu, Eig, Seq)
% projectSequence projects a data sequence onto one of its eigenvectors.
% INPUT Seq: [Frames x Features]
%           Input data sequence
%       Mu: [Features x 1]
%           Average of the features in the data sequence
%       Eig: [Features x 1]
%           Column eigenvector
% OUTPUT NewSeq: [Frames x Features]
%           The projected sequence
[N, F] = size(Seq);
MMu = repmat(Mu', [N, 1]);
MEig = repmat(Eig', [N, 1]);
Seq2 = Seq - MMu;
Z = dot(Seq2, MEig, 2);
MZ = repmat(Z, [1, F]);
NewSeq = MMu + MZ .* MEig;