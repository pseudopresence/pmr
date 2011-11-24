% PMR assignment 2
% Nov 2011
% S. M. Ali Eslami
% s.m.eslami@sms.ed.ac.uk

%
% Initialise and train a GTM model with a 2D latent space. 
%
% IN
%   X                       - the data matrix
%   num_latent_points       - the number of data points sampled in 
%                             the latent space per dimension
%   num_rbf_centres         - the number of centres in the RBF
%                             model per dimension
%   num_iterations          - the number of EM iterations
%
% OUT
%   net                     - Netlab's GTM data-structure
%

function net = gtm2dinittrain(X, num_latent_points, num_rbf_centres, num_iterations)

    num_dimensions = size(X, 2);

    % create the GTM data structure
    net = gtm(2, num_latent_points^2, num_dimensions, num_rbf_centres^2, 'gaussian');

    % initialise the GTM
    options = zeros(1, 18);
    options(7) = 1;
    net = gtminit(net, options, X, 'regular', [num_latent_points num_latent_points], [num_rbf_centres num_rbf_centres]);
    
    % now train GTM model for num_iterations iterations
    options = zeros(1, 18);
    options(1) = 1;
    options(2) = 1e-4;
    options(3) = 0;
    options(4) = 1e-6;
    options(14) = num_iterations;
    options(16) = 1e-8;
    
    % perform EM iterations
    fprintf('EM training of GTM...\n');
    net = gtmem(net, X, options);

end
