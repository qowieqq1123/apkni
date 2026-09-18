def_class('fightNewMonAction',fightBaseAction)

function fightNewMonAction:__init()
self.typo=fightActionType.NEW_MON
end

function fightNewMonAction:getTypo()
return self.typo
end


function fightNewMonAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.rawData=_rawData[3]
self.newMonType=_rawData[4]
self.actionObjs={}
self.delayTime=0
end

function fightNewMonAction:fetchData(curIndex,parentRawData)
self.uaRawDatas={}

local monIdx
for i=curIndex,#parentRawData do
local actionData=parentRawData[i]
if type(actionData)=="table"then
local typo=actionData[fightCommonTag.typo]
if typo==self.typo then
if monIdx and i~=monIdx+1 then
break
end
self.uaRawDatas[#self.uaRawDatas+1]=actionData
monIdx=i
end
end
end











for i,v in ipairs(self.uaRawDatas)do
local actionData=v
local typo=actionData[fightCommonTag.typo]
if typo==self.typo then
local actionObj=fightActionMrg:getAction(typo)
if actionObj~=nil then
self.actionObjs[#self.actionObjs+1]={obj=actionObj,delay=0}
actionObj:init(self.round,actionData)
end
end

end
local dataCount=#self.actionObjs
return dataCount
end

function fightNewMonAction:exe(isFetch)

if isFetch then
local dstEnt=self.battle:getEntity(self.dstID)
if self.newMonType==eFightNewMonType.yuanJun then

local entityInfo=fightModel:getEntityInfo(self.rawData)
if dstEnt~=nil then
dstEnt:newMon(entityInfo)
else
dstEnt=self.battle:addEntity(self.dstID,entityInfo)
end

local talk=true
if dstEnt.typo==fightEntityType.monster then
local cfg=cfgHelper.get(cfg_monsterconfig_get,dstEnt.baseInfo.monsterID)
talk=not cfg.isYuanJunTalk
end

if dstEnt then
dstEnt:showHuD(false)
if dstEnt:isLeft()then
dstEnt:runBehavior("fight_enter",{},function()
dstEnt:showHuD(true)
if talk then
dstEnt:flowText(flowObjTypo.tip,{strPara="援军~",nunPara=2})
end
end)
else
dstEnt:runBehavior("fight_right_enter",{},function()
dstEnt:showHuD(true)
if talk then
dstEnt:flowText(flowObjTypo.tip,{strPara="援军~",nunPara=2})
end
end)
end
end
else
fightManager.playEffect(3,fightModel:getPosInfo(self.dstID).pos,true,false)
timeEventController.delayDo(0.5,function()
if dstEnt~=nil then
dstEnt:newMon(fightModel:getEntityInfo(self.rawData),true)
else
dstEnt=self.battle:addEntity(self.dstID,fightModel:getEntityInfo(self.rawData),true)
end
if dstEnt then
dstEnt:playEffect(3,Vector3.zero,true,false)
timeEventController.delayDo(0.2,function()
if dstEnt then
dstEnt:fadeToColor(Color.New(1,1,1,1),0.2)
end
end)
dstEnt:showHuD(true)
end

end)
self.delayTime=0.5

end
self.battle:onYuanJunChange(self.dstID)
else
self.delayTime=1
end
self.isExe=true
self.isComplete=true
end

function fightNewMonAction:statisticsExe()
for i,v in ipairs(self.actionObjs)do
local obj=v.obj
local dstEnt=obj.battle:getEntity(obj.dstID)
if obj.newMonType==eFightNewMonType.yuanJun then
if dstEnt then
if not dstEnt.finalHpPercentList then
dstEnt.finalHpPercentList={0}
end
if dstEnt.finalHpPercentList[#dstEnt.finalHpPercentList]then
dstEnt.finalHpPercentList[#dstEnt.finalHpPercentList]=0
end
dstEnt.finalHpPercentList[#dstEnt.finalHpPercentList+1]=1
local data=dstEnt:copyAttrData()

obj.battle:addNewMonEnt(obj.dstID)
local dataAddId=obj.battle:getNewMonEnt(obj.dstID)
local changeIdx=dataAddId*10000+obj.dstID
obj.battle:setChangeEntData(changeIdx,data)
obj.battle:copyStatisticsDataToOtherId(obj.dstID,changeIdx)
obj.battle:resetStatisticsData(obj.dstID)
dstEnt:resetTotalData()
end
else

obj.battle:addNewMonEnt(obj.dstID)
end
end
end

function fightNewMonAction:logExe(logContent)

self.battle:onYuanJunChange(self.dstID)
local entInfo=fightModel:getEntityInfo(self.rawData)
local newMonStr=""
if self.newMonType==eFightNewMonType.yuanJun then
newMonStr="援军"
else
newMonStr="召唤"
end
logContent(FMT.fmt('{0} [{1}][{2}] {3}:{4} {5}:{6}',newMonStr,entInfo.name,self.dstID,self.battle:getYuanJunInfo()))
self.isComplete=true
end

function fightNewMonAction:update(deltaTime)

local ret=true
if self.isExe then
ret=true
for i,v in ipairs(self.actionObjs)do
if v.hasExe then
local sRet=v.obj:update(deltaTime)
ret=ret and sRet
else
v.delay=v.delay-deltaTime
if v.delay<0 then
v.hasExe=true
v.obj:exe(true)
end
ret=false
end
end
self.delayTime=self.delayTime-deltaTime
ret=self.delayTime<0
end



self.isComplete=ret
return self.isComplete
end


function fightNewMonAction:onDespwan()
self.delayTime=0
fightActionMrg:recycleAction(self)
end

