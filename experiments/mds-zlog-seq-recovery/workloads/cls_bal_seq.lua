-- Sequencer Balancer
-- Motivation: 
-- Description: the same as directory splitting

-- Load is the metadata load on all your subtrees
function MDS_LOAD(ctx)
  i = ctx["i"]
  return ctx["MDSs"][i]["all"]
end

-- Shed load when you have load and your neighbor doesn't
function WHEN(ctx)
  MDSs = ctx["MDSs"]
  whoami = ctx["whoami"]
  return MDSs[whoami]["load"] > 0.01 and MDSs[whoami+1]["load"] < 0.01
end

-- Shed half your load to your neighbor
function WHERE(ctx)
  MDSs = ctx["MDSs"]
  whoami = ctx["whoami"]
  ctx["targets"][whoami+1] = MDSs[whoami]["load"]/2
end

balclass.register(rebalance)
