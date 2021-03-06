/* Definisi Fakta */
  /* Nama Tokemon */
  tokemon(alphamon).
  tokemon(betamon).
  tokemon(cupmon).
  tokemon(donutmon).
  tokemon(eclairmon).
  tokemon(froyomon).
  tokemon(gingermon).
  tokemon(honeymon).
  tokemon(icemon).
  tokemon(jellymon).
  tokemon(kitmon).
  tokemon(lollimon).
  tokemon(marshmon).
  tokemon(nougatmon).
  tokemon(oreomon).
  tokemon(piemon).

  /* Jenis Tokemon */
  % normal(alphamon).
  % normal(cupmon).
  % normal(donutmon).
  % normal(eclairmon).
  % normal(froyomon).
  % normal(gingermon).
  % normal(honeymon).
  % normal(jellymon).
  % normal(kitmon).
  % normal(lollimon).
  % normal(marshmon).
  % normal(nougatmon).
  % normal(piemon).
  legend(betamon).
  legend(icemon).
  legend(oreomon).

  /* Health Tokemon */
  health(alphamon,50).
  health(betamon,350).
  health(cupmon,20).
  health(donutmon,60).
  health(eclairmon,30).
  health(froyomon,75).
  health(gingermon,40).
  health(honeymon,25).
  health(icemon,420).
  health(jellymon,10).
  health(kitmon,100).
  health(lollimon,95).
  health(marshmon,45).
  health(nougatmon,110).
  health(oreomon,1000).
  health(piemon,90).

  /* Tipe Tokemon */
  tipe(alphamon,water).
  tipe(betamon,leaves).
  tipe(cupmon,water).
  tipe(donutmon,lightning).
  tipe(eclairmon,fire).
  tipe(froyomon,leaves).
  tipe(gingermon,water).
  tipe(honeymon,lightning).
  tipe(icemon,fire).
  tipe(jellymon,leaves).
  tipe(kitmon,water).
  tipe(lollimon,lightning).
  tipe(marshmon,water).
  tipe(nougatmon,leaves).
  tipe(oreomon,fire).
  tipe(piemon,lightning).

  /* Normal Attack Tokemon */
  damage(alphamon,10).
  damage(betamon,40).
  damage(cupmon,2).
  damage(donutmon,10).
  damage(eclairmon,4).
  damage(froyomon,15).
  damage(gingermon,12).
  damage(honeymon,6).
  damage(icemon,60).
  damage(jellymon,10).
  damage(kitmon,12).
  damage(lollimon,10).
  damage(marshmon,25).
  damage(nougatmon,6).
  damage(oreomon,100).
  damage(piemon,8).

  /* Special Attack Tokemon */
  specialmove(alphamon,overheat,80).
  specialmove(betamon,worldtree,40).
  specialmove(cupmon,waterfall,30).
  specialmove(donutmon,stungun,25).
  specialmove(eclairmon,fireball,30).
  specialmove(froyomon,leafblade,50).
  specialmove(gingermon,holywater,24).
  specialmove(honeymon,electron,14).
  specialmove(icemon,supernova,60).
  specialmove(jellymon,megadrain,30).
  specialmove(kitmon,hydropump,50).
  specialmove(lollimon,lightningarrow,20).
  specialmove(marshmon,waterlaser,35).
  specialmove(nougatmon,spikewall,15).
  specialmove(oreomon,cataclysm,100).
  specialmove(piemon,thunderstorm,20).
