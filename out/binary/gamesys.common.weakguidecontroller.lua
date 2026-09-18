










local _MODULENAME="weakGuideController"
gameState.addListener(def_table(_MODULENAME))
weakGuideController.name=_MODULENAME


local showWindowCheckBreakMask={
['UIWeakGuideOneWin']=true,
['UIWeakGuideTwoWin']=true,
}
local guideWin={
[1]='UIWeakGuideOneWin',
[2]='UIWeakGuideTwoWin',
}
local uiGuideCompList=nil

local xianhuzhizhanPoint=10

local createStyleFunctions={

[1]={
instanceID=INSTANCE_TYPE.eWeakGuidFingerUIExpand,
refresh=function(widget,styleCfg,winData)

local effect=styleCfg[2]
local showEffect=effect~=nil
widget:SetChildActive(1,showEffect)
if showEffect then
local effectid=effect[1]
local offset=effect[2]
local sortOrderOffset=winData.sortOrderOffset or 1
widget:SetChildShowEffectEx(1,effectid,winData.sortLayer,winData.sortOrder+sortOrderOffset-1,true)

widget:SetChildLocalPos(1,offset[1],offset[2],0)
end
end,
},

[2]={
instanceID=INSTANCE_TYPE.eWeakGuidCollectUIExpand,
refresh=function(widget,styleCfg,winData)
widget:SetChildAnimationStringID(1,'chucao')
end,
},

[3]={
instanceID=INSTANCE_TYPE.eWeakGuidNPCUIExpand,
refresh=function(widget,styleCfg,winData)

local npcData=styleCfg[2]
local modelId=npcData[1]
local scale=npcData[2]
local flipX=npcData[3]
local desc=npcData[4]
local npcOffset=npcData[5]
local modelParams=npcModel:getImageInfoOutSideEx(modelId,scale)
widget:SetChildUIModelShowTarget(4,modelParams.body,modelParams.scale,modelParams.componets,0,false,false,0)
widget:SetChildUIModelShowFlipX(4,flipX)
local npcPos=widget:GetChildLocalPosition(4)
npcPos.x=npcPos.x+npcOffset[1]
npcPos.y=npcPos.y+npcOffset[2]
widget:SetChildLocalPosition(4,npcPos)

widget:SetChildText(3,desc)

local effect=styleCfg[3]
local showEffect=effect~=nil
widget:SetChildActive(1,showEffect)
if showEffect then
local effectid=effect[1]
local offset=effect[2]
local sortOrderOffset=winData.sortOrderOffset or 1
widget:SetChildShowEffectEx(1,effectid,winData.sortLayer,winData.sortOrder+sortOrderOffset-1,true)
widget:SetChildLocalPos(1,offset[1],offset[2],0)
end

widget:SetChildScale(2,Vector3.zero)
local t=widget:SetChildDOScale(2,1,0.2,nil)

end,
}
}

function weakGuideController:onAppStart()
end

function weakGuideController:onEnterState()
self.guidelist={}
uiGuideCompList={}
notifySystem:listenNotify(notifyConfig.onExperiencePointCompleted,weakGuideController.onExperiencePointCompleted)
notifySystem:listenNotify(notifyConfig.showUI,weakGuideController.onshowUI)
end

function weakGuideController:onLeaveState()
self.guidelist=nil
uiGuideCompList=nil
notifySystem:removelistener(notifyConfig.onExperiencePointCompleted,weakGuideController.onExperiencePointCompleted)
notifySystem:removelistener(notifyConfig.showUI,weakGuideController.onshowUI)
end

function weakGuideController:onPlayerCreate(...)
end
function weakGuideController:onLostConnection()
end





function weakGuideController.onExperiencePointCompleted(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
if pointCfg.weakGuid~=nil then
weakGuideController:beginGuide(pointCfg.weakGuid)
end
if point==xianhuzhizhanPoint then
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.finishguide)
end
end

function weakGuideController.onshowUI(name)


if not showWindowCheckBreakMask[name]then
local guidelist=weakGuideController.guidelist
if guidelist then
for channel,guideData in pairs(guidelist)do
if guideData.flag==true then
local guideID=guideData.guideID
weakGuideController:killGuide(guideID)
end
end
end
end
end


