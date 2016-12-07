function vl_setup2()
  %  same as vl_setup if that one has not yet been called
  if exist('vl_sift')==0
    vl_setup()
  end