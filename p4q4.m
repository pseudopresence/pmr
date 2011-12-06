[sequence_Z_LDS, V] = ldspost(sequence_X, Net);
figure;
line('XData', -sequence_Z_LDS(:, 2), 'YData', -sequence_Z_LDS(:, 1));
writeFigurePDF('p4q4.pdf');
