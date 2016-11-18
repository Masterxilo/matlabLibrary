% Initialize unary and pairwise
W = 10;
H = 5;
pairwise = sparse(50,50);
unary = zeros(2,50); 

for row = 0:H-1
  for col = 0:W-1
    pixel = 1+ row*W + col;
    if row+1 < H, pairwise(pixel, 1+col+(row+1)*W) = 1; end
    if row-1 >= 0, pairwise(pixel, 1+col+(row-1)*W) = 1; end 
    if col+1 < W, pairwise(pixel, 1+(col+1)+row*W) = 1; end
    if col-1 >= 0, pairwise(pixel, 1+(col-1)+row*W) = 1; end 
    if pixel < 25
      unary(:,pixel) = [0 10]'; 
    else
      unary(:,pixel) = [10 0]'; 
    end
  end
end

N = 3;
unary = [-1 -2 0;-1 -3 0];

pairwise = [0 0 1;1 0 0;0 0 1];

% init labelcost (a-priori probability for a certain label?)
labelcost = [0 1;1 0];

% Call GCMex()
[labels E Eafter] = GCMex(zeros(N,1), single(unary), sparse(pairwise), single(labelcost),0);

fprintf('E: %d (should be 260), Eafter: %d (should be 44)\n', E, Eafter);
fprintf('unique(labels) should be [0 4] and is: [');
fprintf('%d ', labels);
fprintf(']\n');
