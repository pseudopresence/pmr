[Mu, E, Lambda, P] = getEigenvectors(sequence_X);
fprintf(1, 'Eigenvalue %d: %4.1f\n', 1, Lambda(1));
fprintf(1, 'Eigenvalue %d: %4.1f\n', 2, Lambda(2));
% Get the index of the first element in P which is >= 95.
NComponents = find(P >= 95, 1);
% Get its value.
Y = P(NComponents);
figure;
plot(P);
line([4 4], [0 Y]);
line([0 4], [Y Y]);
xlabel('number of components');
ylabel('cumulative % variance');
set(gca,'XTick',sort([0:10:num_dimensions NComponents]));
set(gca,'YTick',sort([0:10:100 Y]));