[F,Mu,DiagPsi,LL] = fa(sequence_X, 2, 50);
MMu = repmat(Mu', [num_frames 1]);
sequence_Z_FA = (sequence_X - MMu) * pinv(F)';
figure;
line('XData', sequence_Z_FA(:, 1), 'YData', sequence_Z_FA(:, 2));