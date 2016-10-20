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

  my_load = mds[whoami]["load"]
  his_load = mds[whoami+1]["load"]
  if whoami == 0 and my_load > 0.01 and his_load < 0.01 then
    -- get it offf!!! proxy mode can't handle load on the proxy
    BAL_LOG(0, "when: GO! I am MDS"..whoami)
    return true
  end
  BAL_LOG(0, "when: NOPE! I am MDS"..whoami.."his_load="..his_load)
  return false
end

-- Shed half your load to your neighbor
-- neighbor=whoami+2 because Lua tables are indexed starting at 1
function where()
  targets = {}
  for i=1, #mds+1 do
    targets[i] = 0
  end

  slaves = #mds
  total = mds[whoami]["load"]
  BAL_LOG(0, "where: send total/slaves="..total/slaves.." total="..total.." slaves="..slaves)

  for i=2, #mds+1 do
    BAL_LOG(0, "MDS"..(i-1).." gets load="..total/slaves)
    targets[i] = total/slaves
  end
  BAL_LOG(0, "MDS"..(#mds+1).." gets the rest total="..total)
  targets[#mds+1] = total

  for i=1, #mds+1 do
    BAL_LOG(0, "targets["..i.."]="..targets[i])
  end
  return targets
end

sendto = 0
mds_load()
if when() then
  return where()
end

targets = {}
for i=1, #mds+1 do
  targets[i] = 0
end
return targets
