








shanMenDaZhenController=gameState.addListener({})




local stopEffect=CS.GameInterface.StopEffect
function shanMenDaZhenController:onAppStart()

shanMenDaZhenModel:onAppStart()



socketManager:register_receiver(3,195,shanMenDaZhenController.recv_3_195)
socketManager:register_receiver(3,196,shanMenDaZhenController.recv_3_196)
socketManager:register_receiver(3,197,shanMenDaZhenController.recv_3_197)





worldController:registerSceneState(worldModel.ON_SCENE_STATE.ENTER,1,function()
shanMenDaZhenController:onEnterWorld(worldModel.world)
end)
worldController:registerSceneState(worldModel.ON_SCENE_STATE.EXIT,1,function()
shanMenDaZhenController:onExitWorld(worldModel.world)
end)
end


function shanMenDaZhenController:onEnterState(isReconnect)
shanMenDaZhenModel:onEnterState()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onNewGameYear,self.onNewGameYear)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
self.data={}
end


function shanMenDaZhenController:onProtocolReq()
shanMenDaZhenModel:onProtocolReq()
shanMenDaZhenModel:initLevelUpCostLookup()
end


function shanMenDaZhenController:onLeaveState(isReconnect)
shanMenDaZhenModel:onLeaveState(isReconnect)
self:removeBuildingModel()
self:removeZongMenDaZhenEffect()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onNewGameYear,self.onNewGameYear)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.home_event,self.onHomeEvent)
self.data={}
end


function shanMenDaZhenController:onLostConnection()

end


function shanMenDaZhenController:onReConnection(isInitPro)

end

function shanMenDaZhenController:onEnterWorld(world)
if world~=1 then
return
end

shanMenDaZhenController:refreshWorldDaZhenEffectShow(world)
end

function shanMenDaZhenController:onExitWorld(world)
if world~=1 then
return
end

shanMenDaZhenController:refreshWorldDaZhenEffectShow(world,true)
end



function shanMenDaZhenController:reqShanMenDaZhenPatch(patchValue)
socketManager:send_3_195(patchValue)
end


function shanMenDaZhenController:reqShanMenDaZhenRepair()
socketManager:send_3_196()
end


function shanMenDaZhenController:reqShanMenDaZhenChangeTeam(guidList)

local nowTeamDiZiGuidList=shanMenDaZhenModel:getShanMenDaZhenTeamDiziAllGuidList()or{}
local hasChange=false
for i,guid in ipairs(guidList)do
if not nowTeamDiZiGuidList[i]then
if guid~=0 and not mathHelper.compareInt64(guid,int64.new('0'))then
hasChange=true
break
end
else
if not mathHelper.compareInt64(guid,nowTeamDiZiGuidList[i])then
hasChange=true
break
end
end
end

