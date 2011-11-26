function [Mu, E, Lambda, P] = getEigenvectors(Sequence)
% getEigenvectors computes the eigenvectors and eigenvalues of a dataset.
% INPUT Sequence: [NFrames x NFeatures]
%           Matrix with instances as rows and features as columns.
% OUTPUT Mu: [NFeatures x 1]
%           Column vector of means for each feature.
%        Lambda: [NFeatures x 1]
%           Column vector eigenvalues of covariance matrix, in descending
%           order.
%        E: [NFeatures x NFeatures]
%           Matrix whose columns are the eigenvectors of the covariance
%           matrix in corresponding order with the eigenvalues in lambda.
%        P: [NFeatures x 1]
%           Column vector of the cumulative percentage of variance
%           explained by each of the eigenvalues in lambda.

% Compute the mean vector for the sequence.
Mu = mean(Sequence)';
% Compute the eigendecomposition of the covariance matrix.
% V: [NFeatures x NFeatures] has the eigenvectors as columns.
% D: [NFeatures x NFeatures] is a diagonal matrix of the eigenvalues.
[V, D] = eig(cov(Sequence));
% Extract and sort the eigenvalues in descending order.
% I: [NFeatures x 1] stores the corresponding indices of the sorted entries
% in the original matrix.
[Lambda, I] = sort(diag(D), 1, 'descend');
% Use the index vector to get the sorted eigenvectors.
E = V(:, I);
% Get the cumulative sum of the variance % explained by each eigenvector.
P = 100 * cumsum(Lambda) / sum(Lambda);
