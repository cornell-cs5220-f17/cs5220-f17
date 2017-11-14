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

% Run Luby's algorithm
S = zeros(n,1);
C = ones(n,1);
colors = {'blue!30', 'red!20', 'black!20'};

step = 1;
while sum(C) > 0

  r = rand(n,1);
  M = A .* (r*C') + 10*(1-A)';
  nbr_mins = min(M);

  for i = 1:n
    if r(i) < nbr_mins(i)
      S(i) = 1;
      C(i) = 0;
      C = C .* (1-A(:,i));
    end
  end
  
  % -- Print basic plot
  fp = fopen(sprintf('figs/mis_luby%d.tikz', step), 'w');
  for j = 1:n
    if C(j)
      color = "blue";
    elseif S(j)
      color = "red";
    else
      color = "black";
    end
    fprintf(fp, '\\node (n%d) at (%f,%f) [circle,fill=%s!20] {\\small %.2f};\n', j, xy(j,:), color, r(j)*10);
  end
  for j = 1:ne
    fprintf(fp, '\\draw[ultra thick] (n%d) -- (n%d);\n', Ae(j,:));
  end
  fclose(fp);

  step = step + 1;
  if step > 10
    break;
  end
end
