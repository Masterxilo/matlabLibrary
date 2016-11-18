function label_image = imsegment2_pdf(image, regionAhint, regionBhint, A_pdf, B_pdf)
  % segment a color or grayscale image into two regions by using GraphCut
  % given a prior probability density function.
  % The pdfs return for each pixel color a probability of this belonging to
  % region A or B respectively.
  %
  % This is similar in spirit (but not implementation I think) to
  % Mathematica's GrowCutComponents and some example data can be found there.
  %
  % Our implementation uses GraphCut from addpath('GCMex')
  % 
  % image n x m x c (c-many components accepted by)
  % regionAhint binary mask of the same size as the image
  % regionBhint binary mask of the same size as the image
  % 
  % The masks (hints) should cover (be 1 at) as many pixels as possible of regionA
  % or regionB which must be disjoint.
  % Returns the region assignments, that is, the segmentation,
  % i.e. for each pixel a number 0 (A) or 1 (B) depending on which region it was
  % estimated to belong to.
  
  assert(isreal(image));
  assert(isimage(image));
  assert(islogical(regionAhint));
  assert(islogical(regionBhint));
  assert_same_size12(image, regionAhint);
  assert_same_size12(image, regionBhint);
  
  N = imageArea(image);
  
  h = size(image,1); w = size(image,2); 
  hw = [h w];
  assert(N == h*w);
  
  Aindices = regionAhint(:); Aindices = find(Aindices);
  Bindices = regionBhint(:); Bindices = find(Bindices);
  assert(isempty(intersect(Aindices, Bindices)));
  assert(length(Aindices) + length(Bindices) <= N); % sanity
  
  % Prepare parameters for graph_minstcut
  % 2xN UNARY
  epsilon = 0.00001;
  UNARY = zeros(2, N);
  
  hwb = waitbar_start('constructing UNARY...');
  for y=1:h
      waitbar(y/h);
    for x=1:w
     
      p = [y x];
      pn = sub2ind(hw, p(1), p(2)); % flat index
      
      % special cases
      if regionAhint(y,x) 
        % For pixels belonging to the foreground mask, set the data term for the foreground
        % label to zero, and for the background label to ?log(epsilon).
        %
        % Note (see below): In row 1 is the weight of the connection to the
        % background label node. This will make it attractive to cut if it
        % is large (thus very negative after -log), assigning the pixel to
        % the foreground.
        %
        assert(~regionBhint(y,x));
        UNARY(1,pn) = 0; % don't cut this!
        UNARY(2,pn) = -log(epsilon); % cut this!
      elseif regionBhint(y,x) 
        assert(~regionAhint(y,x));
        UNARY(1,pn) = -log(epsilon); % cut this!
        UNARY(2,pn) =  0; % don't cut this!
      else
        % general case
        % The data term contains the negative logarithm of the pdf’s for
        % foreground and background at each pixel
        
        cp = image(p(1),p(2),:);
      
        UNARY(1,pn) = -log(epsilon + A_pdf(cp));
        UNARY(2,pn) = -log(epsilon + B_pdf(cp));
      end
    end
  end
  close(hwb);
  % NxN PAIRWISE
  % label-disagreement penalty (TODO how would we incorporate *agreement*
  % penalty? Zwicker said subtract it...)
  
  % prepare energy tuning parameters
  gamma = 15; % tuning parameter
  
  % -- magic from P7047, cp project 04 description
  colors = reshape(shiftdim(image,2), size(image,3), size(image,1)*size(image,2));
  
  avg = sum(colors,2)/size(colors,2);
  beta = sum(sum( (colors-repmat(avg,1,size(colors,2))).* ...
  (colors-repmat(avg,1,size(colors,2))) )) / size(colors,2);
  beta = 1/(2*beta);
  
  assert(beta > 0);
  assert(isreal(beta));
  % --
  
  % use 8 neighbors
  % nevermind vectorization or not writing to PAIRWISE directly -- now we do (optimization)
  

  hwb = waitbar_start('constructing PAIRWISE...');
  %PAIRWISE = sparse(N,N);
% [[ optimization
  maxEntries = 3 * N;
  PAIRWISEi = zeros(1,maxEntries);
  PAIRWISEj = zeros(1,maxEntries);
  PAIRWISEv = zeros(1,maxEntries);
  k = 1;
%]]

  for y=1:h
      waitbar(y/h);
    for x=1:w
     
      p = [y x];
      
      for qx=0:1 % -1:1 %0:1 %-1:1 % only consider forward connections (optimization!), such that we process them only once % NO it must be symmetric (could optimize to only compute once though)
        for qy=0:1 % -1:1
            
          q = [y + qy, x + qx];
          
          if ~in_rectangleQ(q, [1 1], [h w]) || all([qx,qy] == [0,0]) % i.e. p == q
            continue
          end
          
          assert(any(p ~= q));
          
          % 
          cp = image(p(1),p(2),:); cp = cp(:);
          cq = image(q(1),q(2),:); cq = cq(:);
         
          % magic formula
          penalty = gamma * exp(- beta * norm(cp - cq)^2);
          assert(penalty > 0);
          
          % enter this weight into PAIRWISE
          pn = sub2ind(hw, p(1), p(2));
          qn = sub2ind(hw, q(1), q(2));

          %PAIRWISE(pn, qn) = penalty;
        PAIRWISEi(k) = pn;
        PAIRWISEj(k) = qn;
        PAIRWISEv(k) = penalty;
k = k+1;

% reverse direction: symmetric
PAIRWISEi(k) = qn;
            PAIRWISEj(k) = pn;
            PAIRWISEv(k) = penalty;
k = k+1;

          %
          
        end
      end
    end
  end
  
  close(hwb);
  
  PAIRWISE = sparse(PAIRWISEi(1:k-1), PAIRWISEj(1:k-1), PAIRWISEv(1:k-1), N, N);
  %'PAIRWISE'
  %full(PAIRWISE)
  
  % visualize smoothness term
  total_interaction = full(sum(PAIRWISE));
  total_interaction = reshape(total_interaction, hw);
  imshow_in_figure(rescale01(total_interaction), 'Smoothness term');
  
  % revert UNARY
  % c.f. graph_minstcut: We gave the connections towards s/t in reverse
  % (row 1 contains the connection weights to node [1], not [0])
  % as is customary for applications.
  % graph_minstcut reverses them again, so we have to do it once too.
  UNARY = UNARY([2 1],:);  % this could of course be optimized away, but I think its an important detail.
 
  % --- magic ---
  LABELS = graph_minstcut(UNARY, PAIRWISE);
  % --- ---
  assert(length(LABELS) == N);
  assert(min(min(LABELS)) >= 0);
  assert(max(max(LABELS)) <= 1);
  
  label_image = reshape(LABELS, h, w);
  
  
  
  