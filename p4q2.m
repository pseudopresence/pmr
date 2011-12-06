rand('seed', 0);
randn('seed', 0);
Net = lds(sequence_X, 2);
LL = lds_cl(Net, sequence_X, 2);
[Log, Cleanup] = makeLogFile('p4q2.log');
fprintf(Log, 'Log likelihood of LDS model: %1.3e\n', LL);
% Compute the angle between the subspaces defined by C and W
Theta = subspace(Net.C, W);
fprintf(Log, 'Angle between subspaces of C and W: %3.3e (radians)\n', Theta);