function weakGuideController:getGuidByKey(compKey)
if self.guidelist~=nil then
for k,guideData in pairs(self.guidelist)do
local guideID=guideData.guideID
local cfg=cfgHelper.get1(cfg_weakguideconfig_get,guideID)
if cfg.uiParams~=nil then
local uiName=cfg.uiParams[1]
if uiName==compKey then
return cfg
end
end
end
end
return nil
end


function weakGuideController.onWeakGuideComponentChange(compKey,flag,rectTrans,sortLayer,sortOrder)
if uiGuideCompList==nil then return end
if compKey==nil or compKey==''then



return
end

if flag then
if uiGuideCompList[compKey]~=nil then












uiGuideCompList[compKey]={nil,rectTrans,sortLayer,sortOrder}
else

local cfg=weakGuideController:getGuidByKey(compKey)
if cfg~=nil then
uiGuideCompList[compKey]={cfg.id,rectTrans,sortLayer,sortOrder}
weakGuideController:awakeGuide(cfg)
else
uiGuideCompList[compKey]={nil,rectTrans,sortLayer,sortOrder}
end
end
else
local compData=uiGuideCompList[compKey]
if compData==nil then return end

local guideID=compData[1]
if guideID then
if weakGuideController:checkGuideAwake(guideID)then
weakGuideController:killGuide(guideID)
end
end

uiGuideCompList[compKey]=nil
end
end

function weakGuideController:checkGuideChannel(channel)
if self.guidelist~=nil then
return self.guidelist[channel]~=nil
end
return false
end

function weakGuideController:checkGuideAwake(guideID)
if self.guidelist~=nil then
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)
if cfg~=nil then
local channel=cfg.channel
local guideData=self.guidelist[channel]
if guideData~=nil then
if guideData.flag==true then
return true
end
end
end
end
return false
end

function weakGuideController.onWeakGuideComponentClick(compKey)
if uiGuideCompList==nil then return end
local compData=uiGuideCompList[compKey]
if compData==nil then return end

local guideID=compData[1]
if guideID then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eWeakData,tostring(guideID),true)
weakGuideController:killGuide(guideID)
end
end


function weakGuideController:awakeGuide(guideCfg)
local channel=guideCfg.channel
local guideData=self.guidelist[channel]

if guideData==nil or guideData.guideID~=guideCfg.id then return end

local guideID=guideData.guideID
local flag=guideData.flag
if flag==true then

return
end

if guideData.moveLock==true then

return
end

local uiName=guideCfg.uiParams[1]
local compData=uiGuideCompList[uiName]
if compData==nil then

return
end

guideData.flag=true
compData[1]=guideID
local rectTrans=compData[2]
local sortLayer=compData[3]
local sortOrder=compData[4]
local pos=rectTrans.position
local winName=weakGuideController:getGuideWinName(guideCfg)
local args={guideID=guideID,pos=pos,parentUI=rectTrans,sortLayer=sortLayer,sortOrder=sortOrder}
weakGuideController:openGuideWin(guideData,winName,args)
end






function weakGuideController:beginGuide(guideID,pos,isRepeat,jumpParam)
if isRepeat==nil then isRepeat=true end
if isRepeat==false then
local isuse=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWeakData,tostring(guideID),false)
if isuse then return false end
end
local flag=self:addGuide(guideID,pos,jumpParam)





end





function weakGuideController:addGuide(guideID,showPos,jumpParam)
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)
if cfg==nil then return false end

if cfg.screenParams~=nil then

if cameraMoveController:isDoing()then
return false
end
end

local channel=cfg.channel
local guideData=self.guidelist[channel]
if guideData~=nil then
local gID=guideData.guideID
if gID==guideID then

local curTime=gameUtilityModel.getServerShortTime()
local oldTime=guideData.starTime
local lerpTime=curTime-oldTime
if lerpTime<=1.5 then
return false
end
end

weakGuideController:killGuide(gID)
end

guideData={guideID=guideID,starTime=gameUtilityModel.getServerShortTime()}
self.guidelist[channel]=guideData

if cfg.screenParams~=nil then
guideData.moveLock=true

local callBack=function(flag,pos,backParams)
guideData.moveLock=false
local guidePos=showPos or pos
weakGuideController:doGuide(flag,channel,guidePos,backParams,jumpParam)
end
cameraMoveController:Begin(cfg.screenParams,cfg.targetParams,callBack)
else

local pos=showPos or nil
self:doGuide(true,channel,pos,nil,jumpParam)
end
return true
end


