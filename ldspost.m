% PMR assignment 2
% Nov 2011
% S. M. Ali Eslami
% s.m.eslami@sms.ed.ac.uk

%
% Computes the posterior means and covariances for a sequence X under the
% FA model defined by net.
%
% IN
%   net     - the parameters of the learned LDS model
%   X       - the data
%
% OUT
%   x       - the posterior means
%   V       - the posterior covariances (Eq. 13.98 in Bishop, 2006).
%

function [x, V] = ldspost(X, net)

    Xm = X - repmat(net.Mu, size(X, 1), 1);
    
    [~, x, V] = kalmansmooth(net.A, net.C, net.Q, net.R, net.x0, net.P0, permute(Xm, [3 2 1]));
    
    x = permute(x, [3 2 1]);

end