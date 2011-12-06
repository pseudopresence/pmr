% Without noise
[sequence_Y_sampled, sequence_Z_sampled] = ldsSample(NFrames, Net, 0);
figure;
line('XData', -sequence_Z_sampled(:, 2), 'YData', -sequence_Z_sampled(:, 1));
writeFigurePDF('p4q6-nonoise.pdf');
figure;
skelPlayData(skeleton, sequence_Y_sampled, frame_length);
% With noise
[sequence_Y_sampled, sequence_Z_sampled] = ldsSample(NFrames, Net, 1);
figure;
line('XData', -sequence_Z_sampled(:, 2), 'YData', -sequence_Z_sampled(:, 1));
writeFigurePDF('p4q6-withnoise.pdf');
figure;
skelPlayData(skeleton, sequence_Y_sampled, frame_length);