if hasChange then
socketManager:send_3_197(#guidList,guidList)
end
end


function shanMenDaZhenController.recv_3_195(addShieldValue)
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local bdData=shanMenDaZhenModel:getShanMenBdData()
local daZhenLv=bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local maxShieldValue=daZhenLvCfg.shield
local newShieldValue=nowShieldValue+addShieldValue
if newShieldValue>maxShieldValue then
newShieldValue=maxShieldValue
end
shanMenDaZhenModel:setShanMenDaZhenShieldValue(newShieldValue)

UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','onClosePatchPanelMask')


shanMenDaZhenController:refreshDaZhenHUD()


shanMenDaZhenController:refreshWorldDaZhenEffectShow()


local patchParam=cfgHelper.getdef1(cfg_shanmendazhenconfig,'fix')
local singleCount=patchParam[1]
local itemId=patchParam[2][1][1]
local costNum=patchParam[2][1][2]
local needItemNum=math.ceil(addShieldValue/singleCount)*costNum
local itemName=itemsConfig.getItemName(itemId)
local actuallyAddValue=newShieldValue-nowShieldValue
local tipsStr=FMT.fmt("消耗{0}{1}恢复了{2}点大阵护盾值",mathHelper.formatNumber(needItemNum),itemName,actuallyAddValue)
UIManager.info(tipsStr)
end


function shanMenDaZhenController.recv_3_196()

local bdData=shanMenDaZhenModel:getShanMenBdData()
local daZhenLv=bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local maxShieldValue=daZhenLvCfg.shield
local repairRate=cfgHelper.getdef1(cfg_shanmendazhenconfig,'repair')
local repairValue=math.floor(maxShieldValue*repairRate/100)
local newShieldValue=nowShieldValue+repairValue
shanMenDaZhenModel:setShanMenDaZhenShieldValue(newShieldValue)


UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshBottomPanel')
UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshAttrPanel')
UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshDaZhenEffect')


shanMenDaZhenController:refreshDaZhenHUD()


shanMenDaZhenController:refreshWorldDaZhenEffectShow()


local costList=daZhenLvCfg.repair or{}
local itemListStr=""
for i,v in ipairs(costList)do
local itemId=v[1]
local count=v[2]
local itemName=itemsConfig.getItemName(itemId)
if i==1 then
itemListStr=FMT.fmt("{0}{1}",mathHelper.formatNumber(count),itemName)
else
itemListStr=FMT.fmt("{0}、{1}{2}",itemListStr,mathHelper.formatNumber(count),itemName)
end
end
local tipsStr=FMT.fmt("消耗{0}修复大阵",itemListStr)
UIManager.info(tipsStr)
end


function shanMenDaZhenController.recv_3_197(len,guidList)
shanMenDaZhenModel:setShanMenDaZhenTeamDiziList(len,guidList)


UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshTeamPanel',true)


shanMenDaZhenController:refreshDaZhenHUD()


shanMenDaZhenController:refreshWorldDaZhenEffectShow()

notifySystem:postNotify(notifyConfig.onShanMenDaZhenTeamChange)
end



function shanMenDaZhenController.on_building_event(eType,param1,param2,param3)
if eType==buildingEvent.levelUpComplete then
local ubdId=param2
local lastBuildLevel=param3
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData.build_id==SLG_SYSTEM_TYPE.eShanMen then

shanMenDaZhenModel:initLevelUpCostLookup()
local finishCallback=function()
shanMenDaZhenController:createBuildingModel()
shanMenDaZhenController:checkZongMenDaZhenEffectShow()

UIFullShanMenControl:showDaZhenLevelUpFinishWindow(lastBuildLevel)

shanmenController:req_shanmen_data()
end

if bdData.level>2 then
return finishCallback()
elseif bdData.level==2 then
shanmenController:changeShanMenModelShow(true)
shanMenDaZhenController:createBuildingModel(true)

local bt=cfgHelper.getdef1(cfg_shanmendazhenconfig,'firstLvUpAnimTreeId')
if bt then
storyAIManager:startStoryBehavior(bt,nil,finishCallback)
else
return finishCallback()
end
end
end
elseif eType==buildingEvent.levelUpStart then
local ubdId=param2
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData.build_id==SLG_SYSTEM_TYPE.eShanMen and bdData.level==1 then
shanmenController:changeShanMenModelShow(false)
end
end
end

function shanMenDaZhenController.onNewGameYear(isLogin)

if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return
end


if not shanMenDaZhenModel:checkHaveShanmenDaZhen()then
return
end










local state=shanMenDaZhenModel:getDaZhenState()
if state==2 then
shanMenDaZhenController:addDaZhenShieldByNewGameYear()
end
end

function shanMenDaZhenController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eShanMenDaZhen then
shanMenDaZhenController:refreshDaZhenHUD()
shanMenDaZhenController:refreshWorldDaZhenEffectShow()
end
end

function shanMenDaZhenController.onSystemZMFightRecordNew(serial,teamIndex)

shanMenDaZhenController:refreshDaZhenRecordReddot()
end

function shanMenDaZhenController.onMoneyChange(moneyType,lastVal,val)
if shanMenDaZhenModel:checkIsDaZhenLevelUpItem(moneyType)then

UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshBottomPanel')


shanMenDaZhenController:refreshDaZhenHUD()
end
end

function shanMenDaZhenController.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if shanMenDaZhenModel:checkIsDaZhenLevelUpItem(itemid)then

UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshBottomPanel')


shanMenDaZhenController:refreshDaZhenHUD()
end
end

function shanMenDaZhenController.onHomeEvent(etype,args1,args2)
if etype==homeEvent.eEnterHome then
shanMenDaZhenController:createBuildingModel()
shanMenDaZhenController:checkZongMenDaZhenEffectShow()
elseif etype==homeEvent.eLeaveHome then
shanMenDaZhenController:removeBuildingModel()
shanMenDaZhenController:removeZongMenDaZhenEffect()
end
end

function shanMenDaZhenController:addDaZhenShieldByNewGameYear()
local bdData=shanMenDaZhenModel:getShanMenBdData()
local daZhenLv=bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local maxShieldValue=daZhenLvCfg.shield
local newShieldValue=nowShieldValue+daZhenLvCfg.recover
if newShieldValue>maxShieldValue then
newShieldValue=maxShieldValue
end

shanMenDaZhenModel:setShanMenDaZhenShieldValue(newShieldValue)


UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshBottomPanel')


shanMenDaZhenController:refreshDaZhenHUD()
end

function shanMenDaZhenController:refreshDaZhenHUD()
local bdData=shanMenDaZhenModel:getShanMenBdData()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function shanMenDaZhenController:refreshDaZhenRecordReddot()

UIManager:invokeUIMethod('UIShanMenDaZhen_mainWin','refreshRecordBtn')


shanMenDaZhenController:refreshDaZhenHUD()
end

function shanMenDaZhenController:refreshWorldDaZhenEffectShow(world,isClear)
local isInWorld=worldController:isInWorld()
if world or isInWorld then
local worldId=world or worldModel.world
if worldId~=1 then
return
end


if not shanMenDaZhenModel:checkHaveShanmenDaZhen()then
return
end


local state=shanMenDaZhenModel:getDaZhenState()
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.SCENERY,worldId})
local effectId=20212
if isClear or state==3 then

