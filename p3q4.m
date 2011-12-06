LL = fallikelihood(sequence_X, F, DiagPsi, Mu);
[Log, Cleanup] = makeLogFile('p3q4.log');
fprintf(Log, 'Log likelihood of FA model: %1.3e\n', LL);
