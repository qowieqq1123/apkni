







def_class("UIXianJie_WorldMapWin",UIWindowBase)









function UIXianJie_WorldMapWin:bindComponents()

self.ActRoot=UIObject.get(self,0)
self.AreaRoot=UIObject.get(self,1)
self.ButtonBack=UIButton.get(self,2)
self.Clouds=UIObject.get(self,3)
self.Head=UIObject.get(self,4)
self.HeadBg=UIObject.get(self,5)
self.infoBtn=UIButton.get(self,6)
self.infoBtnReddot=UIObject.get(self,7)
self.Root=UIObject.get(self,8)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)



end


function UIXianJie_WorldMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ActRoot);self.ActRoot=nil;
_UIObject_release(self.AreaRoot);self.AreaRoot=nil;
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.Clouds);self.Clouds=nil;
_UIObject_release(self.Head);self.Head=nil;
_UIObject_release(self.HeadBg);self.HeadBg=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.infoBtnReddot);self.infoBtnReddot=nil;
_UIObject_release(self.Root);self.Root=nil;
end





















local this=nil
local x={152,-152}
local y={-84,84}
local iconAB="ui/windows/xianjie/xianjiemap/xianjiemap_atlas_pak.ab"
local iconWorld="ui/windows/worldmap/sharedtextures/bigworldmap_component_altas.ab"
local iconAB2="ui/windows/worldmap/worldmapactivityicon_atlas_pak.ab"
local senceTypeList={xianjienSceneType.eXianJie,xianjienSceneType.eXianYu_1,xianjienSceneType.eXianYu_2,
xianjienSceneType.eXianYu_3,xianjienSceneType.eXianYu_4,xianjienSceneType.eXianYu_5,
xianjienSceneType.eXianYu_6,xianjienSceneType.eXianYu_7,xianjienSceneType.eXianYu_8}

local areaCmp={
owner=0,
button=1,
name=2,
lock=3,
nameBg=4,
conditionBg=5,
conditionTx=6,
reddot=7,
foreign=8,
model=9,
icon=10,
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


function UIXianJie_WorldMapWin:onLoaded(...)
this=self
self:bindComponents()
self.cross_sid=loginModel:getCrossServerId()
self.waitLAct={}
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UIXianJie_WorldMapWin:__delete()
this=nil
self:unbindComponents()
self:stopWaitLActTick()
if self.infoShow then
UIManager:invokeUIMethod("UIWorldUnitListWin2","onCloseBtn")
end
end




function UIXianJie_WorldMapWin:onShow(argtable,afterOnloaded)
self:showWindow("UITopMaskWin")

local isShowClouds=false
local allWorldLen=#senceTypeList
self.isUnlock=not xianjieController:checkInPlotScene2()
playerController:setHeadIcon(self.winlua,self.Head:getID(),{scale=0.6})
self.HeadBg:setActive(true)

self.isMiniGame=webGLHelper:isRunMiniGame()

if not self.isMiniGame then
self.winlua:SetChildUIModelShowTarget(self.Root:getID(),5810,1.1,{},eAnimationID.stand)
end






self.Clouds:setActive(isShowClouds)
self.AreaRoot:setChildLayoutGroupCreateItems(allWorldLen,this.refreshMapItem)

end


function UIXianJie_WorldMapWin:onHide()

end

function UIXianJie_WorldMapWin.onClickArea(index)





local sceneType_=xianjieModel:getScenceType()
local temp=xianjieController:jumpXianJie(index,nil,nil)

if not temp then
UIManager.info("已经在当前场景里")
end

UIManager:closeWindow("UIXianJie_mapWin")
UIManager:closeWindow("UIXianJie_WorldMapWin")
end

function UIXianJie_WorldMapWin.refreshMapItem(index)

local x=18
local y=140
local world=senceTypeList[index]
local icon='xj'
local modelid
local xianyuLock
local showName=true
local xList={21,20,6,-15.5,-24.3,-22,-10,10}
local yList={90,81.5,70,75,84,90,93,95}



local cmp=this.AreaRoot:getChildLayoutGroupGridItem(index-1)
local cfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,world)
local iconName=cfg.worldMapParams[6]

local isForeign=false
local out=xianjieModel:getZongMenOutPos()
local sceneType_=xianjieModel:sceneIndex2SceneType(out[1])



if xianjienSceneType:isXianYu(world)then
icon='xy'
x=xList[index-1]
y=yList[index-1]
local k=xianjieModel:getSceneIndex(world)
local cross_sid=xianjieModel:getXianYuCrossServerId(k)

xianyuLock=cross_sid and true or false
modelid=xianyuLock and cfg.worldMapParams[1]or 5813

if this.cross_sid~=cross_sid then
isForeign=true
else
iconName='image_xjbs_dsjbd1'
end

