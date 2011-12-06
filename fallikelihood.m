function LL = fallikelihood(Sequence, W, Psi, Mu)
% INPUT Sequence: [NFrames x NFeatures]
%           Matrix with instances as rows and features as columns.

[NFrames NFeatures] = size(Sequence);
C = W * W' + diag(Psi);
LL = 0;
for i = 1:NFrames
    FX = Sequence(i, :) - Mu';
    FL = -0.5 * FX/C * FX';
    LL = LL + FL;
end
LL = LL - 0.5 * NFrames * (logdet(C) + NFeatures * log(2 * pi));
