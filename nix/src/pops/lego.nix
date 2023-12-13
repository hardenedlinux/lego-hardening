{
  omnibus,
  projectDir,
  inputs,
}:
omnibus.pops.load {
  src = projectDir + /units/lego;
  inputs = {};
}
