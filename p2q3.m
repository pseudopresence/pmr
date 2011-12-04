LLs = [];
CtrValues = [2 3 5 7 11 23];
for NCtrs = CtrValues
    LLs(size(LLs) + 1) = gtmTrainAndReport(sequence_X, E, 50, NCtrs);
end
figure;
plot(CtrValues, LLs);
LLs = [];
PtValues = [10 30 50 100 150];
for NPts = PtValues
    LLs(size(LLs) + 1) = gtmTrainAndReport(sequence_X, E, NPts, 7);
end
figure;
plot(PtValues, LLs);