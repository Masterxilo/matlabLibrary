function [vocabulary, sifts] = CV03_dataAintNobody_builtVocabulary()
  % returns the same format as CV03_buildVocabulary
  % as if called on the aint nobody frames with 1500 vocabulary size.
  sifts = CV03_dataAintNobody_sifts();
  vocabulary = CV03_dataAintNobody_vocabulary();