if not xianyuLock then icon='xy_off'end
else
modelid=cfg.worldMapParams[1]
end


if sceneType_==world then
this.winlua:SetChildAnchoredPosition(this.HeadBg:getID(),
mathHelper.convertArrayToVector({cfg.worldMapParams[2][1]+x,cfg.worldMapParams[2][2]+y}))

if sceneType_==xianjienSceneType.eXianYu_3 or sceneType_==xianjienSceneType.eXianYu_4 then
this.winlua:SetChildAnchoredPos(this.Root:getID(),0,-37.5)
end
end

cmp:SetChildActive(areaCmp.foreign,isForeign)
cmp:SetChildAnchoredPosition(areaCmp.owner,mathHelper.convertArrayToVector(cfg.worldMapParams[2]))
cmp:SetChildAnchoredPosition(areaCmp.button,mathHelper.convertArrayToVector(cfg.worldMapParams[2]))

if not this.isMiniGame then
cmp:SetChildUIModelShowTarget(areaCmp.model,modelid,1,{},eAnimationID.stand)
if index==1 then
cmp:SetChildModelAnimationState(areaCmp.model,eAnimationID.stand,0.5)
end
else
cmp:SetChildCSImageSprite(areaCmp.icon,iconAB,icon)
end


if xianyuLock then
if api_Available_SetChildUIModelGray()then
cmp:SetChildUIModelGray(areaCmp.model,not this.isUnlock)
else
local colorV=not this.isUnlock and 0.3 or 1
if not this.isMiniGame then
cmp:SetChildUIModelShowColor(areaCmp.model,Color.New(colorV,colorV,colorV,1))
else
cmp:SetChildImageExGray(areaCmp.icon,true)
end
end

if not this.isUnlock then
cmp:SetChildButtonClick(areaCmp.button,function()

local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianYuEnter,nil,"开启仙域")
UIManager.error(tips)
end)
else
cmp:SetChildButtonClickWithID(areaCmp.button,this.onClickArea,world)
end
else
if index>1 then
showName=false

else
showName=true
cmp:SetChildButtonClickWithID(areaCmp.button,this.onClickArea,world)
end
end

cmp:SetChildAnchoredPosition(areaCmp.button,mathHelper.convertArrayToVector(cfg.worldMapParams[4]))

local name=xianjieController:getCrossServerNamebySCidx(index-1)or cfg.name
cmp:SetChildActive(areaCmp.lock,false)
cmp:SetChildText(areaCmp.name,name)

cmp:SetChildCSImageSprite(areaCmp.nameBg,iconAB,iconName)
cmp:SetChildAnchoredPosition(areaCmp.nameBg,mathHelper.convertArrayToVector(cfg.worldMapParams[3]))

cmp:SetChildActive(areaCmp.name,showName)
cmp:SetChildActive(areaCmp.nameBg,showName)

local condCheck=false
cmp:SetChildActive(areaCmp.conditionBg,condCheck)

local reddot=false
cmp:SetChildActive(areaCmp.reddot,reddot)
end

function UIXianJie_WorldMapWin:startWaitLActTick(actId,index)
self.waitLAct[actId]=index
if not self.waitLActTick then
self.waitLActTick=self:setTimer(1,0,function()
self:updateWaitLActTick()
end)
end
end

function UIXianJie_WorldMapWin:stopWaitLActTick(actId)
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

function UIXianJie_WorldMapWin:updateWaitLActTick()
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

function UIXianJie_WorldMapWin:refreshActTickInfo()
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
item:SetChildSizeDelta(_actCmp.button,100,100)
item:SetChildButtonClick(_actCmp.button,function()
jumpManager:jump({id=JUMP_TYPE.eLimitActivity,args={actID=actId}})
end)
if config.icon then
item:SetChildCSImageSprite(_actCmp.icon,iconAB2,config.icon)
elseif config.spine then
item:SetChildUIModelShowTarget(_actCmp.model,config.spine,0.45,{},eAnimationID.stand,false,false,0)
end
item:SetChildAnchoredPosition(_actCmp.root,mathHelper.convertArrayToVector({-260.5,100}))
item:SetChildAnchoredPosition(_actCmp.nameBg,mathHelper.convertArrayToVector({45,11.5}))


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
end
end)
end

function UIXianJie_WorldMapWin.on_building_event(event,level,exp,lastLv)
if event==buildingEvent.zongmenLevelUp and level~=lastLv then
this:refreshActTickInfo()
end
end

function UIXianJie_WorldMapWin.onNewDay()
this:refreshActTickInfo()
end




function UIXianJie_WorldMapWin:onButtonBack()
self:closeSelf()
end


function UIXianJie_WorldMapWin:onInfoBtn()
end
