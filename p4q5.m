MMu = repmat(Net.Mu, [num_frames 1]);
SeqRX = sequence_Z_LDS * Net.C' + MMu;
skelPlayData(skeleton, SeqRX, frame_length);