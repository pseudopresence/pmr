% Visualise the mean pose.
sequence_Y0 = makeSequence(NFrames, Mu, 0, E(:, 1));
figure;
skelPlayData(skeleton, sequence_Y0, frame_length);
writeFigurePDF('p1q3-mean.pdf');
% Visualise the first component.
sequence_Y1 = makeSequence(NFrames, Mu, Lambda(1), E(:, 1));
figure;
skelPlayData(skeleton, sequence_Y1, frame_length);
writeFigurePDF('p1q3-comp1.pdf');
% Visualise the second component.
sequence_Y2 = makeSequence(NFrames, Mu, Lambda(2), E(:, 2));
figure;
skelPlayData(skeleton, sequence_Y2, frame_length);
writeFigurePDF('p1q3-comp2.pdf');
