













jiuChongTianJieSubSys_tianmolaixi=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie})

jiuChongTianJieSubSys_tianmolaixi.progressType=eJiuChongTianJieSysType.eNumber

jiuChongTianJieSubSys_tianmolaixi.showProgessNum=0



function jiuChongTianJieSubSys_tianmolaixi:checkFinish()
local stageCfg=cfg_tianmojiestageconfig()
local cur=tianMoJieModel:getScore()
local max=stageCfg[#stageCfg].score
return cur>=max
end

function jiuChongTianJieSubSys_tianmolaixi:getProgress()
local stageCfg=cfg_tianmojiestageconfig()
local cur=tianMoJieModel:getScore()
local max=stageCfg[#stageCfg].score
local value=Mathf.Clamp(math.floor(cur/max*100),0,100)
return value,100
end

function jiuChongTianJieSubSys_tianmolaixi:getReddot(isEnter)
local txzId=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"passport")
local txzGuid=UITYTongXingZhengModel:findGuidByTXZId(txzId)
local reddot=UITYTongXingZhengController:checkReddot(txzGuid)
if reddot then
return true
end

if not isEnter then
local activitys=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"activity")
if activitys then
for index,actId in ipairs(activitys)do
local actInfo=activitiesModel:getActInfo(actId)
if actInfo and actInfo.enterguid and actInfo:getRoddot()then
return true
end
end
end
end

local cfgs=cfg_tianmojiestageconfig()
local score=tianMoJieModel:getScore()
local flag=tianMoJieModel:getFlag()
for i,v in ipairs(cfgs)do
local enough=score>=v.score
local getted=flag>=i
if enough and not getted then
return true
end
end
return false
end

function jiuChongTianJieSubSys_tianmolaixi:jump()
UIFullTianMoJieControl:showMainWinByCloud()
end

function jiuChongTianJieSubSys_tianmolaixi:checkReward()
local cfgs=cfg_tianmojiestageconfig()
local score=tianMoJieModel:getScore()
local flag=tianMoJieModel:getFlag()
local max=#cfgs
local cfg=cfgs[max]
local enough=score>=cfg.score
local getted=flag>=max
if not enough or not getted then
return true
end

local txzId=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"passport")
local txzGuid=UITYTongXingZhengModel:findGuidByTXZId(txzId)
local isReciveFull=UITYTongXingZhengModel:isReceiveFull(txzGuid,txzId)
return not isReciveFull
end