







def_class("UIWorldMapWinEx",UIWindowBase)









function UIWorldMapWinEx:bindComponents()

self.infoBtnReddot=UIObject.get(self,0)
self.Head=UIObject.get(self,1)
self.ActRoot=UIObject.get(self,2)
self.AreaRoot=UIObject.get(self,3)
self.Clouds=UIObject.get(self,4)
self.HeadBg=UIObject.get(self,5)
self.infoBtn=UIButton.get(self,6)
self.ButtonBack=UIButton.get(self,7)
self.Root=UIButton.get(self,8)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.Root:setButtonClick(function()self:onRoot()end)



end


function UIWorldMapWinEx:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoBtnReddot);self.infoBtnReddot=nil;
_UIObject_release(self.Head);self.Head=nil;
_UIObject_release(self.ActRoot);self.ActRoot=nil;
_UIObject_release(self.AreaRoot);self.AreaRoot=nil;
_UIObject_release(self.Clouds);self.Clouds=nil;
_UIObject_release(self.HeadBg);self.HeadBg=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.Root);self.Root=nil;
end
















local _this=nil
local areaCmp={
owner=0,
button=1,
name=2,
lock=3,
nameBg=4,
conditionBg=5,
conditionTx=6,
reddot=7,
}
local _actCmp={
root=-1,
button=0,
name=1,
nameBg=2,
conditionBg=3,
conditionTx=4,
reddot=5,
model=6,
icon=7,
sign=8,
}
local iconAB="ui/windows/worldmap/sharedtextures/bigworldmap_component_altas.ab"
local iconAB2="ui/windows/worldmap/worldmapactivityicon_atlas_pak.ab"



function UIWorldMapWinEx:onLoaded(...)
self:bindComponents()
_this=self
self.waitLAct={}
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UIWorldMapWinEx:__delete()
self:unbindComponents()
_this=nil
self:stopWaitLActTick()
if self.infoShow then
UIManager:invokeUIMethod("UIWorldUnitListWin2","onCloseBtn")
end
end




function UIWorldMapWinEx:onShow(argtable,afterOnloaded)
self:showWindow("UITopMaskWin")
self.enterCallBack=argtable.enter
self.closeCallback=argtable.close
self.currentWorld=argtable.current
self.infoShow=argtable.showInfo or false

playerController:setHeadIcon(self.winlua,self.Head:getID(),{scale=0.6})
self.HeadBg:setActive(self.currentWorld~=nil)

if self.currentWorld then
local enterWorldCfg=allWorldCfg[self.currentWorld]
local pos=mathHelper.convertArrayToVector(enterWorldCfg.worldMapParams[4])
self.HeadBg:setChildAnchoredPosition(pos)
end

local allWorldCfg=cfg_worldconfig()
self.AreaRoot:setChildLayoutGroupCreateItems(#allWorldCfg,_this.refreshMapItem)

self.infoBtn:setActive(self.infoShow)

self:refreshActTickInfo()
end


function UIWorldMapWinEx:onHide()

end





function UIWorldMapWinEx:onButtonBack()
if self.closeCallback then
self.closeCallback()
else
self:closeSelf()
end
end

function UIWorldMapWinEx:onInfoBtn()


if not UIManager:isActive("UIWorldUnitListWin2")then
UIManager:showWindow("UIWorldUnitListWin2")
end



end

function UIWorldMapWinEx:onRoot()


UIManager:invokeUIMethod("UIWorldUnitListWin2","onCloseBtn")

end

function UIWorldMapWinEx.onClickArea(index)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,index)
local check,warning=worldBlockModel:checkWorldEnterLimit(areaCfg.world)
if check then
if _this.enterCallBack then
_this.enterCallBack(index)
end
else
UIManager.info(warning)
end
end

function UIWorldMapWinEx.refreshMapItem(index)
local cmp=_this.AreaRoot:getChildLayoutGroupGridItem(index-1)
local world=index
local cfg=cfgHelper.get1(cfg_worldconfig_get,world)
cmp:SetChildAnchoredPosition(areaCmp.owner,mathHelper.convertArrayToVector(cfg.worldMapParams[2]))
cmp:SetChildCSImageSprite(areaCmp.button,iconAB,cfg.worldMapParams[1])
cmp:SetChildButtonClickWithID(areaCmp.button,_this.onClickArea,world)


cmp:SetChildNewBieComponentId(areaCmp.button,FMT.fmt('UIWorldMapWinEx.mapItem.{0}',world))

local lock=not worldBlockModel:checkWorldEnterLimit(world)
cmp:SetChildImageExGray(areaCmp.button,lock)
cmp:SetChildActive(areaCmp.lock,false)
cmp:SetChildText(areaCmp.name,cfg.name)
cmp:SetChildAnchoredPosition(areaCmp.nameBg,mathHelper.convertArrayToVector(cfg.worldMapParams[3]))

local condCheck=false
cmp:SetChildActive(areaCmp.conditionBg,condCheck)

local reddot=not lock and worldBlockModel:checkWorldEnterLimitReddot(world)
cmp:SetChildActive(areaCmp.reddot,reddot)
end

function UIWorldMapWinEx:startWaitLActTick(actId,index)
self.waitLAct[actId]=index
if not self.waitLActTick then
self.waitLActTick=self:setTimer(1,0,function()
self:updateWaitLActTick()
end)
end
end

