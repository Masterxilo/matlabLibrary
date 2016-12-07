function [Lt_min,theta_min] = nonlinearSimplex(p, L, iterations, visualize)
% (Locally) Minimizes the loss function L of p arguments using the non-linear simplex
% algorithm.
%
% for Probabilistic Algorithms class
%
% p dimension of search space, must be at least 2 (3 points=>min, max, 2max different).
% L function to evaluate, must take a row vector of dimension (size) p
% evals number of iterations

    assert(p > 0);
    if nargin < 4
        visualize = false;
    end
    if visualize && p ~= 2
        error('can only visualize 2d')
    end
    
    % test function, L(0)
    assert(isscalar(L(repmat(0,1,p))));
    
    % Initialization, points theta
    theta = rand(p+1,p);
    
    alpha = 1;
    beta = 0.5;
    gamma = 2;
    delta = 0.5;
    
    % Loop
    % Step 5 stop if stopping criterion met
    while iterations > 0
        iterations = iterations-1;
        % Evaluate function at all points, find min and max values and
        % indices
        Ltheta = arrayfun_vec(L,theta);
        
        % visualize step
        if visualize
            %scatter(theta(:,1),theta(:,2))
            %hold on
            xs = -1:0.05:1;
            ys = xs;
            res = length(xs);
            zs = zeros(res);
            for i=1:res
                for j=1:res
                    zs(i,j) = L( [ xs(i) ys(j) ] );
                end
            end
            figure(1)
            contourf(zs,30)
            figure(2)
            scatter(theta(:,1),theta(:,2))
            axis([-1 1 -1 1])
            disp('any key to continue')
            pause
            % how to show these in the same plot?
        end
        
        [Lt_min, i_min, Lt_2max, i_2max, Lt_max, i_max] = min2maxmax(Ltheta);

        assert(Lt_min == L(theta(i_min,:)));
        assert(Lt_max == L(theta(i_max,:)));
        assert(Lt_2max == L(theta(i_2max,:)));
        
        assert(Lt_min <= Lt_2max);
        assert(Lt_2max <= Lt_max);
        
        theta_min = theta(i_min,:);
        theta_2max = theta(i_2max,:);
        theta_max = theta(i_max,:);
        
        % Reflection
        % Centroid is mean of all theta except theta_max == theta(i_max,:)
        theta_cent = cent(theta([(1:i_max-1) (i_max+1:end)],:));
       
        theta_refl = (1+alpha)*theta_cent - alpha*theta_max; % = theta_cent + a* (theta_cent - theta_max)
        Lt_refl = L(theta_refl);
        
        % Accept reflection?
        if Lt_min <= Lt_refl && Lt_refl <= Lt_2max % note: using <= in the rare case that all values are equal
            %'Accept reflection'
            theta(i_max,:) = theta_refl;
            continue;
        end
        
        % Expansion? (if refl is really good, maybe we can get even better)
        if Lt_refl < Lt_min
            %'Expansion'
            theta_exp = gamma*theta_refl + (1-gamma)*theta_cent;
            % Check expansion
            if L(theta_exp) < Lt_refl
                theta(i_max,:) = theta_exp;
            else
                theta(i_max,:) = theta_refl;
            end
            continue;
        end
        
        % Contraction (at this point, Lt_refl > Lt_2max) 
        % And we will either do a contraction or a shrink move
        % Outside contraction, in-line: max - cent - *cont - refl
        
        if Lt_refl < Lt_max
            %'Outside contraction'
            outside_contraction = 1;
            theta_cont = beta*theta_refl + (1-beta)*theta_cent;
        %end
        % Inside contraction, in-line: max - *cont - cent - refl
        %if Lt_max <= Lt_refl
        else
            assert(Lt_max <= Lt_refl);
            %'Inside contraction'
            outside_contraction = 0;
            theta_cont = beta*theta_max + (1-beta)*theta_cent;
        end
        Lt_cont = L(theta_cont);
        
        % Check contraction
        if outside_contraction
            % pick better of cont or refl
            if Lt_cont < Lt_refl
                theta(i_max,:) = theta_cont;
            else 
                theta(i_max,:) = theta_refl;
            end
            continue;
        elseif Lt_cont < Lt_max % if inside contraction, use cont only when improving
            theta(i_max,:) = theta_cont;
            continue;
        end
        
        % Shrink (none of our suggestions, refl, exp, cont, give any
        % improvement)
        assert(Lt_cont >= Lt_max);
        %'Shrink'
        for i=1:(size(theta,1))
            % retain theta_min
            if i == i_min
                continue;
            end
            theta(i,:) = delta*theta(i,:) + (1-delta)*theta_min;
        end
    end
end
% centroid of given points
% n x p matrix, where n is the number of points
function c = cent(points)
    c = mean(points);
end

function [t_min, i_min, t_2max, i_2max, t_max, i_max]  = min2maxmax(theta)
    [t_min, i_min] = min(theta);
    [t_max, i_max] = max(theta);
    theta(i_max) = t_min; % set to min to find second max:
    [t_2max, i_2max] = max(theta);
end

% out = [
% ...;
% f(points(i,:));
% ...];
function out=arrayfun_vec(f, points)
    [m,evals] = size(points);
    out = [];
    for i=1:m
        out = [out;f(points(i,:))];
    end
end