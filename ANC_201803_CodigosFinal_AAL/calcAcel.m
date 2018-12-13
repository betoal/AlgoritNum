function acel = calcAcel(fzas,masas)
  acel = fzas ./[masas;masas;masas];
end