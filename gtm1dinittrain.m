% PMR assignment 2
% Nov 2011
% S. M. Ali Eslami
% s.m.eslami@sms.ed.ac.uk

%
% Initialise and train a GTM model with a 1D latent space. 
%
% IN
%   X                       - the data matrix
%   E                       - sorted eigenvectors of the data
%   num_latent_points       - the number of data points
%                             sampled in the latent space
%   num_rbf_centres         - the number of centres in the RBF model
%   num_iterations          - the number of EM iterations
%
% OUT
%   net                     - Netlab's GTM data-structure
%

function net = gtm1dinittrain(X, E, num_latent_points, num_rbf_centres, num_iterations)

    num_frames = size(X, 1);
    num_dimensions = size(X, 2);
    mu = mean(X);

    % create the GTM data structure
    net = gtm(1, num_latent_points, num_dimensions, num_rbf_centres, 'gaussian');

    % initialise the GTM
    options = zeros(1, 18);
    options(7) = 1;
    net = gtminit(net, options, X, 'regular', num_latent_points, num_rbf_centres);
            
    % generate a unit circle figure, to be used for plotting
    src = (0:(2*pi)/(num_latent_points-1):2*pi)';
    unitC = [sin(src) cos(src)];

    % train GTM model for num_iterations iterations
    options = zeros(1, 18);
    options(1) = -1;
    options(2) = 1e-4;
    options(3) = 1e-4;
    options(4) = 1e-6;
    options(14) = 1;
    options(16) = 1e-8;
        
    fprintf('EM training of GTM...\n');
    
    for j=1:num_iterations
        
      % perform 1 EM iteration
      [net, options] = gtmem(net, X, options);
      
      fprintf('Cycle %4d  Error %11.6f\n', j, options(8));
      
      % project into data-space
      mix = gtmfwd(net);
      
      % visualize current state
      hold off
      Z = X * E;
      scatter(Z(:, 1), Z(:, 2));
      hold on;
      
      for i=1:num_latent_points
          
          p = mix.centres(i, :) * E;
          y = p(1);
          x = p(2);
          
          c = 2*unitC*sqrt(mix.covars(1)) + ...
              [ones(num_latent_points,1)*y ...
               ones(num_latent_points,1)*x];
               
          fill(c(:,1), c(:,2), [0.8 1 0.8]);
          
          plot(y, x, 'g');
          plot(y, x, 'g+');
          
      end
      
      title(['After ', int2str(j),' iterations of training.']);
      drawnow;
      pause(0.1);

    end

end
