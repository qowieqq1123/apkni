






local _MODULENAME="zongmenVisitorController"



gameState.addListener(def_table(_MODULENAME))
zongmenVisitorController.name=_MODULENAME


zongmenVisitorController.data={}

function zongmenVisitorController:onAppStart()

zongmenVisitorModel:onAppStart()






socketManager:register_receiver(26,102,self.recv_26_102)
socketManager:register_receiver(26,103,self.recv_26_103)
socketManager:register_receiver(26,104,self.recv_26_104)

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)

notifySystem:listenNotify(notifyConfig.onEnterOtherHome,self.onEnterOtherHome)
notifySystem:listenNotify(notifyConfig.onExitOtherHome,self.onExitOtherHome)
end


function zongmenVisitorController:onEnterState(isReconnect)
zongmenVisitorModel:onEnterState()
end


function zongmenVisitorController:onProtocolReq()
zongmenVisitorModel:onProtocolReq()
end


function zongmenVisitorController:onLeaveState(isReconnect)
zongmenVisitorModel:onLeaveState(isReconnect)

self.data={}
end


function zongmenVisitorController:onLostConnection()

end


function zongmenVisitorController:onReConnection(isInitPro)

end

function zongmenVisitorController:onProtocolReq()

end




function zongmenVisitorController:send_26_102(playId)
playId=playId or playerModel:getActorID()
socketManager:send_26_102(playId)
end




function zongmenVisitorController:send_26_103(playId,rewardIdx)
playId=playId or playerModel:getActorID()
socketManager:send_26_103(playId,rewardIdx)
end



function zongmenVisitorController:send_26_104(playId)
socketManager:send_26_104(playId)
end







function zongmenVisitorController.recv_26_102(args)
local playId=args[1]
local visitorId=args[2]
local len=args[3]
local rewardList=args[4]
local getNum=args[5]
local firstFlag=args[6]
local isFirstVisitor=firstFlag and firstFlag==1 or false
zongmenVisitorModel:setNum(getNum)
zongmenVisitorModel:setVisitor(playId,visitorId,rewardList)
local isSelf=playId==playerModel:getActorID()
if isSelf then
if visitorId==0 then
zongmenVisitorModel:clearRecord()
elseif not zongmenVisitorModel:checkRecord()then
zongmenVisitorModel:clearRecord()
end
end

if mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
local mapId=nil
if playId==playerModel:getActorID()then
mapId=mapIdType.zhufeng
elseif zongmenModel:getMountainId()==mapIdType.zhufeng_hy and visitControl:getCurrentActor()==playId then
mapId=mapIdType.zhufeng_hy
end
if mapId then
local entData=zongmenVisitorModel:getEntity(mapId)
if visitorId>0 then
if entData then

zongmenVisitorController:changeEntity(mapId,visitorId,playId)
else

zongmenVisitorController:createEntity(mapId,visitorId,playId)
end
else
if entData then

zongmenVisitorController:deleteEntity(mapId)
end
end
end
end

if isSelf then
local name=playerModel:getActorName()
local check1=zongmenVisitorModel:checkNum()
local check2=zongmenVisitorModel:checkAwarded(playId,name)
local show=visitorId>0 and check1 and not check2
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',1,show)
end
end






function zongmenVisitorController.recv_26_103(playId,rewardIdx,result,getNum)
if result==0 then
zongmenVisitorModel:setNum(getNum)
zongmenVisitorModel:awardVisitor(playId,rewardIdx)

UIManager:invokeUIMethod("UIZongMenVisitorWin","refreshGet",playId,rewardIdx)

if playId==playerModel:getActorID()then
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',1,false)
end
zongmenVisitorController:refreshHUD(playId)

return
elseif result==1 then
UIManager.error("奖励已被他人领取")
elseif result==2 then
UIManager.error("已达最大领取次数")
elseif result==3 then
UIManager.error("无法重复领取奖励")
elseif result==4 then
UIManager.error("该宗门访客已离开")
end
zongmenVisitorController:send_26_102(playId)
end




function zongmenVisitorController.recv_26_104(playId,rwNum)
local check=zongmenVisitorModel:getCheck(playId)
if check then
local max=cfgHelper.get2(cfg_zongmenfangkebaseconfig_get,1,"rewardMax")
if max>rwNum then





zongmenVisitorModel:setRecord(playId)

UIManager.info("分享成功")
else
zongmenVisitorModel:setRecord(playId,true)
UIManager.error("对方领取奖励次数已耗尽")
end
UIManager:invokeUIMethod("UIZongMenVisitorWin","refreshSharedButton",playId)
zongmenVisitorModel:clearCheck(playId)
end
end



function zongmenVisitorController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eZongMenFangKe and mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then

end
end

function zongmenVisitorController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
local playId=playerModel:getActorID()
zongmenVisitorController:checkEntity(mapIdType.zhufeng,playId)
elseif etype==homeEvent.eLeaveHome then
zongmenVisitorController:deleteEntity(mapIdType.zhufeng)
zongmenVisitorController:deleteEntity(mapIdType.zhufeng_hy)
end
end

