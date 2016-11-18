function rot180(A)
  % equivalent to fliplrud and rot90 applied twice
  B = rot90(rot90(A))