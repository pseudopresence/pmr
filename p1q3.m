% Visualise the mean pose.
sequence_Y0 = makeSequence(num_frames, Mu, 0, E(:, 1));
figure(2);
skelPlayData(skeleton, sequence_Y0, frame_length);
% Visualise the first component.
sequence_Y1 = makeSequence(num_frames, Mu, Lambda(1), E(:, 1));
figure(3);
skelPlayData(skeleton, sequence_Y1, frame_length);
% Visualise the second component.
sequence_Y2 = makeSequence(num_frames, Mu, Lambda(2), E(:, 2));
figure(4);
skelPlayData(skeleton, sequence_Y2, frame_length);