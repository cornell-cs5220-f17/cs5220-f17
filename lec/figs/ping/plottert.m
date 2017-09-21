for j = [1, 11, 23]

timings = load(sprintf('totient-%02d.txt', j))

s     = timings(:,1);
times = timings(:,2);
A     = [0*s+1, s];
ab    = A\times;
model = A*ab;

fp = fopen(sprintf('totient-%02d.tikz', j), 'w');
fprintf(fp, '\\begin{tikzpicture}\n');
fprintf(fp, '\\begin{axis}[legend pos=south east,height=6cm,width=\\textwidth,xlabel={Size (B)},ylabel={Time (s)}]\n');
fprintf(fp, '\\addplot coordinates {\n');
fprintf(fp, '  (%g,%g)\n', [s, times]');
fprintf(fp, '};\n\\addlegendentry{Data}\n');
fprintf(fp, '\\addplot coordinates {\n');
fprintf(fp, '  (%g,%g)\n', [s, model]');
fprintf(fp, '};\n\\addlegendentry{Model}\n');
fprintf(fp, '\\end{axis}\n');
fprintf(fp, '\\end{tikzpicture} \\\\\n');
fprintf(fp, '$\\alpha \\approx $ {\\tt %.2e},\n', ab(1));
fprintf(fp, '$\\beta \\approx $ {\\tt %.2e}\n', ab(2));
fclose(fp);

end
