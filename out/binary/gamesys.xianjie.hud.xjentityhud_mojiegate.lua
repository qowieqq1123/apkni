









local xjEntityHud_mojieGate={}


function xjEntityHud_mojieGate:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0)}
self.tagOffset={Vector3(0,20,0)}
local data=self.data
self.gateId=data[1]
self.lastAtkState=nil
end


function xjEntityHud_mojieGate:onCreateWidget(widget)
return self:initShow(widget)
end


function xjEntityHud_mojieGate:onRemoveWidget(widget)

end

function xjEntityHud_mojieGate:initShow(widget)
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil


local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,self.gateId)
local gateXYSceneIndex=gateCfg.area
local isSelfXianYu=gateXYSceneIndex==xianjieModel:getXianYuSceneIndex()
local isShowHud=true
if not isSelfXianYu then

local hasFinishAtkGate=xianjieModel:checkMoJieGateHasFinishAttackGate()
if hasFinishAtkGate then
isShowHud=false
end
end

widget:SetChildActive(0,isShowHud)
if isShowHud then

local gateName=gateCfg.name
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
local nameStr=FMT.fmt("{0}·{1}",xyName,gateName)
widget:SetChildText(8,nameStr)

local hasXM=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)
local isCanPass=xianjieModel:checkMoJieGateIsSelfXMCanPass(self.gateId)
if not hasXM and not isCanPass then


widget:SetChildActive(5,false)


local atkState=xianjieModel:getMoJieGateAtkState(self.gateId)

local isShowHpProgress=true
self.lastAtkState=atkState
local stageId=gateData and gateData.stageId or 1
local stageType=gateData and gateData.stageType or seasonStageType.eGKYS
self.gateBaseCfg=seasonModel:getStageConfig(stageType,stageId)

widget:SetChildActive(1,isShowHpProgress)
if isShowHpProgress then
local maxHpValue=self.gateBaseCfg.guankou_hp
local showHpValue=gateData and gateData.hp or 10000

if gateData.fixTime and gateData.fixTime>0 then
local cdTime=self.gateBaseCfg.fix_time
local startTime=gateData.fixTime
local endTime=startTime+cdTime
local nowTime=timeHelper.getServerShortTime()
if nowTime>endTime then

showHpValue=maxHpValue
end
end

widget:SetChildProgressValue(2,showHpValue,maxHpValue)
local progressStr
if atkState~=2 then
local hpShowPercent=showHpValue/maxHpValue*100
if hpShowPercent<0.01 then
hpShowPercent=0.01
end
progressStr=string.format('%0.2f%%',hpShowPercent)
else
progressStr="修复中"
end
widget:SetChildProgressText(2,progressStr)
end

local isShowLock=false
widget:SetChildActive(10,isShowLock)



self.isShowTimePanel=atkState==1 or atkState==2

widget:SetChildActive(3,self.isShowTimePanel)

if self.isShowTimePanel then
self:refreshTime(widget)
end


widget:SetChildButtonClick(0,function()
return self:onClick()
end,true)
else
self.lastAtkState=nil
self.isShowTimePanel=false

widget:SetChildActive(1,false)
widget:SetChildActive(3,false)
widget:SetChildActive(10,false)
widget:SetChildActive(5,true)


widget:SetChildActive(6,isCanPass)
widget:SetChildActive(7,not isCanPass)
local passStr=isCanPass and"可通行"or"<color=#f36666>不可通过</color>"
widget:SetChildText(9,passStr)


widget:SetChildButtonClick(5,function()
return self:onClick()
end,true)


widget:SetChildButtonClick(0,function()
return self:onClick()
end,true)
end
end
end

function xjEntityHud_mojieGate:refreshTime(widget,isInit)
local gateEntityData=xianjieModel:getMoJieGateData(self.gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local atkState=xianjieModel:getMoJieGateAtkState(self.gateId)
local nowTime=timeHelper.getServerShortTime()
local cdTime
local startTime
local endTime
local isShowTime=false
local isChangeState=atkState~=self.lastAtkState
if gateData and(atkState==1 or atkState==2)then
if atkState==1 then

startTime=gateData.atkTime
endTime=gateData.fixTime
elseif atkState==2 then
cdTime=self.gateBaseCfg.fix_time
startTime=gateData.fixTime
endTime=startTime+cdTime
end
isShowTime=nowTime<=endTime
end

if isShowTime and not isChangeState then
local allTime=endTime-startTime
local deltaTime=nowTime-startTime
local percent=math.floor(deltaTime/allTime*10000)
widget:SetChildProgressValue(4,percent,10000)

local lerp=endTime-nowTime
widget:SetChildProgressText(4,timeHelper.format_time_stamp11(lerp,true))
else
self.isShowTimePanel=nil
self:initShow(widget)
end
end

function xjEntityHud_mojieGate:refreshInfo()
local widget=self:getWidget()
if widget then

self:initShow(widget)
end
end

function xjEntityHud_mojieGate:resetShow()
local widget=self:getWidget()
if widget then
return self:initShow(widget)
end
end

function xjEntityHud_mojieGate:onClick()
if not self:checkWidget()then return end



xianjieController:openMoJieGateWin(self.gateId)
end


function xjEntityHud_mojieGate:onDelete()

end


function xjEntityHud_mojieGate:onUpdate()
local widget=self:getWidget()
if widget then
if self.isShowTimePanel then
self:refreshTime(widget)
end
end
end

return xjEntityHud_mojieGate