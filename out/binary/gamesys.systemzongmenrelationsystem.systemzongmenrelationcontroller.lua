






local _MODULENAME="systemZongmenRelationController"

gameState.addListener(def_table(_MODULENAME))
systemZongmenRelationController.name=_MODULENAME
systemZongmenRelationController.data={}

function systemZongmenRelationController:onAppStart()

systemZongmenRelationModel:onAppStart()
systemZongmenRelationController.setSystemZMPlotData()
end


function systemZongmenRelationController:onEnterState(isReconnect)
systemZongmenRelationModel:onEnterState()

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function systemZongmenRelationController:onProtocolReq()
systemZongmenRelationModel:onProtocolReq()
end


function systemZongmenRelationController:onLeaveState(isReconnect)
systemZongmenRelationModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end


function systemZongmenRelationController:onLostConnection()

end


function systemZongmenRelationController:onReConnection(isInitPro)

end


function systemZongmenRelationController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
systemZongmenRelationController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
systemZongmenRelationController:onLeaveHome()
end
end

function systemZongmenRelationController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eJiuChongTianJieComplete then
if not isometricMapSystem:IsInHome()then return end
systemZongmenRelationController:createEntity()
end
end

function systemZongmenRelationController.req_vassal()
systemZongmenRelationModel:setWillChangeZM()
systemZongMenController:req_system_zongmen_permanent_vassal()
end

function systemZongmenRelationController:createEntity()


if not isometricMapSystem:IsInHome()then return end

if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then return end
if self.systemZmVassalPlotState==1 then return end

local npcid=77
local image=npcModel:getImageInfoOutSide(npcid,2)
if image then
local bodyid=image.body
local componets=image.componets
local scale=isometricMapSystem:getModelScale(bodyid)or 1
local pos={-8,-47}
local x=pos[1]
local y=pos[2]
pos=_MapManager.ToVector3Int(x,y,0)
local guid=isometricMapSystem:createRoleEntity(objectType.eVassalPlotNpc,mapIdType.zhufeng,0,bodyid,componets,SortingLayers.ITBuilding,scale,pos)
if not isometricMapSystem:isInNormalMode()then

_MapManager.SetObjectDisplay(objectType.eVassalPlotNpc,false)
end

local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eChallengeVisitor,guid,offset,true,true,function(id)
systemZongmenRelationController:freshVisitorHud(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(1,function()
self:showStory()
self:freshVisitorHud()
end)
end)
local hideColor=Color.New(1,1,1,0)
_MapManager.SetFadeToColor(guid,hideColor,0,nil)
local target=Color.New(1,1,1,1)
local duration=1
_MapManager.SetFadeToColor(guid,target,duration,nil)

self.data.visitor=guid
self.data.visitorHud=hud
else
logErr(FMT.fmt("缺少npc：{0} 配置",npcid))
end
end

function systemZongmenRelationController:showStory()
self:hideVisitor()
storyAIManager:startStoryBehavior("story_39_xianjieZMFS_1",nil,function()
systemZongmenRelationController:req_vassal()
end)
end

function systemZongmenRelationController:onEnterHome()
systemZongmenRelationController:createEntity()
end

function systemZongmenRelationController:onLeaveHome()

end

function systemZongmenRelationController:freshVisitorHud(hud)
local widget=hudControl:getHUDWidget(self.data.visitorHud)

local isShow=not self.data.isShowStart

hudControl:setHUDActive(self.data.visitorHud,isShow)
if isShow then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_sjgantanhao')
end
end

function systemZongmenRelationController:setSpeakContent(bt)
local level=bt:getSharedVar('level')
local challengeid=zmvisitchallengeModel:getOpenChallengeId()
local speakContentOption=cfgHelper.get3(cfg_visitorchallengelayerconfig_get,challengeid,level,'monsterspeaklist')
local randomIndex=Mathf.Random(1,#speakContentOption)
local content=speakContentOption[randomIndex][1]
bt:setSharedVar('speakContent',content)
end

function systemZongmenRelationController:changeVassalNpcModel(isShow)
local visitor=self.data.visitor
if visitor then
local hudId=self.data.visitorHud
if hudId then
local hudWidget=hudControl:getHUDWidget(hudId)
hudWidget:SetChildActive(-1,isShow)
end

local guid=self.data.visitor
if guid then
local npcEntity=_EntityManager:GetEntity(guid)
npcEntity:SetVisible(isShow)
end
end
end

function systemZongmenRelationController:finishPlot()
systemZongmenRelationController.systemZmVassalPlotState=1
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.systemZMVassalPlot,1,{systemZongmenRelationController.systemZmVassalPlotState})
if self.data.visitorHud then
hudControl:removeHUD(self.data.visitorHud)
end
if self.data.visitor then
_MapManager.RemoveTilemapObject(self.data.visitor)
end
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsg',zmMsgType.zmRelationPlot,false)
end

function systemZongmenRelationController.setSystemZMPlotData(len,val)
systemZongmenRelationController.systemZmVassalPlotState=val and val[1]or 0
end

function systemZongmenRelationController:hideVisitor()
if self.data.visitorHud then
hudControl:setHUDActive(self.data.visitorHud,false)
end
if self.data.visitor then
_MapManager.SetObjectDisplay(objectType.eVassalPlotNpc,false)
end
end

function systemZongmenRelationController:checkShowMsg()
if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
return false
end
if self.systemZmVassalPlotState==1 then
return false
end

return true
end

function systemZongmenRelationController:moveSelectEnt()
if self.data.visitor then
local callback=function()
local npcEntity=_EntityManager:GetEntity(self.data.visitor)
local pos=npcEntity:GetPosition()

if pos then
local weakGuideId=3563
weakGuideController:beginGuide(weakGuideId,pos)
end
end

isometricMapSystem:moveCameraToObjectEx(self.data.visitor,true,callback,0.5)
end
end