function zongmenVisitorController.onNewDay5am(islogin)
if not islogin and systemModel.isOpen(SYSTEM_DEFINE.eZongMenFangKe)then
if timeHelper.getWeakDateEx()==1 then
zongmenVisitorModel:clearRecord()
if fullScreenUI.checkFull(UIFullZongMenVisitorControl)then
UIFullZongMenVisitorControl:closeUI()
end
end
if mainControl:isSceneType(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
zongmenVisitorController:send_26_102()
if zongmenModel:getMountainId()==mapIdType.zhufeng_hy then
local visitActor=visitControl:getCurrentActor()
if visitActor~=0 then
zongmenVisitorController:send_26_102(visitActor)
end
end
end
end
end

function zongmenVisitorController.onEnterOtherHome(actorId)
if zongmenVisitorController.showOther then
zongmenVisitorController:checkEntity(mapIdType.zhufeng_hy,actorId)
end
end

function zongmenVisitorController.onExitOtherHome(actorId)
zongmenVisitorController:deleteEntity(mapIdType.zhufeng_hy)
if zongmenVisitorController.showOther then
local actorInfo=friendModel:getActorInfo(actorId)
UIManager:showWindow('UIChatWin',{channelId=CHAT_CHANNNEL.ePrivate,actorInfo=actorInfo})
end
zongmenVisitorController:setShowOther(false)
end

function zongmenVisitorController:checkEntity(mapId,playId)
if systemModel.isOpen(SYSTEM_DEFINE.eZongMenFangKe)then
local visitor=zongmenVisitorModel:getVisitor(playId)
if visitor==nil then
zongmenVisitorController:send_26_102(playId)
elseif visitor.id>0 then
zongmenVisitorController:createEntity(mapId,visitor.id,playId)
end
end
end

function zongmenVisitorController:shareLink(formType,actorId)
local endtime=zongmenVisitorModel:getNextMonday5oClock()
zongmenVisitorModel:addCheck(actorId,formType,endtime)
self:send_26_104(actorId)
end

function zongmenVisitorController:calculatePos(mapId)
local temp=cfgHelper.get2(cfg_zongmenfangkebaseconfig_get,1,"titleMapRandPos")
local list={}
for i,v in ipairs(temp)do
local cell=_MapManager.ToVector3Int(v[1],v[2],0)
local area=_MapManager.GetAreaID(mapId,cell)
if _MapManager.IsAreaUnlock(mapId,area)then
table.insert(list,cell)
end
end
return list
end

function zongmenVisitorController:createEntity(mapId,visitorId,playId)
local visitorCfg=cfgHelper.get1(cfg_zongmenfangkeconfig_get,visitorId)
local posCfg=self:calculatePos(mapId)
local modelCfg=visitorCfg.model
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=posCfg[math.random(1,#posCfg)]



local guid=isometricMapSystem:createRoleEntity(objectType.eZMVisitor,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
if not isometricMapSystem:isInNormalMode()then

_MapManager.SetObjectDisplay(objectType.eZMVisitor,false)
end
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=nil
hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
hud=id
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
UIFullZongMenVisitorControl:showMainWindow()
end)
local check=zongmenVisitorModel:checkAwarded(playId,playerModel:getActorName())
widget:SetChildActive(1,not check)
end)
zongmenVisitorModel:setEntity(mapId,guid,bt,hud,visitorId)
end

function zongmenVisitorController:deleteEntity(mapId)
local entData=zongmenVisitorModel:getEntity(mapId)
if entData then
if entData.entBt then
behaviorManager:removeBehaviorTree(entData.entBt)
end
if entData.entHud then
hudControl:removeHUD(entData.entHud)
end
_MapManager.RemoveTilemapObject(entData.entGuid)

zongmenVisitorModel:clearEntity(mapId)
end
end

function zongmenVisitorController:changeEntity(mapId,visitorId,playId)
local entData=zongmenVisitorModel:getEntity(mapId)
if entData then
if entData.visitor~=visitorId then
local visitorCfg=cfgHelper.get1(cfg_zongmenfangkeconfig_get,visitorId)
local modelCfg=visitorCfg.model
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
_MapManager.ChangeBody(entData.entGuid,body,slots,scale)
end

if entData.entHud then
local widget=hudControl:getHUDWidget(entData.entHud)
local check=zongmenVisitorModel:checkAwarded(playId,playerModel:getActorName())
widget:SetChildActive(1,not check)
end
end
end

function zongmenVisitorController:refreshHUD(playId)
local mapId=playId==playerModel:getActorID()and mapIdType.zhufeng or mapIdType.zhufeng_hy
local entData=zongmenVisitorModel:getEntity(mapId)
if entData and entData.entHud then
local widget=hudControl:getHUDWidget(entData.entHud)
local check=zongmenVisitorModel:checkAwarded(playId,playerModel:getActorName())
widget:SetChildActive(1,not check)
end
end

function zongmenVisitorController:setShowOther(show)
self.showOther=show
end

function zongmenVisitorController:moveCameraToVisitorEntity()
local mapId=zongmenModel:getMountainId()
local entData=zongmenVisitorModel:getEntity(mapId)
if entData then
isometricMapSystem:moveCameraToObjectEx(entData.entGuid,true)
end
end

function zongmenVisitorController:stopEntityAI(sfId)
local mapId=sfId or mapIdType.zhufeng
local entData=zongmenVisitorModel:getEntity(mapId)
if entData and entData.entBt then
behaviorManager:removeBehaviorTree(entData.entBt)
entData.entBt=nil
end
end

function zongmenVisitorController:resumeEntityAI(sfId)
local mapId=sfId or mapIdType.zhufeng
local entData=zongmenVisitorModel:getEntity(mapId)
if entData and not entData.entBt then
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=entData.entGuid},true,{})
entData.entBt=bt
end
end