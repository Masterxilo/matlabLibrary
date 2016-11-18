function h = waitbar_start(title)
  % wrapper for waitbar that also disp the string in the commandline
  % call waitbar(%) to update this, finally close(h).
  disp(title);
  h = waitbar(0, title);