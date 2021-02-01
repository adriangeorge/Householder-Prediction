function [x] = SST(A, b) 
%la fel ca Householder, solutia luata de pe Moodle (laborator 2)

  n = min(size(A,1),size(A,2));
  x = zeros(1,n);
  for i = n:-1:1
    sum = 0;

    for j = i+1:n

      sum += A(i,j)*x(j);

    endfor

    x(i) = (b(i)-sum)/A(i,i);
  endfor
end