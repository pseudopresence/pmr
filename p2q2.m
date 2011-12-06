% P: [NFrames x 1]
P = gtmprob(Net, sequence_X);
LL = sum(log(P));
[Log, Cleanup] = makeLogFile('p2q2.log');
fprintf(Log, 'Log likelihood of GTM model: %1.3e\n', LL);
