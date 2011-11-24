function [Mu, E, Lambda, P] = getEigenvectors(Sequence)
% getEigenvectors computes the eigenvectors and eigenvalues of a dataset.
% INPUT Sequence:
%           Matrix with instances as rows and features as columns.
% OUTPUT Mu:
%           Column vector of means for each feature.
%        Lambda:
%           Column vector eigenvalues of covariance matrix, in descending
%           order.
%        E:
%           Matrix whose columns are the eigenvectors of the covariance
%           matrix in corresponding order with the eigenvalues in lambda.
%        P:
%           Column vector of the cumulative percentage of variance
%           explained by each of the eigenvalues in lambda.

% Compute the mean vector and covariance matrix for the sequence
Mu = mean(Sequence)';
Cov = cov(Sequence);
% Compute a matrix V with the eigenvectors as columns,
% and a diagonal matrix D of the corresponding eigenvalues.
[V, D] = eig(Cov);
% Get the eigenvalues as a column vector
L = diag(D);
% Sort the eigenvalues in descending order, and get the corresponding
% indices of the sorted entries in the original matrix
[Lambda, I] = sort(L, 1, 'descend');
% Use the index vector to get the sorted eigenvectors
E = V(:, I);
% Get the cumulative sum of the variances explained by each eigenvector
P = 100 * cumsum(Lambda) / sum(Lambda);
    