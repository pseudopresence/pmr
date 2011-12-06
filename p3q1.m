[W,Mu,DiagPsi,~] = fa(sequence_X, 2, 50);
MMu = repmat(Mu', [NFrames 1]);
sequence_Z_FA = (sequence_X - MMu) * pinv(W)';
figure;
line('XData', sequence_Z_FA(:, 1), 'YData', sequence_Z_FA(:, 2));
writeFigurePDF('p3q1.pdf');
