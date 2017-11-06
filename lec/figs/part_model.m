function part_model

xy = [1, 0;
      2, 1;
      0, 1;
      1, 2;
      3, 2;
      3, 0;
      4, 1;
      5, 2;
      4, 3;
      6, 3;
      5, 4];
      
n  = size(xy,1);      
xy = xy + 0.2*[cos(1:n)', sin(1:n)'];

Ae = [0, 1;
      0, 2;
      0, 5;
      1, 2;
      1, 3;
      1, 4;
      1, 5;
      1, 6;
      2, 3;
      3, 4;
      4, 6;
      4, 7;
      4, 8;
      5, 6;
      6, 7;
      7, 8;
      7, 9;
      8, 9;
      8, 10;
      9, 10] + 1;

ne = size(Ae,1);

A = sparse(Ae(:,1), Ae(:,2), ones(ne,1), n, n);
A = A+A';

% -- Print basic plot
fp = fopen('figs/part_ref.tikz', 'w');
for j = 1:n
  fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=blue] {};\n', j, xy(j,:));
end
for j = 1:ne
  fprintf(fp, '\\draw[ultra thick] (n%d) -- (n%d);\n', Ae(j,:));
end
fclose(fp);

% -- Print basic plot as adjacency
fp = fopen('figs/part_matrix.tikz', 'w');
fprintf(fp, '\\draw (-0.3,0) rectangle (%f,%f);\n', n*0.3,(n+1)*0.3);
for i = 1:n
  for j = 1:n
    if A(i,j)
      fprintf(fp, '\\filldraw[blue] (%f,%f) circle (3pt);\n', (n-i)*0.3, j*0.3);
    end
  end
end
fclose(fp);

% -- Vertex separator
vsep = [5, 7];
I = zeros(n,1);
I(vsep) = 1;
vcolors = {'blue', 'red'};
fp = fopen('figs/part_vsep.tikz', 'w');
for j = 1:n
  fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=%s] {};\n', j, ...
          xy(j,1), xy(j,2), vcolors{I(j)+1});
end
for j = 1:ne
  if I(Ae(j,1)) + I(Ae(j,2)) == 0
    fprintf(fp, '\\draw[ultra thick] (n%d) -- (n%d);\n', Ae(j,:));
  else
    fprintf(fp, '\\draw              (n%d) -- (n%d);\n', Ae(j,:));
  end
end
fclose(fp);

% -- Edge separator
I = zeros(n,1);
I(5:end) = 1;
I(6) = 0;
fp = fopen('figs/part_esep.tikz', 'w');
plot_esep(fp, xy, Ae, I);
fclose(fp);

% -- Coordinate bisection
I = zeros(n,1);
xs = sort(xy(:,1));
thresh = median(xs);
I(xy(:,1) > thresh) = 1;
fp = fopen('figs/part_esep_bisect.tikz', 'w');
plot_esep(fp, xy, Ae, I);
fprintf(fp, '\\draw[blue,ultra thick,dotted] (%f,%f) -- (%f,%f);\n', ...
        thresh, min(xy(:,2))-1,thresh, max(xy(:,2))+1);
fclose(fp);

% -- Refinement picture
Is = I*[1, 1];
Is([5,7],2) = Is([7,5],2);
colors = {'blue', 'red'};
fp = fopen('figs/part_swap0.tikz', 'w');
for k = 1:2
  I = Is(:,k);
  fprintf(fp, '\\begin{scope}[xshift=%fcm]\n', (k-1)*1.2*max(xy(:,1)));
  for j = 1:n
    fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=%s] {};\n', ...
            j, xy(j,:), colors{I(j)+1});
  end
  ncut = 0;
  for j = 1:ne
    if I(Ae(j,1)) == I(Ae(j,2))
      fprintf(fp, '\\draw[    ultra thick       ] (n%d) -- (n%d);\n', Ae(j,:));
    else
      fprintf(fp, '\\draw[red,ultra thick,dashed] (n%d) -- (n%d);\n', Ae(j,:));
      ncut = ncut + 1;
    end
  end
  fprintf(fp, '\\node at (%f,-1) {Cut size: %d};\n', median(xy(:,1)), ncut);
  fprintf(fp, '\\end{scope}\n');
end
fclose(fp);

% -- Inertial bisection
xm = mean(xy);
r  = xy-ones(n,1)*xm;
II = norm(r, 'fro')^2*eye(2) - r'*r;
[V,D] = eig(II);
lambda = diag(D);
[dmin, Imin] = min(lambda);
[dmax, Imax] = max(lambda);
I = zeros(n,1);
I(r*V(:,Imin) > 0) = 1;
fp = fopen('figs/part_esep_inertia.tikz', 'w');
plot_esep(fp, xy, Ae, I);
s = 2/lambda(Imax);
fprintf(fp, '\\draw[black!50,ultra thick,<->] (%f,%f) -- (%f,%f);\n', ...
        xm'-s*lambda(Imin)*V(:,Imin), xm'+s*lambda(Imin)*V(:,Imin));