function UIWorldMapWinEx:stopWaitLActTick(actId)
if actId then
self.waitLAct[actId]=nil
if next(self.waitLAct)then
return
end
end
if self.waitLActTick then
self:stopTimerByID(self.waitLActTick)
self.waitLActTick=nil
end
end

function UIWorldMapWinEx:updateWaitLActTick()
local stopList={}
for actId,index in pairs(self.waitLAct)do
local item=self.ActRoot:getChildLayoutGroupGridItem(index-1)
local leastTime=limitActivitiesModel:getActStartLeftTime(actId)
local actCfg=limitActivitiesModel:getActConfig(actId)
if leastTime>0 then
item:SetChildText(_actCmp.conditionTx,FMT.fmt("quad-icon=icon_gantanhao_1-quad{0}后\n<color=#ca631d>{1}</color>现世",timeHelper.formatSimpleTime(leastTime),actCfg.name))
else
item:SetChildImageExGray(_actCmp.button,false)
item:SetChildActive(_actCmp.conditionBg,false)
table.insert(stopList,actId)
end
end
for i,v in ipairs(stopList)do
self:stopWaitLActTick(v)
end
end

function UIWorldMapWinEx:refreshActTickInfo()
self:stopWaitLActTick()

local actList={}
local lp=limitActivitiesModel.getWorldMapLimitAct()
for lActID,Cfg in pairs(lp)do
local actInfo=limitActivitiesModel:getActInfo(lActID)
if actInfo then
table.insert(actList,actInfo)
end
end
self.ActRoot:setChildLayoutGroupCreateItems(#actList,function(index)
local item=self.ActRoot:getChildLayoutGroupGridItem(index-1)
local actInfo=actList[index]
local actId=actInfo.actID
local config=cfgHelper.get1(cfg_worldmaplimitactivityconfig_get,actId)
local actCfg=actInfo:getActConfig()
item:SetChildSizeDelta(_actCmp.button,config.size[1],config.size[2])
item:SetChildButtonClick(_actCmp.button,function()
jumpManager:jump({id=JUMP_TYPE.eLimitActivity,args={actID=actId}})
end)
if config.icon then
item:SetChildCSImageSprite(_actCmp.icon,iconAB2,config.icon)
elseif config.spine then
item:SetChildUIModelShowTarget(_actCmp.model,config.spine,1,{},eAnimationID.stand,false,false,0)
end
item:SetChildAnchoredPosition(_actCmp.root,mathHelper.convertArrayToVector(config.iconPos))
item:SetChildAnchoredPosition(_actCmp.nameBg,mathHelper.convertArrayToVector(config.namePos))
item:SetChildText(_actCmp.name,actCfg.name)

local condCheck,condStr=actInfo:checkCondition()
if condCheck then
local leastTime=limitActivitiesModel:getActStartLeftTime(actId)
item:SetChildActive(_actCmp.conditionBg,leastTime>0)
if config.icon then
item:SetChildImageExGray(_actCmp.icon,leastTime>0)
elseif config.spine then
if api_Available_SetChildUIModelGray()then
item:SetChildUIModelGray(_actCmp.model,leastTime>0)
else
local colorV=leastTime>0 and 0.3 or 1
item:SetChildUIModelShowColor(_actCmp.model,Color.New(colorV,colorV,colorV,1))
end
end

local signIcon
if actId==LIMIT_ACT_TYPE.eZhengZhanShanHai then
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPStandby then
signIcon='image_shsjui_1'
elseif raceState==eZZSH_State.ePVPFight then
signIcon='image_shsjui_2'
end
end
local showSign=signIcon~=nil
item:SetChildActive(_actCmp.sign,showSign)
if showSign then
item:SetChildCSImageSprite(_actCmp.sign,globalABLookup.bigworldmap_component,signIcon)
end
if leastTime>0 then
item:SetChildText(_actCmp.conditionTx,FMT.fmt("quad-icon=icon_gantanhao_1-quad{0}后\n<color=#ca631d>{1}</color>现世",timeHelper.formatSimpleTime(leastTime),actCfg.name))
if pfwindowslController:checkIsGameVersion_yuenan()then
item:SetChildText(_actCmp.conditionTx,FMT.fmt("quad-icon=icon_gantanhao_1-quad  {0}后\n<color=#ca631d>{1}</color>现世",timeHelper.formatSimpleTime(leastTime),actCfg.name))
end
self:startWaitLActTick(actId,index)
end
else
item:SetChildActive(_actCmp.conditionBg,true)
item:SetChildActive(_actCmp.sign,false)
if config.icon then
item:SetChildImageExGray(_actCmp.icon,true)
elseif config.spine then
if api_Available_SetChildUIModelGray()then
item:SetChildUIModelGray(_actCmp.model,true)
else
local colorV=0.3
item:SetChildUIModelShowColor(_actCmp.model,Color.New(colorV,colorV,colorV,1))
end
end
item:SetChildText(_actCmp.conditionTx,FMT.fmt("quad-icon=icon_gantanhao_1-quad{0}",condStr))
if pfwindowslController:checkIsGameVersion_yuenan()then
item:SetChildText(_actCmp.conditionTx,FMT.fmt("quad-icon=icon_gantanhao_1-quad  {0}",condStr))
end
end
end)
end

function UIWorldMapWinEx.on_building_event(event,level,exp,lastLv)
if event==buildingEvent.zongmenLevelUp and level~=lastLv then
_this:refreshActTickInfo()
end
end

function UIWorldMapWinEx.onNewDay()
_this:refreshActTickInfo()
end