% Vary the number of RBF Centers
LLs_byNCtrs = [];
CtrValues = [2 3 5 7 11 23];
for NCtrs = CtrValues
    LLs_byNCtrs(end + 1) = gtmTrainAndReport(sequence_X, E, 50, NCtrs);
    writeFigurePDF(sprintf('p2q3-%ds-%dc.pdf', 50, NCtrs));
end
figure;
plot(CtrValues, LLs_byNCtrs);
writeFigurePDF('p2q3-plotByCtrs.pdf');
% Vary the number of sample points
LLs_ByNPts = [];
PtValues = [10 30 50 100 150];
for NPts = PtValues
    LLs_ByNPts(end + 1) = gtmTrainAndReport(sequence_X, E, NPts, 7);
    writeFigurePDF(sprintf('p2q3-%ds-%dc.pdf', NPts, 7));
end
figure;
plot(PtValues, LLs_ByNPts);
writeFigurePDF('p2q3-plotByPts.pdf');