fprintf(fp, '\\draw[black!50,ultra thick,<->] (%f,%f) -- (%f,%f);\n', ...
        xm'-s*lambda(Imax)*V(:,Imax), xm'+s*lambda(Imax)*V(:,Imax));

fprintf(fp, '\\draw[blue, ultra thick,dotted] (%f,%f) -- (%f,%f);\n', ...
        xm'-3*V(:,Imax), xm'+3*V(:,Imax));
fclose(fp);

% -- Spectral partitioning
L = full(A);
L = diag(sum(L))-L;
[V,D] = eig(L);
[lambda,idx] = sort(diag(D));
V = V(:,idx);
vv = V(:,2);
vv = vv/norm(vv,inf);
I = zeros(n,1);
I(vv >= 0) = 1;
fp = fopen('figs/part_esep_spectral.tikz', 'w');
for j = 1:n
  if vv(j) < 0
    fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=blue!%d] {};\n', ...
            j, xy(j,:), ceil(-vv(j)*100));
  else
    fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=red!%d] {};\n', ...
            j, xy(j,:), ceil(vv(j)*100));
  end
end
for j = 1:ne
  if I(Ae(j,1)) == I(Ae(j,2))
    fprintf(fp, '\\draw[    ultra thick       ] (n%d) -- (n%d);\n', Ae(j,:));
  else
    fprintf(fp, '\\draw[red,ultra thick,dashed] (n%d) -- (n%d);\n', Ae(j,:));
  end
end
fclose(fp);

% -- Spectral embedding
fp = fopen('figs/part_spec_embed.tikz', 'w');
xys = 5*V(:,2:3);
plot_esep(fp, xys, Ae, I);
fprintf(fp, '\\draw[blue, ultra thick,dotted] (0,%f) -- (0,%f);\n', ...
        1.25*min(xys(:,2)), 1.25*max(xys(:,2)));
fclose(fp);

% -- Max matching picture
matching = [0, 1;
            2, 2;
            3, 4;
            5, 6;
            7, 8;
            9, 10] + 1;
nm = size(matching,1);

fp = fopen('figs/part_matching.tikz', 'w');
for j = 1:n
  fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=blue] {};\n', j, xy(j,:));
end
for j = 1:ne
  fprintf(fp, '\\draw (n%d) -- (n%d);\n', Ae(j,:));
end
for j = 1:nm
  fprintf(fp, '\\draw[ultra thick] (n%d) -- (n%d);\n', matching(j,:));
end
fclose(fp);

% -- Coarsened picture
P = zeros(n, nm);
for j = 1:nm
  P(matching(j,:),j) = 1;
end
Ac = P'*A*P;
xyc = P\xy;
[iAec,jAec,wAec] = find(triu(Ac));
Aec = [iAec,jAec];

fp = fopen('figs/part_coarse.tikz', 'w');
for j = 1:nm
  fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=blue] {};\n', j, xyc(j,:));
end
for j = 1:size(Aec,1)
  fprintf(fp, '\\draw[line width=%dpt] (n%d) -- (n%d);\n', 2*wAec(j), Aec(j,:));
end
fclose(fp);

% -- BFS and plot
nstart = 3;
d = zeros(n,1); d(:) = inf;
marks = zeros(n,1);
d(nstart) = 0;
marks(nstart) = 1;
for j = 1:n
  Ij = find(A*marks);
  d(Ij) = min(d(Ij), j);
  marks(Ij) = 1;
end

fp = fopen('figs/part_bfs.tikz', 'w');
colors = {'blue', 'blue!50', 'black!25', 'red!50', 'red'};
for j = 1:n
  fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=%s] {};\n', j, xy(j,:), colors{d(j)+1});
end
for j = 1:ne
  fprintf(fp, '\\draw[ultra thick] (n%d) -- (n%d);\n', Ae(j,:));
end
fclose(fp);

end

function plot_esep(fp, xy, Ae, I)

  n  = size(xy,1);
  ne = size(Ae,1);
  for j = 1:n
    fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=blue] {};\n', j, xy(j,:));
  end
  for j = 1:ne
    if I(Ae(j,1)) == I(Ae(j,2))
      fprintf(fp, '\\draw[    ultra thick       ] (n%d) -- (n%d);\n', Ae(j,:));
    else
      fprintf(fp, '\\draw[red,ultra thick,dashed] (n%d) -- (n%d);\n', Ae(j,:));
    end
  end

end