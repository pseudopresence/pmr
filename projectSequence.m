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
[N, ~] = size(Seq);
NewSeq = zeros(size(Seq), class(Seq));
MMu = ones([N, 1], class(Mu)) * Mu';
Seq2 = Seq - MMu;
for i = 1 : N
    Z = dot(Seq2(i, :)', Eig);
    NewSeq(i, :) = Z * Eig;
end
NewSeq = NewSeq + MMu;