function points = getpts2(fig)
  % lets the user place points on the given figure.
  % the coordinates of the points will be returned
  %
  % points is nx2
  %
  % Similar to getpts, but displays a message box that expalins the
  % user-interface.
  
  uiwait_msgbox('getpts2: Use normal button clicks to add points.\nA shift-, right-, or double-click adds a final point and ends the selection.\nPressing Return or Enter ends the selection without adding a final point.\nPressing Backspace or Delete removes the previously selected point.\n');
  [x, y] = getpts(fig); % maybe use ginput?
  
  points(:,1) = x;
  points(:,2) = y;