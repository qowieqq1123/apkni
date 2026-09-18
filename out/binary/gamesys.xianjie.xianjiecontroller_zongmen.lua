function xianjieController:onAppStart_zongmen()

socketManager:register_receiver(35,8,xianjieController.recv_protocol_35_8)
socketManager:register_receiver(35,9,xianjieController.recv_protocol_35_9)


socketManager:register_receiver(35,153,xianjieController.recv_protocol_35_153)
socketManager:register_receiver(35,154,xianjieController.recv_protocol_35_154)


socketManager:register_receiver(35,141,xianjieController.recv_protocol_35_141)
socketManager:register_receiver(35,142,xianjieController.recv_protocol_35_142)
end

function xianjieController:onEnterState_zongmen(isReconnet)
xianjieModel:clearData_AttackList()

notifySystem:listenNotify(notifyConfig.onXianJieSceneStateChange,self.onXianJieSceneStateChange)
notifySystem:listenNotify(notifyConfig.onXianJieBuffFresh,self.onXianJieBuffFresh_zongmen)
notifySystem:listenNotify(notifyConfig.onXianJieEntityDataChange,self.onXianJieEntityDataChange_zongmen)
end

function xianjieController:onLeaveState_zongmen(isReconnet)
xianjieModel:clearData_AttackList()

notifySystem:removelistener(notifyConfig.onXianJieSceneStateChange,self.onXianJieSceneStateChange)
notifySystem:removelistener(notifyConfig.onXianJieBuffFresh,self.onXianJieBuffFresh_zongmen)
notifySystem:removelistener(notifyConfig.onXianJieEntityDataChange,self.onXianJieEntityDataChange_zongmen)
end

function xianjieController:onEnterMap_zongmen()
xianjieController:reqMyAttackerList()
end


function xianjieController.recv_protocol_35_8(len,myAttackerIDList)

end

function xianjieController.recv_protocol_35_9(len,attackList)



end


function xianjieController.recv_protocol_35_153(len,myAttackerIDList)

end

function xianjieController.recv_protocol_35_154(len,attackList)



end













function xianjieController.recv_protocol_35_141(attacklistlen,attackList,is_login)
xianjieModel:setAttackerNotifyList(attacklistlen,attackList,is_login)
end




function xianjieController.recv_protocol_35_142(flattacklistlen,flattacklist)
xianjieModel:setAttackList(flattacklist)
UIManager:invokeUIMethod('UIXianJie_ZongMenAttackerWin','onRecvUpdate')
end

function xianjieController:onAddZongmenTianShuDaZhen(entityData,sec)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
if timeHelper.getServerShortTime()<sec then
local left=sec-timeHelper.getServerShortTime()
entity:playFangHuZhaoEffect()
else
entity:stopFangHuZhaoEffect()
end
end

function xianjieController:onAddZongmenDisableTianShuDaZhen(entityData,sec)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
if timeHelper.getServerShortTime()<sec then
entity:playDisableFangHuZhaoEffect()
else
entity:stopDisableFangHuZhaoEffect()
end
end

function xianjieController:onAddZongmenTianShuShenDun(entityData,sec)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
if timeHelper.getServerShortTime()<sec then
entity:playTianShuShenDunEffect()
else
entity:stopTianShuShenDunEffect()
end
end

function xianjieController:onAddZongmenZaieBuQin(entityData,sec)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
if timeHelper.getServerShortTime()<sec then
entity:playZaieBuQinEffect()
else
entity:stopZaieBuQinEffect()
end
end


function xianjieController:onAddBanMoveZongMenBuff(entityData,sec)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
if timeHelper.getServerShortTime()<sec then
entity:playBanMoveZongMenBuffEffect()
else
entity:stopBanMoveZongMenBuffEffect()
end
end

function xianjieController:onRefreshZongmenInvisibleEffect(entityData)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
local actorid=entityData.actorid
local isShow=xianjieModel:isZmInvisible(actorid)
if isShow then

entity:playInvisibleEffect(nil)
else
entity:stopInvisibleEffect(nil)
end
end

function xianjieController:onAddZongmenDisableInvisibleEffect(entityData,sec)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
if timeHelper.getServerShortTime()<sec then
entity:stopInvisibleEffect(nil,true)
else

entity:playInvisibleEffect(nil,true)
end
end


function xianjieController:onRefreshSkillPengLaiAddEffect(entityData)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
local actorid=entityData.actorid
local isShow=xianjieModel:isZmSkillPenglai(actorid)

if isShow then
entity:playSkillPengLaiEffect(nil)
else
entity:stopSkillPengLaiEffect(nil)
end
end

function xianjieController:onRefreshSkillAddIcon(entityData)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
local actorid=entityData.actorid
local isShow=xianjieModel:isZmSLSkillIcon(actorid)

if isShow then
entity:playSLSkillBuffIcon(nil)
else
entity:stopSLSkillBuffIcon(nil)
end
end

function xianjieController:onRefreshSkillJiuYuanAddEffect(entityData)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
local actorid=entityData.actorid
local isShow=xianjieModel:isZmSkillJiuYuan(actorid)

if isShow then
entity:playSkillJiuYuanEffect(nil)
else
entity:stopSkillJiuYuanEffect(nil)
end
end

function xianjieController:onRefreshSkillJiuYuanAddEffect2(entityData)
local entity=xianjieModel:getEntityByData(entityData)
if entity==nil then return end
local isShow=true

if isShow then
entity:playSkillJiuYuanEffect(nil)
else
entity:stopSkillJiuYuanEffect(nil)
end
end

function xianjieController:reqMyAttackerList(trigger)
if trigger then
self.isReqMyAttackerInfo=true
end
if self.isReqMyAttackerInfo and mainControl:isInScene(eSceneType.eXianJie)then
self.isReqMyAttackerInfo=nil
socketManager:send_35_9()
end
end

function xianjieController:reqMyAttackerList_MoJie(trigger)
if trigger then
self.isReqMyAttackerInfo=true
end
if self.isReqMyAttackerInfo and mainControl:isInScene(eSceneType.eXianJie)then
self.isReqMyAttackerInfo=nil
socketManager:send_35_154()
end
end

function xianjieController:reqAttackerList(trigger)
if trigger then
self.reqAttackerInfoFlag=true
end
if self.reqAttackerInfoFlag and UIManager:findActiveWindow("UIXianJie_ZongMenAttackerWin")then
self.reqAttackerInfoFlag=nil
socketManager:send_35_142()
end
end

function xianjieController.onXianJieSceneStateChange(stateType,isEnter)
if stateType==xjSceneStateType.eMoveZongMen then
xianguanController:refreshAOIZMEntityRangeGrids()
xianjieModel:post_XianJieSceneStateChangeToMonster(stateType,isEnter)
end
end

function xianjieController.onXianJieBuffFresh_zongmen(buffid)

local actorid=playerModel:getActorID()
local zmData=xianjieModel:getMyZongMenData()
if zmData and xianjieModel:hasBuffEffect(actorid,buffid)then
zmData:onInitExtraData()
zmData:refreshEntity()
local zmEntity=zmData.ent_key and xianjieController:getEntity(zmData.ent_key)
local hud=zmEntity and zmEntity:getHud()
if hud then
hud:refreshJobBuff()
end
end
end

function xianjieController.onXianJieEntityDataChange_zongmen(posTable,actorid)

xianguanController:refreshAOIZMEntityAndHUD(actorid)

xianjieController:refreshZMMoJunAreaEffect(actorid)
end
















