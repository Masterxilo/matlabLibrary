L = [
    0.5109    0.2547   -0.0383   -0.0708   -0.3006   -0.1010    0.2774    0.1184    0.2313    0.0918    0.1407   -0.1321
   -0.4592   -0.1259   -0.1699   -0.4280   -0.4989   -0.5678   -0.4182   -0.4243   -0.3220   -0.3360   -0.0360   -0.3531
   -0.7267   -0.9588   -0.9847   -0.9010   -0.8129   -0.8170   -0.8649   -0.8978   -0.9181   -0.9374   -0.9894   -0.9262];
 

close all

CV01_ShowLightDirections(L); % just for fun

[mask, colorImages, normals, albedo, colorAlbedo, depth] = CV01_runOnDataset(L, 'ps.owl');