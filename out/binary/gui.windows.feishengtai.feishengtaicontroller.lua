







FeiShengTaiController=gameState.addListener({})

local tiziUp=nil

function FeiShengTaiController:onAppStart()
socketManager:register_receiver(3,151,self.recv_3_151)
FeiShengTaiController:onAppStart_jiuchongtianjie()
end

function FeiShengTaiController:onEnterState()
FeiShengTaiModel:init_data()
FeiShengTaiController:onEnterState_jiuchongtianjie()

end

function FeiShengTaiController:onLeaveState()
FeiShengTaiController:onLeaveState_jiuchongtianjie()

end

function FeiShengTaiController:onPlayerCreate(...)

end

function FeiShengTaiController:onLostConnection()

end

function FeiShengTaiController:onProtocolReq(isReconnet)
FeiShengTaiController:onProtocolReq_jiuchongtianjie(isReconnet)
end




function FeiShengTaiController.sendJingJieBroke(guid,huDaoFuItemId)
local itemId=huDaoFuItemId or 0
socketManager:send_3_151(guid,itemId)
end





function FeiShengTaiController.recv_3_151(guid,res)
local netData=UIDiscipleModel:getDiscipleData(guid)
netData.jingjieBrokeLock=nil
local jjlv=netData.jingjielv

local needPlayerAnim=UIDiscipleModel:checkJJBrokeNeedUseFeiShengTai(jjlv)
if res==0 or res==1 then
if needPlayerAnim then
if fullScreenUI.checkFull(UIFullFeiShengTaiControl)then
UIFullFeiShengTaiControl:closeUI()
end
FeiShengTaiModel:setLightningResult(res==0)
FeiShengTaiModel:initLightningDiscipleBlood(guid)
FeiShengTaiModel:initLightningTimes()
FeiShengTaiController:startLightning(guid)
end
notifySystem:postNotify(notifyConfig.onDiscipleJJBroke,guid,res,jjlv)
elseif res==2 then
elseif res==3 then
end
end



function FeiShengTaiController:startLightning(guid)


local lightningTimes=FeiShengTaiModel:getLightningTotalTimes()
FeiShengTaiModel:setLightningDisciple(tonumber(tostring(guid)))
local bt=discipleStateManager:switchBT(guid,eBtState.duJie)
bt:setSharedVar('dujie',1)
bt:setSharedVar('lightningTimes',lightningTimes or 0)
end

function FeiShengTaiController:playFeiShengTaiUpAnim()
local map=mapIdType.zhufeng
surfaceControl:setSurfacePartActive(surfacePartIndex.feishengtai_0,map,true)
surfaceControl:setAnimatorInteger(surfacePartIndex.feishengtai_0,map,'up',1)
end

function FeiShengTaiController:playFeiShengTaiDownAnim()
local map=zongmenModel:getMountainId()
surfaceControl:setAnimatorInteger(surfacePartIndex.feishengtai_0,map,'up',2)
end

function FeiShengTaiController:postDiscipleDujieFinish()
notifySystem:postNotify(notifyConfig.onDiscipleDujieFinish,FeiShengTaiModel:getLightningDisciple(),FeiShengTaiModel:getLightningResult())
end

function FeiShengTaiController:showEffectWin()





UIManager:showWindow("UIFeiShengTaiPassWin")
UIManager:showWindow("UIFeiShengTaiEffectWin")
end

function FeiShengTaiController:setEffectId(id,index)
UIManager:invokeUIMethod("UIFeiShengTaiEffectWin","playEffect",id,index)
end

function FeiShengTaiController:setCameraEffectId(id)
UIManager:invokeUIMethod("UIFeiShengTaiEffectWin","playCameraEffect",id)
end

function FeiShengTaiController:moveEntity()
local speed=4
local targetPos=Vector3(-17.5,-8,0)
local bt,stId=FeiShengTaiModel:getId()
local tran=_MapManager.GetTilemapObjectTransform(stId)

local mpos=tran.position
local dis=Vector3.Distance(targetPos,mpos)
local duration=dis/speed

self.tweener=_DOTweenProxy.DOMove(tran,targetPos,duration)
self.tweener:SetEase(_Ease.Linear)

self.tweener:OnComplete(function(...)
FeiShengTaiController:closeDuJieFeiSheng()
end)
end

function FeiShengTaiController:closeDuJieFeiSheng()




UIManager:closeWindow("UIFeiShengTaiPassWin")
UIManager:closeWindow("UIFeiShengTaiEffectWin")



local bt,stId,alphaId=FeiShengTaiModel:getId()
local effectguid=FeiShengTaiModel:getEffectId()
if bt then
behaviorManager:removeBehaviorTree(bt)
end

if stId then
_EntityManager:RemoveEntity(stId)
end

if alphaId and alphaId.GUID then
_EntityManager:RemoveEntity(alphaId.GUID)
end

if effectguid then
_stopEffect(effectguid)
end

self:showSuccessWin()


AudioManager.setPauseBGMusic(false)
end

function FeiShengTaiController:showSuccessWin()
local data=FeiShengTaiModel:getDzOldData()
if data then
local guid=data.guid
local attrlist=data.attrlist
local args={
guid=guid,
attrlist=attrlist,
}

UIManager:showWindow("UIFeiShengShowWin",args)
end
end

function FeiShengTaiController:playSuccessAudio()
local data=FeiShengTaiModel:getDzOldData()
roleAudioController:playRoleSpeak(data.guid,roleAudioNodeType.JingJieTiSheng_succes)
end

function FeiShengTaiController:setBuildLightStateDIY(light,R,G,B,A,Time)

buildlightController:SetBuildBrightness(true,light,Color.New(R,G,B,A),Time)
end

function FeiShengTaiController:creatEntity()
local AlphaId=isometricMapSystem:createModelEntity(21000)

AlphaId:SetPosition(Vector3.New(-18,-17,0))
FeiShengTaiModel:setAlphaIdId(AlphaId)
end

function FeiShengTaiController:controlBuildLight(bdId,enable)
local data=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,bdId)
local entityId=data.entityId
local Entity=_EntityManager:GetEntity(entityId)
Entity:EnableLight(enable)
end