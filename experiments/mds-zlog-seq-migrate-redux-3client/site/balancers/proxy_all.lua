metrics = {"auth.meta_load", "all.meta_load", "req_rate", "queue_len", "cpu_load_avg", "cpu_load_inst", "programmable"}

-- Metric for balancing is the workload; also dumps metrics
function mds_load()
  m = "METRICS: < "
  for i=1, #metrics do
    m = m..metrics[i].." "
  end
  BAL_LOG(0, m..">")
  for i=0, #mds do
    s = "MDS"..i..": < "
    for j=1, #metrics do
      s = s..mds[i][metrics[j]].." "
    end
    mds[i]["load"] = mds[i]["all.meta_load"]
    BAL_LOG(0, s.."> load="..mds[i]["load"])
  end
end

-- Shed load when you have load and your neighbor doesn't
function when()
  if whoami + 1 > #mds then
    return false
  end

  if whoami == 0 then
    -- get it offf!!! proxy mode can't handle load on the proxy
    return true
  end

  my_load = mds[whoami]["load"]
  his_load = mds[whoami+1]["load"]
  if my_load > 0.01 and his_load < 0.01 and mds[whoami+1]["programmable"] < 10 then
    BAL_LOG(0, "when: migrating! my_load="..my_load.." hisload="..his_load)
    return true
  end
  BAL_LOG(0, "when: not migrating! my_load="..my_load.." hisload="..his_load)
  return false
end

-- Shed half your load to your neighbor
-- neighbor=whoami+2 because Lua tables are indexed starting at 1
function where()
  targets = {}
  for i=1, #mds+1 do
    targets[i] = 0
  end

  targets[whoami+2] = mds[whoami]["load"]
  return targets
end

mds_load()
if when() then
  return where()
end

targets = {}
for i=1, #mds+1 do
  targets[i] = 0
end
return targets
