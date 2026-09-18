







gubaoCollectType={
eNum=1,
eLianHua=2,
eStar=3,
}

local checkProgressFunc={

[gubaoCollectType.eNum]=function(maxpoint)
local cur=gubaoModel:getCollectPoint()
return cur>=maxpoint,cur,maxpoint
end,

[gubaoCollectType.eLianHua]=function(maxpoint)
local cur=gubaoModel:getCollectLianHua()
return cur>=maxpoint,cur,maxpoint
end,

[gubaoCollectType.eStar]=function(maxpoint)
local cur=gubaoModel:getCollectStar()
return cur>=maxpoint,cur,maxpoint
end
}

function gubaoModel:rec_reward(collectType,childID)
local list=gubaoModel:getRewardList()
local d=list[collectType].list or{}
local key=math.ceil(childID/32)
local idx=childID%32
if idx==0 then idx=32 end
local dd=d[key]or 0
dd=mathHelper.setbit(dd,idx-1)
d[key]=dd
list[collectType].list=d
end

function gubaoModel:checkRewarFinish(collectType,childID)
local list=gubaoModel:getRewardList()
local d=list[collectType].list or{}
local key=math.ceil(childID/32)
local idx=childID%32
if idx==0 then idx=32 end
local dd=d[key]or 0
return mathHelper.getBitValue(dd,idx-1)
end

function gubaoModel:getCollectPoint()










return gubaoModel:getAllCollectPoint()
end

function gubaoModel:getCollectLianHua()








return gubaoModel:getAllCollectLhLv()
end

function gubaoModel:getCollectStar()








return gubaoModel:getAllCollectStar()
end

function gubaoModel:checkAllCollectReddot()
for k,v in pairs(gubaoCollectType)do
if gubaoModel:checkCollectReddot(v)then
return true
end
end
return false
end

function gubaoModel:checkCollectReddot(collectType)
local collectCfg=cfgHelper.get1(cfg_gubaoaimrewardconfig_get,collectType)
local getter=gubaoModel:getCollectChildGetter(collectCfg)
local list=getter()
for i,v in pairsBySortKey(list)do
if gubaoModel:checkCollectChildReddotEx(collectType,v.id,v.point)then
return true
end
end
return false
end

function gubaoModel:checkCollectChildReddot(collectType,childID)
local flag,cur,max=gubaoModel:getCollectProgress(collectType,childID)
if flag then
if not gubaoModel:checkRewarFinish(collectType,childID)then
return true
end
end
return false
end

function gubaoModel:checkCollectChildReddotEx(collectType,childID,maxpoint)
local flag,cur,max=gubaoModel:getCollectProgressEx(collectType,maxpoint)
if flag then
if not gubaoModel:checkRewarFinish(collectType,childID)then
return true
end
end
return false
end

function gubaoModel:getCollectChildState(collectType,childID,maxpoint)
local flag,cur,max=gubaoModel:getCollectProgressEx(collectType,maxpoint)
if flag then

if gubaoModel:checkRewarFinish(collectType,childID)then

return 1
else

return 3
end
else

return 2
end
end

function gubaoModel:getCollectProgress(collectType,childID)
local childCfg=gubaoModel:getCollectChildCfg(collectType,childID)
return gubaoModel:getCollectProgressEx(collectType,childCfg.point)
end

function gubaoModel:getCollectProgressEx(collectType,maxpoint)
return checkProgressFunc[collectType](maxpoint)
end

function gubaoModel:getCollectChildCfg(collectType,childID)
local collectCfg=cfgHelper.get1(cfg_gubaoaimrewardconfig_get,collectType)
return gubaoModel:getCollectChildCfgEx(collectCfg,childID)
end

function gubaoModel:getCollectChildGetter(collectCfg)
local name=collectCfg.configname
return cfgHelper.getCofingFunction(name)
end

function gubaoModel:getCollectChildGetter2(collectCfg)
local name=collectCfg.configname
return cfgHelper.getCofingGetFunction(name)
end

function gubaoModel:getCollectChildCfgEx(collectCfg,childID)
local getter=gubaoModel:getCollectChildGetter2(collectCfg)
return cfgHelper.get1(getter,childID)
end