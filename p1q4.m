% Z: [NFrames x 2]
Z = projectSequence(Mu, E, sequence_X, 2);
figure(5);
line('XData', Z(:, 1), 'YData', Z(:, 2));
xlabel('Component 1');
ylabel('Component 2');