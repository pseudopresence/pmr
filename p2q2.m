% P: [NFrames x 1]
P = gtmprob(Net, sequence_X);
LL = sum(log(P));
fprintf(1, 'Log likelihood of GTM model: %1.3e\n', LL);