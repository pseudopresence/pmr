function LL = fallikelihood(Sequence, W, Psi, Mu)
% INPUT Sequence: [NFrames x NFeatures]
%           Matrix with instances as rows and features as columns.
% TODO comment
% TODO fa.m contains more wizardly implementation I don't understand :(
[NFrames NFeatures] = size(Sequence);
C = W * W' + diag(Psi);
DetC = det(C);
InvC = inv(C);
LL = 0;
for i = 1:NFrames
    FX = Sequence(i, :) - Mu';
    FL = -0.5 * FX * InvC * FX';
    LL = LL + FL;
end
LL = LL - 0.5 * NFrames * (log(DetC) + NFeatures * log(2 * pi));