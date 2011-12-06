Net2D = gtm2dinittrain(sequence_X, 50, 10, 50);
% Compute the mean latent projection of the sequence
Means = gtmlmean(Net2D, sequence_X);
figure;
line('XData', Means(:, 1), 'YData', Means(:, 2));
writeFigurePDF('p2q4.pdf');
