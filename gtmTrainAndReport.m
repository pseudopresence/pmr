function [LL] = gtmTrainAndReport(Sequence, E, Pts, Ctrs)
% gtmTrainAndReport trains a gtm model displaying a figure.
% INPUT Sequence: [NFrames x NFeatures]
%           Matrix with instances as rows and features as columns.
%        E: [NFeatures x NFeatures]
%           Matrix whose columns are the eigenvectors of the covariance
%           matrix in corresponding order with the eigenvalues in lambda.
%        Pts: [1 x 1]
%           The number of latent points to use.
%        Ctrs: [1 x 1]
%           The number of rbf centers to use.
% OUTPUT LL: [1 x 1]
%           The log likelihood of the Sequence under the trained model.

figure;
Net = gtm1dinittrain(Sequence, E, Pts, Ctrs, 200);
% P: [NFrames x 1]
P = gtmprob(Net, Sequence);
LL = sum(log(P));
