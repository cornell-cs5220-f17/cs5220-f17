load laptop.txt

s     = laptop(:,1);
times = laptop(:,2);
A     = [0*s+1, s];
ab    = A\times;
model = A*ab;

fp = fopen('laptop.tikz', 'w');
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
