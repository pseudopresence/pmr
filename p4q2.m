rand('seed', 0);
randn('seed', 0);
Net = lds(sequence_X, 2);
LL = lds_cl(Net, sequence_X, 2);
fprintf(1, 'Log likelihood of LDS model: %1.3e\n', LL);