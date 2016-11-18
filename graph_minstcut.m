function [LABELS, ENERGYAFTER]  = graph_minstcut(UNARY, PAIRWISE)
    % Solves the Minimum-weight-s-t-cut problem.
    % The nodes s and t are assigned labels 0 and 1
    % which signifies which set of the partition they are assigned to.
    % The energy of a cut is defined as the sum of all weights of edges
    % crossing the cut (having endpoints in two different partitions).
    %
    % The graph is weighted and completely connected.
    % The weights of the edges from the 1:N internal nodes to
    % 0 and 1 are encoded in the 2xN matrix UNARY.
    % The pairwise weights of the internal nodes are encoded in the NxN
    % matrix PAIRWISE.
    %
    % PAIRWISE should be symmetric and have 0 on the diagonal (what does it
    % mean otherwise?)
    %
    % WARNING GCmex crashes when not at least entry per row of PAIRWISE is
    % nonzero.
    %
    % uses GCmex
    
    assert(size(UNARY,1) == 2);
    N = size(UNARY,2);
    assert(N > 0); % should be nontrivial
    assert(size(PAIRWISE,1) == N);
    assert(size(PAIRWISE,2) == N);
  
    UNARY = UNARY([2 1],:); % GCmex understands the unary weights the other way around, because this is customary in applications
    % We want to prefer *keeping* the connections which have a higher
    % probability. But applying -log(x) will make it desirable to cut
    % across these. Therefore, we connect with the given weight to the
    % other node.
    
    
    
  % CxC LABELCOST
  LABELCOST = [0 1;1 0];
 
  % --- magic ---
  disp(['GCMex ' num2str(N)]);
  [LABELS, ENERGY, ENERGYAFTER] = GCMex(zeros(N,1), single(UNARY), sparse(PAIRWISE), single(LABELCOST), 0);
  ENERGY
  ENERGYAFTER
  % --- ---
  
  % result sanity checks
  assert(ENERGYAFTER <= ENERGY);
  assert(length(LABELS) == N);
  assert(min(min(LABELS)) >= 0);
  assert(max(max(LABELS)) <= 1);
  