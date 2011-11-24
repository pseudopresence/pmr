% function [F,mu,diagPsi,LL]=fa(X,K,cyc,tol)
%
% Maximum Likelihood Factor Analysis using EM
%
% Based on David Barber's BRML toolbox:
% http://web4.cs.ucl.ac.uk/staff/D.Barber/pmwiki/pmwiki.php?n=Main.Textbook
%
% X - data matrix
% K - number of factors
% cyc - maximum number of cycles of EM (default 100)
% tol - termination tolerance (change in likelihood) (default 0.0001)
%
% F - factor loadings
% diagPsi - diagonal of uniquenesses matrix
% mu - mean of X
% LL - log likelihood curve
%
% Iterates until a change < tol in the log likelihood
% or cyc steps of EM
%

function [F,mu,diagPsi,LL]=fa(X,K,cyc,tol)

if nargin<4  tol=0.0001; end;
if nargin<3  cyc=100; end;

X = X';
[V N] = size(X);
mu = mean(X,2);
S = cov(X',1);
X = X - repmat(mu,1,N);
diagPsi=ones(V,1);
tmpold=-inf;
for loop=1:cyc
    diagSqrtPsi = sqrt(diagPsi);
    Xtilde = diag(1./diagSqrtPsi)*X/sqrt(N);
    [U,LambdaTilde,V] = svd(Xtilde,0);
    Uh = U(:,1:K); diagLambda=diag(LambdaTilde(1:K,1:K)).^2;
    F = diag(diagSqrtPsi)*Uh*diag(sqrt(diagLambda-1));
    SigmaD = F*F'+diag(diagPsi);
    tmp = -0.5*N*(trace(SigmaD\S) +logdet(2*pi*SigmaD));
    if  isreal(tmp)
        LL(loop) = tmp;
        if tmp - tmpold < tol; break; end
        tmpold=tmp;
        fprintf('Cycle %4d  Log likelihood %11.6f\n',loop,LL(end));
    end
    diagPsi = diag(S-F*F');
end

end