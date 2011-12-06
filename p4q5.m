MMu = repmat(Net.Mu, [NFrames 1]);
sequence_Y_reconstructed = sequence_Z_LDS * Net.C' + MMu;
figure;
skelPlayData(skeleton, sequence_Y_reconstructed, frame_length);
