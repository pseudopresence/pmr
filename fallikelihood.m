function L = fallikelihood(X, W, Psi, Mu)
% TODO
[NFrames NFeatures] = size(X);
C = W * W' + diag(Psi);
DetC = det(C);
InvC = inv(C);
L = 0;
for i = 1:NFrames
    FX = X(i, :) - Mu;
    FL = -0.5 * FX' * InvC * FX;
    L = L + FL;
end
L = L - 0.5 * NFrames * log(DetC);
L = L - 0.5 * NFrames * NFeatures * log(2 * pi);