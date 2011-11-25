Z1 = projectSequence(Mu, E(:, 1), sequence_X);
Z2 = projectSequence(Mu, E(:, 2), sequence_X);
figure(5);
line('XData', Z1, 'YData', Z2);
xlabel('Component 1');
ylabel('Component 2');