newbieFunction={}





local startTask=function(typo,taskId,taskstate,trigerType)
if trigerType==nil then trigerType=0 end
typo=newbieConfig.getTaskNewBieType(taskstate)

local cfg=newbieModel.getLookupConfig(typo,taskId*100+taskstate*10+trigerType)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{taskId,taskstate,trigerType})
newbieControl.log('newbie_开始任务指引，停止ai,任务id：'..taskId..',任务状态：'..taskstate)
return true
end
return false
end


local startLevel=function(typo,level)
local cfg=newbieModel.getLookupConfig(typo,level)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{level})
newbieControl.log('newbie_开始等级指引，等级.'..level)
return true
end
return false
end


local startVipLevel=function(typo,vipLevel)
local cfg=newbieModel.getLookupConfig(typo,vipLevel)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{vipLevel})
newbieControl.log('newbie_开始VIP等级指引，vip等级.'..vipLevel)
return true
end
return false
end


local startActiveSystem=function(typo,sysId)
local cfg=newbieModel.getLookupConfig(typo,sysId)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{sysId})
newbieControl.log('newbie_开始系统开启指引，系统id.'..sysId)

return true
end
return false
end


local startItem=function(typo,itemid)

local cfg=newbieModel.getLookupConfig(typo,itemid)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{itemid})
newbieControl.log('newbie_开始道具指引，道具id：'..itemid)

return true
end
return false
end


local startSuoyaotaBalance=function(typo,layer)
local cfg=newbieModel.getLookupConfig(typo,layer)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{layer})
newbieControl.log('newbie_触发锁妖塔指引，层：'..layer)
return true
end
return false
end


local startScene=function(typo,sceneid)
local cfg=newbieModel.getLookupConfig(typo,sceneid)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{sceneid})
newbieControl.log('newbie_开始进入场景指引，场景id.'..sceneid)

return true
end
return false
end


local startzxlfinish=function(typo,bookid,idx)
idx=idx or 0
local id=bookid*10000+idx
local cfg=newbieModel.getLookupConfig(typo,id)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{bookid,idx})
return true
end
return false
end

local startOpenWindow=function(typo,name,num1)
if not newbieModel.hasOpenWindowCfg(name)then return false end
local num=num1 or(newbieModel.getOpenWindowNum(name)+1)
newbieModel.setOpenWindowNum(name,num)
local id=FMT.fmt('{0}_NUM_{1}',name,num)
local cfg=newbieModel.getLookupConfig(typo,id)
local funcCfgs=((cfg or{}).openWindow or{})[3]
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{name})
newbieControl.log(FMT.fmt('newbie_开始进入窗口指引，窗口.{0} 打开次数：{1}',name,num))
return true
end
return false
end

local startLuaFun=function(typo,funcType,isRepeat)
local cfg=newbieModel.getLookupConfig(typo,funcType)
if newbieControl.checkLuaCondition(funcType)and
newbieControl.tryStart(cfg,isRepeat)then
newbieControl.clearCache(typo,{funcType,isRepeat})
newbieControl.log(FMT.fmt('newbie_开始lua指引'))

return true
end
return false
end

local startWorldBlock=function(typo,world,block)
local key=FMT.fmt("{0}_{1}",world,block)
local cfg=newbieModel.getLookupConfig(typo,key)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{world,block})
newbieControl.log(FMT.fmt('newbie_区块解锁 ',world,block))
return true
end
return false
end

local startWorldExperience=function(typo,experience)
local cfg=newbieModel.getLookupConfig(typo,experience)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{experience})
newbieControl.log(FMT.fmt('newbie_历练开始触发：',experience))
return true
end
return false
end

local endWorldExperience=function(typo,experience)
local cfg=newbieModel.getLookupConfig(typo,experience)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{experience})
newbieControl.log(FMT.fmt('newbie_历练结束触发：',experience))
return true
end
return false
end

local startMysteryEvent=function(typo,groupId,optionId)
local key
if optionId~=nil then
key=FMT.fmt("{0}_{1}",groupId,optionId)
local config=newbieModel.getLookupConfig(typo,key)
if not config then
key=FMT.fmt("{0}_{1}",groupId,-1)
end
else
key=FMT.fmt("{0}_{1}",groupId,-1)
end
local cfg=newbieModel.getLookupConfig(typo,key)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{groupId,optionId})
newbieControl.log('newbie_奇遇触发 ',groupId,optionId)
return true
end
return false
end

local startStoryTree=function(typo,treeId,flag)
flag=flag or 2
local key=FMT.fmt("{0}_{1}",treeId,flag)
local cfg=newbieModel.getLookupConfig(typo,key)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{treeId,flag})
newbieControl.log('newbie_剧情树触发 ',treeId,flag)
return true
end
return false
end


local startNextNewbie=function(typo,nextid)
local cfg=newbieModel.getLookupConfig(typo,nextid)
if newbieControl.tryStart(cfg)then
newbieControl.clearCache(typo,{nextid})
return true
end
return false
end

local _newbieFunc=
{
[NEW_BIE_CND_TYPE.eAcceptTask]=function(...)
return startTask(...)
end,
[NEW_BIE_CND_TYPE.eDoTask]=function(...)
return startTask(...)
end,
[NEW_BIE_CND_TYPE.eFinshTask]=function(...)
return startTask(...)
end,
[NEW_BIE_CND_TYPE.eNotAcceptTask]=function(...)
return startTask(...)
end,
[NEW_BIE_CND_TYPE.eLevel]=function(...)
return startLevel(...)
end,
[NEW_BIE_CND_TYPE.eVip]=function(...)
return startVipLevel(...)
end,
[NEW_BIE_CND_TYPE.eActiveSystem]=function(...)
return startActiveSystem(...)
end,
[NEW_BIE_CND_TYPE.eItem]=function(...)
return startItem(...)
end,
[NEW_BIE_CND_TYPE.eEnterScene]=function(...)
return startScene(...)
end,
[NEW_BIE_CND_TYPE.eLuaFun]=function(...)
return startLuaFun(...)
end,
[NEW_BIE_CND_TYPE.eSuoyaotaBalance]=function(...)
return startSuoyaotaBalance(...)
end,
[NEW_BIE_CND_TYPE.eOpenWindow]=function(...)
return startOpenWindow(...)
end,
[NEW_BIE_CND_TYPE.eWorldBlock]=function(...)
return startWorldBlock(...)
end,
[NEW_BIE_CND_TYPE.eStartExperience]=function(...)
return startWorldExperience(...)
end,
[NEW_BIE_CND_TYPE.eMysteryEvent]=function(...)
return startMysteryEvent(...)
end,



[NEW_BIE_CND_TYPE.eEndExperience]=function(...)
return endWorldExperience(...)
end,
[NEW_BIE_CND_TYPE.eStoryTree]=function(...)
return startStoryTree(...)
end,
[NEW_BIE_CND_TYPE.eZheXianLing]=function(...)
return startzxlfinish(...)
end,
[NEW_BIE_CND_TYPE.eNextNewbie]=function(...)
return startNextNewbie(...)
end,
}



function newbieControl.startNewbie(typo,...)
if not newbieControl.checkStart(typo,...)then return false end
local func=_newbieFunc[typo]
if func then
return func(typo,...)
end
return false
end