function weakGuideController:doGuide(flag,channel,pos,backParams,jumpParam)
if not flag then

self:killChannel(channel)
return
end

local guideData=self.guidelist[channel]
if guideData==nil then

return
end
local guideID=guideData.guideID
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)

local winName=weakGuideController:getGuideWinName(cfg)
if winName==nil then

self:killChannel(channel)
return
end

if cfg.uiParams~=nil then

pos=nil
local uiName=cfg.uiParams[1]
jumpParam=jumpParam or cfg.uiParams[2]
if jumpParam then

local jumpType=0
local jumpId=jumpParam.id
local args=table.deepCopy(jumpParam.args)
if uiwindow_id['UIBuildingWin'].id==jumpId then

if backParams~=nil and backParams.un_build_id~=nil then
args.args=args.args or{}
args.args.un_build_id=backParams.un_build_id
end
end
jumpManager:jump({type=jumpType,id=jumpId,args=args})
else

weakGuideController:awakeGuide(cfg)
end
else
if cfg.screenParams~=nil then

if pos~=nil then

guideData.flag=true
weakGuideController:openGuideWin(guideData,winName,{guideID=guideID,pos=pos})
end
else
if cfg.extrajump then
if pos~=nil then
guideData.flag=true
weakGuideController:openGuideWin(guideData,winName,{guideID=guideID,pos=pos})
end
end
end
end
end

function weakGuideController:getGuideType(guideCfg)
if guideCfg.uiParams~=nil then
return 2
else
return 1
end
end

function weakGuideController:getGuideWinName(guideCfg)
local guideType=weakGuideController:getGuideType(guideCfg)
return guideWin[guideType]
end

function weakGuideController:openGuideWin(guideData,winName,args)
local guideID=args.guideID
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)
local func=function()
guideData.delayTimer=nil


if UIManager:isActive(winName)then
UIManager:invokeUIMethod(winName,'beginGuide',args)
elseif UIManager:findLoadingWindow(winName)~=nil then
local awake_func=function()
UIManager:invokeUIMethod(winName,'beginGuide',args)
UIManager:removeWindowAwake(winName)
end
UIManager:listenWindowAwake(winName,awake_func)
else
UIManager:showWindow(winName,args)
end
end
local delay=cfg.delay
if delay~=nil and delay>0 then
delay=delay/1000
guideData.delayTimer=timeEventController.delayDo(delay,func)
else
func()
end
end


function weakGuideController:killGuide(guideID)
if self.guidelist==nil then return end
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)
if cfg==nil then return end

local channel=cfg.channel
local guideData=self.guidelist[channel]
if guideData==nil then return end

local winName=weakGuideController:getGuideWinName(cfg)
if UIManager:isActive(winName)then
UIManager:invokeUIMethod(winName,'killChannel',channel)
else



self:killChannel(channel)
end
end


function weakGuideController:killChannel(channel)
if self.guidelist==nil then return end
local guideData=self.guidelist[channel]
if guideData~=nil then
if guideData.delayTimer~=nil then
guideData.delayTimer:cancel()
guideData.delayTimer=nil
end
self.guidelist[channel]=nil
end
end


function weakGuideController:checkScreenType(guideID,screenType)
local check=true
local cur=mainControl:getSceneType()
if cur~=screenType then
check=false
end
if not check then
weakGuideController:killGuide(guideID)
end
return check
end

function weakGuideController.worldPos2Screen(guideID,screenType,pos)
local screenPos=nil
local cur=mainControl:getSceneType()
if cur==screenType then

if screenType==eSceneType.eZongmen then

screenPos=_MapManager.WorldToScreenPoint(pos)
elseif screenType==eSceneType.eWorld then

if worldController:isInWorld()then
screenPos=worldController:getScreenPoint(pos)
end
elseif screenType==eSceneType.eXianJie then
screenPos=xianjieController:getScreenPoint(pos)
end
end
if screenPos==nil then
weakGuideController:killGuide(guideID)
end
return screenPos
end

function weakGuideController:createStyle(widget,styleCfg,winData)
local styleType=styleCfg[1]
local data=createStyleFunctions[styleType]
if data then
data.refresh(widget,styleCfg,winData)
end
end

function weakGuideController:getStyleInstance(styleType)
local data=createStyleFunctions[styleType]
return data.instanceID
end
