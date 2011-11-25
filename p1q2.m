[Mu, E, Lambda, P] = getEigenvectors(sequence_X);
% Get the value of the first element in P which is >= 95
NComponents = find(P >= 95, 1);
Y = P(NComponents);
figure(1);
plot(P);
line([4 4], [0 Y]);
line([0 4], [Y Y]);
xlabel('number of components');
ylabel('cumulative % variance');