if self.data.isShowWorldDaZhenEffect then
worldController:stopModelEffect(unitKey,effectId)
self.data.isShowWorldDaZhenEffect=nil
end
elseif state==1 or state==2 then

if not self.data.isShowWorldDaZhenEffect then

worldController:playModelEffect(unitKey,effectId,Vector3.zero,Vector3.New(2,2,2),nil,true)
self.data.isShowWorldDaZhenEffect=true
end
end
end
end

function shanMenDaZhenController:createBuildingModel(isFirst)
if not mainControl:isSceneType(eSceneType.eZongmen)then
return
end


if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return
end


local bdData=shanMenDaZhenModel:getShanMenBdData()
if not bdData or bdData.level<2 then
return
end
local buildModelId=isFirst and 510481 or 510482
if not self.data.shanMenBdModelData then
local pos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
local entity=isometricMapSystem:createModelEntity(buildModelId)
_MapManager.SetPosition(entity.GUID,pos)
self.data.shanMenBdModelData={entityId=entity.GUID,buildModelId=buildModelId}
elseif self.data.shanMenBdModelData.buildModelId~=buildModelId then
local entity=_EntityManager:GetEntity(self.data.shanMenBdModelData.entityId)
entity:ChangeBody(buildModelId,{},false,1)
self.data.shanMenBdModelData.buildModelId=buildModelId
end
end

function shanMenDaZhenController:removeBuildingModel()
if not self.data.shanMenBdModelData then return end
local entityId=self.data.shanMenBdModelData.entityId
_EntityManager:RemoveEntity(entityId)
self.data.shanMenBdModelData=nil
end

function shanMenDaZhenController:setBuildingModelShow(isShow)
if not self.data.shanMenBdModelData then return end
local entityId=self.data.shanMenBdModelData.entityId
local entity=_EntityManager:GetEntity(entityId)
entity:SetVisible(isShow)
end

function shanMenDaZhenController:getAnimModelEntity()
if not self.data.shanMenBdModelData or not self.data.shanMenBdModelData.animEntityId then
return
end
local entity=_EntityManager:GetEntity(self.data.shanMenBdModelData.animEntityId)
return entity
end
function shanMenDaZhenController:clearAnimModelEntity()
if not self.data.shanMenBdModelData or not self.data.shanMenBdModelData.animEntityId then
return
end
local entityId=self.data.shanMenBdModelData.animEntityId
_EntityManager:RemoveEntity(entityId)
self.data.shanMenBdModelData.animEntityId=nil
end

function shanMenDaZhenController:playChangeBuildingModelAnim()
if not self.data.shanMenBdModelData then
self:createBuildingModel(true)
end
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildEntity_build=_EntityManager:GetEntity(bdData.entityId)
local buildPos=buildEntity_build:GetPosition()
local animModelId=5399
local pos=Vector3(buildPos.x-4.983,buildPos.y-1.252,buildPos.z)
local entity=_EntityManager:AddEntity(animModelId,{},SortingLayers.ITGrid2,0.85,false)
self.data.shanMenBdModelData.animEntityId=entity.GUID
entity:SetVisible(false)
entity:SetAnimatorSpeed(0)
entity:SetPosition(pos)

return shanMenDaZhenController:playChangeBuildingModelAnim_delayShow()
end

function shanMenDaZhenController:playChangeBuildingModelAnim_delayShow()
local delayTime=0.1
shanMenDaZhenController:createBuildingModel()
shanMenDaZhenController:clearDelayStartTimer()
self.delayStartTimer=timer.new()
self.delayStartTimer:start(delayTime,function()
if not mainControl:isSceneType(eSceneType.eZongmen)then
return
end
local ent=shanMenDaZhenController:getAnimModelEntity()
if not ent then
return
end
ent:SetVisible(true)
shanMenDaZhenController:setBuildingModelShow(false)
ent:RunAnimator(2196,1,function()
shanMenDaZhenController:setBuildingModelShow(true)
ent:StopAnimator(2196,1)
shanMenDaZhenController:clearAnimModelEntity()
return shanMenDaZhenController:clearDelayStartTimer()
end)
end,1)
end

function shanMenDaZhenController:clearDelayStartTimer()
if self.delayStartTimer~=nil then
self.delayStartTimer:cancel()
self.delayStartTimer=nil
end
end


function shanMenDaZhenController:checkZongMenDaZhenEffectShow()
if not mainControl:isSceneType(eSceneType.eZongmen)then
return
end


if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return
end


local bdData=shanMenDaZhenModel:getShanMenBdData()
if not bdData or bdData.level<2 then
return
end






end


function shanMenDaZhenController:removeZongMenDaZhenEffect()
if self.data.daZhenEffectHandleId then
local handleId=self.data.daZhenEffectHandleId
stopEffect(handleId)
self.data.daZhenEffectHandleId=nil
end
end
