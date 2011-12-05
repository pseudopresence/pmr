function [] = writeFigurePDF(Fig, FileName)
% writeFigure writes the current figure to a pdf file
% INPUT Fig: [optional] the figure to write; default is the current figure.
%       FileName: a string containing the path of the file to save to.

if nargin < 2
    FileName = Fig;
    Fig = gcf;
end
FileNameRoot = regexp(FileName, '(.*)\.pdf$', 'tokens');
FileNameEPS = [FileNameRoot{1}{1} '.eps'];
print(Fig, '-deps', FileNameEPS);
[Status, ~] = unix(['epstopdf ' FileNameEPS]);
if Status ~= 0
    fprintf(2, 'Error running epstopdf!\n');
end
