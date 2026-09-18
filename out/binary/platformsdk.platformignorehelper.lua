platformIgnoreHelper={}

function platformIgnoreHelper.getCfg(name)
return cfgHelper.get2(cfg_platformignoreconfig_get,1,name)
end

function platformIgnoreHelper.isIgnore(name,id)
local gameid=channelHelper.getGameId()
local sid=playerModel:getActorServerID()
local cfg=platformIgnoreHelper.getCfg(name)
local ret=false
if cfg then
local channelCfg=cfg[gameid]or cfg[-1]or{}
local ignoreCfg=channelCfg[sid]or channelCfg[-1]or{}
for i,v in ipairs(ignoreCfg)do
if v==-1 or id and v==id then
ret=true
break
end
end
end
if ret then
if id then
loggerUtil.log('{0}已屏蔽id:{1}',name,id)
else
loggerUtil.log('{0}已全部屏蔽',name)
end
end
return ret
end

function platformIgnoreHelper.isIgnoreWenJuan(id)
return platformIgnoreHelper.isIgnore('wenjuan',id)
end

function platformIgnoreHelper.isIgnorePushGift(id)
return platformIgnoreHelper.isIgnore('pushgift',id)
end

