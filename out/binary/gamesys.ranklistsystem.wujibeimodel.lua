






local _MODULENAME="wuJiBeiModel"




def_table(_MODULENAME)
wuJiBeiModel.name=_MODULENAME


wuJiBeiModel.actor={}
wuJiBeiModel.award={}

local conditionValueStr={
[1]=function(value)
return FMT.fmt("{0}期",UIDiscipleModel:getJJFloorNameEx(value))

end,
[2]=function(value)
return UIDiscipleModel.getLTNameCommon(value,4)
end,
[3]=function(value)
return mathHelper.formatNumber4(value)
end
}

local conditionCheckFunc={
[eWuJiBeiConditionType.eJingJie]=function(commonId,value)

return UIDiscipleModel:getDiscipleJJLevel(commonId)>=value
end,
[eWuJiBeiConditionType.eLianTi]=function(commonId,value)
return UIDiscipleModel:getDiscipleLTLevel(commonId)>=value
end,
[eWuJiBeiConditionType.eGuBao]=function(commonId,value)
local attrLookup=gubaoModel:getAllAttrLookup(false)
return(cfgHelper.getFight(attrLookup)*5)>=value
end,
[eWuJiBeiConditionType.eShiLianTa]=function(commonId,value)
return shiLianTaModel:getClearLayer()>=value
end,
}

local _getCheckTopTarget={
[eWuJiBeiConditionType.eJingJie]=function()
local disciples=UIDiscipleModel:getSortList(nil,function(a,b)
return a.jingjielv>b.jingjielv
end)
if#disciples>0 then
return disciples[1].discipleguid
end
end,
[eWuJiBeiConditionType.eLianTi]=function()
local disciples=UIDiscipleModel:getSortList(nil,function(a,b)
return a.liantilv>b.liantilv
end)
if#disciples>0 then
return disciples[1].discipleguid
end
end,
[eWuJiBeiConditionType.eGuBao]=function()
return int64.zero
end,
[eWuJiBeiConditionType.eShiLianTa]=function()
return int64.zero
end,
}


function wuJiBeiModel:onAppStart()
self.conditionLookUp={}
for i,v in pairs(eWuJiBeiConditionType)do
self.conditionLookUp[v]={}
end
local commonCfg=cfg_wujibeiconfig()
for i,v in pairs(commonCfg)do
local cType=v.conditions[1]
table.insert(self.conditionLookUp[cType],i)
end

local temp1={}
local lookupCfg=cfg_lookupwujibeiconfig()
for i,v in pairs(lookupCfg)do
table.insert(temp1,i)
end
table.sort(temp1)
self.mainShowList=temp1

self.subShowList={}
for i,v in ipairs(temp1)do
local temp2={}
for j,w in pairs(lookupCfg[v])do
table.insert(temp2,j)
end
table.sort(temp2)
self.subShowList[v]=temp2
end
end


function wuJiBeiModel:onEnterState()

end


function wuJiBeiModel:onLeaveState()

self.actor={}
self.award={}
end


function wuJiBeiModel:onServerDataInitFinish()

end



function wuJiBeiModel:setActorDatas(list)
self.actor={}
for i,v in ipairs(list)do
local actorId=v.actor_id
local iconInfo=v.iconInfo
local achievementId=v.achieve_id
local zmLevel=v.zmLevel
local playerName=v.playerName
self.actor[achievementId]={
actorId=actorId,
zmLevel=zmLevel,
head=iconInfo,
playerName=playerName,
}
end
end

function wuJiBeiModel:setActor(actorData)
self.actor[actorData.achieve_id]={
actorId=actorData.actor_id,
zmLevel=actorData.zmLevel,
head=actorData.iconInfo,
playerName=actorData.playerName,
}
end

function wuJiBeiModel:getActor(achievementId)
return self.actor[achievementId]
end

function wuJiBeiModel:setAwardDatas(list)
self.award={}
for i,v in ipairs(list)do
local achievementId=v.param_1
local status=v.param_2
self.award[achievementId]=status
end
end

function wuJiBeiModel:setAward(achievementId,status)
self.award[achievementId]=status
end

function wuJiBeiModel:getAward(achievementId)
return self.award[achievementId]
end

function wuJiBeiModel:getReddot(achievementId)
local actor=self:getActor(achievementId)
if actor then
local award=self:getAward(achievementId)or 0
return award<=0
end
return false
end

function wuJiBeiModel:getTypeReddot(type)
local cfg=cfgHelper.get1(cfg_lookupwujibeiconfig_get,type)
for i,v in pairs(cfg)do
if self:getChildTypeReddot(type,i)then
return true
end
end
return false
end

function wuJiBeiModel:getChildTypeReddot(type,childType)
local cfg=cfgHelper.get2(cfg_lookupwujibeiconfig_get,type,childType)
for i,v in pairs(cfg)do
if self:getReddot(v)then
return true
end
end
return false
end

function wuJiBeiModel:getAllReddot()
local cfg=cfg_lookupwujibeiconfig()
for i,v in pairs(cfg)do
if self:getTypeReddot(i)then
return true
end
end






return false
end

function wuJiBeiModel:getConditionStr(cType,cValue)
local conditionCfg=cfgHelper.get1(cfg_wujibeiconditionconfig_get,cType)
local conditionStr=conditionValueStr[cType]and conditionValueStr[cType](cValue)or cValue
conditionStr=FMT.fmt(conditionCfg.desc,conditionStr)
return conditionStr
end

function wuJiBeiModel:checkTriggerCondition(cId,commonId)
local list=self.conditionLookUp[cId]
local temp={}
for i,v in ipairs(list)do
if not self:getActor(v)and self:checkCondition(v,commonId)then
table.insert(temp,v)
end
end
return temp
end

function wuJiBeiModel:checkCondition(achievementId,commonId)
local conditions=cfgHelper.get2(cfg_wujibeiconfig_get,achievementId,"conditions")
local cType=conditions[1]
local cValue=conditions[2]
local cFunc=conditionCheckFunc[cType]
if cFunc then
return cFunc(commonId,cValue)
else
loggerUtil.logErrFMT("缺少无极碑条件检查：{0}",cType)
return false
end
end

function wuJiBeiModel:getCheckTopTarget(cId)
return _getCheckTopTarget[cId]()
end


