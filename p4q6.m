sequence_Y_sampled = zeros(NFrames, NFeatures);
sequence_Z_sampled = zeros(NFrames, 2);
sequence_Z_sampled(1, :) = Net.x0;
% Without noise
Noise = 1;
for I = 2 : NFrames
    sequence_Z_sampled(I, :) = Net.A * sequence_Z_sampled(I - 1, :)' + Noise * gsamp(zeros([1 2]), Net.Q, 1)';
end
for I = 1 : NFrames
    sequence_Y_sampled(I, :) = Net.C * sequence_Z_sampled(I, :)' + Net.Mu';
end
skelPlayData(skeleton, sequence_Y_sampled, frame_length);
