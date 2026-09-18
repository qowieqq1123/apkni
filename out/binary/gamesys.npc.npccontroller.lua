












local _MODULENAME="npcController"
gameState.addListener(def_table(_MODULENAME))
npcController.name=_MODULENAME

local isInit
local rewarListTemp

function npcController:onAppStart()
socketManager:register_receiver(22,1,npcController.do_protocol_22_1)
socketManager:register_receiver(22,2,npcController.do_protocol_22_2)
socketManager:register_receiver(22,3,npcController.do_protocol_22_3)
socketManager:register_receiver(22,4,npcController.do_protocol_22_4)
socketManager:register_receiver(22,5,npcController.do_protocol_22_5)
socketManager:register_receiver(22,6,npcController.do_protocol_22_6)
socketManager:register_receiver(22,7,npcController.do_protocol_22_7)
socketManager:register_receiver(22,8,npcController.do_protocol_22_8)

socketManager:register_receiver(22,9,npcController.do_protocol_22_9)
socketManager:register_receiver(22,10,npcController.do_protocol_22_10)
socketManager:register_receiver(22,11,npcController.do_protocol_22_11)

notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)

worldController:registerSceneState(worldModel.ON_SCENE_STATE.ENTER,4,function()
npcController:onEnterWorld(worldModel.world)
end)
worldController:registerSceneState(worldModel.ON_SCENE_STATE.EXIT,4,function()
npcController:onLeaveWorld()
end)

end

function npcController:onEnterState()
npcModel:initData()
notifySystem:listenNotify(notifyConfig.onShowPrize,npcController.onShowPrize)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,npcController.onClickWorldNPC)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,npcController.onWorldPositionReRandom)

end

function npcController:onLeaveState()
npcModel:clearData()
isInit=nil
rewarListTemp=nil
notifySystem:removelistener(notifyConfig.onShowPrize,npcController.onShowPrize)
notifySystem:removelistener(notifyConfig.onClickObjectInWorld,npcController.onClickWorldNPC)
notifySystem:removelistener(notifyConfig.onWorldPositionReRandom,npcController.onWorldPositionReRandom)
end

function npcController:onPlayerCreate(...)

end

function npcController:onProtocolReq()

end

function npcController:onLostConnection()

end

function npcController:checkInit()
return isInit==true
end

function npcController:setTempReward(temp)
rewarListTemp=temp
end

function npcController:getTempRewad()
return rewarListTemp
end

function npcController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.NPC then
local guid=int64.new(rData.key)
local npcData=npcModel:findNPCByPosGuid(guid)
local posVector=npcData.posVector

local worldid=posVector.worldid
local blockid=posVector.blockid
local posCfg=cfgHelper.get2(cfg_npcworldposconfig_get,worldid,blockid)
local libs=posCfg.poslist
local check,temp=worldPositionLibrary:extract(libs)
local x,z,flip,valid
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
valid=true
else
x=0
z=0
flip=false
valid=false
end
posVector.flip=flip
posVector.side=flip==true and 0 or 1
posVector.pos=worldPositionConfig:getPosition(worldid,{x,z})
worldPositionLibrary:eraseData(guid)
if valid then
worldPositionLibrary:markData(worldid,x,z,flip,eWorldUnitTpye.NPC,guid)
end
local unitKey=FMT.fmt('{0}_{1}',eWorldUnitTpye.NPC,npcData.npcid)
worldTaskModel:changeTaskTargetDestination(unitKey)
if worldController:isInWorld()and worldModel:isSameWorld(worldid)then
worldController:setUnitFlipX(unitKey,posVector.flip)
worldController:setUnitPosition(unitKey,posVector.pos)
end
end
end








function npcController.onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eNPCInteract or prizeType==ePrizeType.eNPCIntimacyReward then
npcController:setTempReward(temp)
end
end

function npcController.onClickWorldNPC(args)
if(args and args[1]==eWorldUnitTpye.NPC)then
local npcid=args[2]
npcController:onClickNPC(npcid)
end
end

function npcController:onClickNPC(npcid)
if not npcController.checkNPCOpen()then
local desc=npcModel:getNPCClickTalk(npcid)
local imageCfg=npcModel:getNPCImageCfg(npcid)
local image=npcModel:getImageInfo(imageCfg.id)
local args={
showblack=true,
blackAlpha=1,
isFullOpen=false,
talk=desc,
model={
body=image.body,
componets=image.componets,
anim=eAnimationID.stand,
scale=1,
},
}
UIFullStoryBoardControl:showPlotBoardWindow5(args,false)
return
end

AudioManager.playBtnClick()
npcController:showWorldEntityStage(npcid)
UIManager:invokeUIMethod('UIWorldNPCListWin','refreshSelectNPC',npcid)
end

function npcController.showIntimacyChange()
local lerp=npcModel:getIntimacyChangeRecord()
if lerp==0 then return end
if lerp>0 then
UIManager.info(FMT.fmt('亲密度 +{0}',lerp))
else
UIManager.info(FMT.fmt('亲密度 {0}',lerp))
end
end

function npcController.checkNPCOpen(isWarning)
local flag=systemModel.isOpen(SYSTEM_DEFINE.eNPCOpen)
if not flag then
if isWarning then
local desc=systemModel.getOpenTips(SYSTEM_DEFINE.eNPCOpen,'对方拒绝接见（','）')
desc=string.replace(desc,'达到','需')
UIManager.error(desc)
end
end
return flag
end















function npcController:askforNPC_test(npcid)
npcController:askforNPCBack(npcid,int64.new('0'))
end

function npcController:askforNPC(npcid,otherData)
local interacttype=otherData.interacttype
if not npcModel:checkInteractTypeEnough(npcid,interacttype,true)then
return
end

npcController:reqInteract(npcid,otherData)
end

function npcController:askforNPCBack(npcid,itemguid)
local issuccess=false
if tostring(itemguid)~='0'then
npcModel:refrescNPCAskfor(npcid,itemguid)
issuccess=true
end

local func=function()

if issuccess then
UIManager.info('对方答应你的请求')
else
UIManager.info('对应拒绝了你的请求')
end

UIManager:invokeUIMethod('UINPCInteractWin','rec_askfor')

local func3=function()

local str=npcModel:getNPCAskforTalk(npcid,issuccess)or''
npcController:worldInteractNPCTalk(str,5)

npcController.showIntimacyChange()
end

local func2=function()
local goodlist=npcController:getTempRewad()
if goodlist~=nil and#goodlist>0 then
local goodlist_=table.deepCopy(goodlist)
showPrizeControl.showWindow(goodlist_,func3)
else
func3()
end
end
timeEventController.delayDo(0.5,func2)
end
UIManager:invokeUIMethod('UINPCInteractWin','beginAskfor','考虑中',3,func,nil)

npcController:worldInteractNPCEmot(34,11,3)

UIManager:invokeUIMethod('UINPCInteractWin','showMaskBlock',3)
end




function npcController:stealNPC_test(npcid,injury)
npcController:stealNPCBack(npcid,int64.new('0'),injury or 0)
end

function npcController:stealNPC(npcid,otherData)
local interacttype=otherData.interacttype
if not npcModel:checkInteractTypeEnough(npcid,interacttype,true)then
return
end

npcController:reqInteract(npcid,otherData)
end

function npcController:stealNPCBack(npcid,itemguid,injury)
local issuccess=false
local ishit=false
if tostring(itemguid)~='0'then
npcModel:refrescNPCAskfor(npcid,itemguid)
issuccess=true
else
if injury>0 then
ishit=true
end
end
local time=3

local func_end=function()

if issuccess then
UIManager.info('窃取成功')
else

end

UIManager:invokeUIMethod('UINPCInteractWin','rec_askfor')

local func3=function()

if not issuccess then
local str
if not ishit then
str=npcModel:getNPCStealTalk(npcid)or''
npcController:worldInteractDZEmot(8,3,2)
else
str=npcModel:getNPCStealHitTalk(npcid)or''
end
npcController:worldInteractNPCTalk(str,5)
end

npcController.showIntimacyChange()
end

local func2=function()
local goodlist=npcController:getTempRewad()
if goodlist~=nil and#goodlist>0 then
local goodlist_=table.deepCopy(goodlist)
showPrizeControl.showWindow(goodlist_,func3)
else
func3()
end
end
timeEventController.delayDo(0.5,func2)
end
local func_lost=function()
local d
if not ishit then

npcController:worldInteractNPCEmot(12,2,1)
d=1
else

npcController:worldInteractNPCEmot(12,2,1)
local func4=function()
npcController:worldInteractNPCHit(2,3,injury)
end
timeEventController.delayDo(1.5,func4)
d=3.5
end
timeEventController.delayDo(d,func_end)
end
if issuccess then
UIManager:invokeUIMethod('UINPCInteractWin','beginAskfor','窃取中',time,func_end,nil)
else
UIManager:invokeUIMethod('UINPCInteractWin','beginAskfor','窃取中',time,func_lost,nil)
end

local lock_time
if not issuccess then
if not ishit then
lock_time=4.5
else
lock_time=6.5
end
else
lock_time=3.5
end
UIManager:invokeUIMethod('UINPCInteractWin','showMaskBlock',lock_time)
end


local openRightMark=nil
function npcController:doReqFight_after(npcid)
if npcController.stayBattleTime~=nil then return end
local str=npcModel:getNPCFightTalkAfter(npcid)
npcController:worldInteractNPCTalk(str,2)
npcController.stayBattleTime=timeEventController.delayDo(1.5,function()
npcController.stayBattleTime=nil
npcController:doReqFight(npcid)
end)
end

function npcController:doReqFight(npcid)
if UIManager:isActive('UIWorldNPCListWin')then
openRightMark=true
else
openRightMark=nil
end


local npcItemData=npcModel:getNPCItemData(npcid)
local mapId=npcController:getNPCBattleMapId(npcItemData.npcData)
local monsterGroupId=npcModel:getNPCFightGroup(npcid)
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local monsterList=groupcfg.monList
local extraWin='UIFightPrepareDescWin'
local extraParams={}
local desclist={}
table.insert(desclist,cfgHelper.getlang('npc_battle_tips_1'))
table.insert(desclist,cfgHelper.getlang('npc_battle_tips_2'))
extraParams.desclist=desclist
local jjlv=groupcfg.level
extraParams.tips_str=FMT.fmt('仙友境界修为：<color=#F1CE78>{0}</color>',UIDiscipleModel.getJJNameCommon(jjlv,3))
local winArgs=
{
enterCallBack=function(selectList,zfId)
local npcItemData=npcModel:getNPCItemData(npcid)
if npcItemData then
local npctype=npcItemData.npcData.npctype
fightLaunchController:sendFight(eBattleLaunch.npcPK,selectList,mapId,zfId,{npctype,npcid})
else
UIManager.error('切磋对象已离去')
end
end,
enterTxt="切磋",
cancelCallBack=function()
npcController:finishFightOpenNPC(npcid)
local func=function()
local str=npcModel:getNPCFightTalkNone(npcid)
npcController:worldInteractNPCTalk(str,3)
end
timeEventController.delayDo(1,func)
end,
mapId=mapId,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
extraWin=extraWin,
extraParams=extraParams,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.npcPK,winArgs,function()
worldController:displaySymbol(false)
worldController:displayHUD(false)
end)
end

function npcController:finishFightOpenNPC(npcid)
local func=function()
if openRightMark then
openRightMark=nil
if not fullScreenUI.isActiveFull()and worldController:isInWorld()then
npcController:showWorldEntityStage(npcid,false)
worldController:changeLeftView('UIWorldUnitListWin2',{tab=5})
end
else
if not fullScreenUI.isActiveFull()and worldController:isInWorld()then
npcController:showWorldEntityStage(npcid,false)
end
end
end
timeEventController.delayDo(0.1,func)
end

function npcController:finishFight(npcid,result)
npcController:finishFightOpenNPC(npcid)
local func=function()
local str=npcModel:getNPCFightTalkResult(npcid,result)
npcController:worldInteractNPCTalk(str,3)
end
timeEventController.delayDo(1,func)
end






function npcController:reqNPCInfo()
socketManager:send_22_1()
end


function npcController:reqInteract(npcid,otherData)



local npcItemData=npcModel:getNPCItemData(npcid)
if npcItemData==nil then return end

local interacttype=otherData.interacttype
local sendHandle=npcController:getSendHandle(interacttype)
if sendHandle then
npcController:setTempReward(nil)
local data=sendHandle(otherData)
local npctype=npcItemData.npcData.npctype
socketManager:send_22_2(npctype,npcid,data)
end
end



function npcController:reqChangeInteractDZ(discipleguid)

socketManager:send_22_3(discipleguid)
end


function npcController:reqIntimacyReward(npcid,id)


local hgdlv=id
local rewards=npcModel:getIntimacyReward(npcid,hgdlv)
local typo=rewards[1]

local func=function()
npcController:setTempReward(nil)
socketManager:send_22_8(npcid,id)
end
if typo==npcIntimacyRewardType.eGame then
local info=rewards[3]
local gameType=info[1]
local mapid=info[2]
local groupid=info[3]
local groupid_lose=info[5]
local gamecb=function(resultLV)
if resultLV>0 then
func()
else
gameplotController:showPlotBoard({groupid=groupid_lose,isFullOpen=false})
end
end

local func2=function()
UILittleGameController:openLittleGame(gameType,{mapId=mapid},gamecb)
end
gameplotController:showPlotBoard({groupid=groupid,callback=func2,isFullOpen=false})
else
func()
end
end






function npcController.do_protocol_22_1(datalistlen,dataList,npclistlen,npcList,discipleguid)






























if worldController:isInWorld()then
npcController:clearWorldNPCEntity()
end

isInit=true
npcModel:initNPCDataList(dataList)
npcModel:initNPCList(npcList)
npcModel:initInteractDZ(discipleguid)

if worldController:isInWorld()then
npcController:initWorldNPCEntity(worldModel.world)
end
end


function npcController.do_protocol_22_2(npctype,npcid,intimacy,interacttimes,otherData)








local interacttype=otherData.interacttype
npcModel:setNPCIntimacy(npcid,intimacy)
npcModel:refreshNPCItemData(npcid,interacttype,interacttimes)
local recHandle=npcController:getRecvHandle(interacttype)
if recHandle then
recHandle(npcid,otherData)
end
end


function npcController.do_protocol_22_3(discipleguid)


npcModel:initInteractDZ(discipleguid)
npcController:rebuildWorldInteractNPCDZ()
notifySystem:postNotify(notifyConfig.onChangeInteractNPCDZ)
end


function npcController.do_protocol_22_4(npclistlen,npcList)


if worldController:isInWorld()then
npcController:clearWorldNPCEntity()
end

npcModel:initNPCList(npcList)

if worldController:isInWorld()then
npcController:initWorldNPCEntity(worldModel.world)
end
end


function npcController.do_protocol_22_5(npcItemData)


local isNew=npcModel:refreshNPCItemData3(npcItemData)
if isNew then
npcController:newWorldNPCEntity(npcItemData,worldModel.world)
UIManager:invokeUIMethod('UIWorldNPCListWin','refreshAllItem')
end
end


function npcController.do_protocol_22_6(npcid,intimacy)



npcModel:setNPCIntimacy(npcid,intimacy)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eNPCOpen)
notifySystem:postNotify(notifyConfig.on_UIWorldWin_infoBtn_reddotChange)
end


function npcController.do_protocol_22_7(npctype,npcid)



local flag=npcModel:removeNPCItemData(npcid)
if npcController.worldNPCEntityLookup then
local npcEntity=npcController.worldNPCEntityLookup[npcid]
if npcEntity then
worldController:popUnit(npcEntity.unitKey)
end
end
if flag then
UIManager:invokeUIMethod('UIWorldNPCListWin','refreshAllItem')
end
end


function npcController.do_protocol_22_8(npcid,id)


local hgdlv=id
npcModel:setNPCIntimacyRewardFlag(npcid,hgdlv)

local func=function()
local goodlist=npcController:getTempRewad()
if goodlist~=nil and#goodlist>0 then
local goodlist_=table.deepCopy(goodlist)
showPrizeControl.showWindow(goodlist_,nil)
end
end
local rewards=npcModel:getIntimacyReward(npcid,hgdlv)
local talkid=npcModel.getIntimacyRewardResultTalk(rewards)
if talkid~=nil and talkid>0 then
gameplotController:showPlotBoard({groupid=talkid,callback=func,isFullOpen=false})
else
func()
end

UIManager:invokeUIMethod('UINPCInteractWin','recv_reward',npcid)
UIManager:invokeUIMethod('UINPCIntimacyRewardWin','recv_reward',npcid,id)
UIManager:invokeUIMethod('UIXianZhanInteractWin','recv_reward',npcid)

local roomId=xianzhanModel:getNPCRoom(npcid)
if roomId then
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomNPC',roomId)
xianzhanController:refreshXianZhanBuildHud()
end

notifySystem:postNotify(notifyConfig.onNPCIntimacyReward,npcid)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eNPCOpen)
notifySystem:postNotify(notifyConfig.on_UIWorldWin_infoBtn_reddotChange)
end



function npcController.do_protocol_22_9(len,npcList)
if len>0 then
for i,v in ipairs(npcList)do
emergenciesControl_HuiJuan:setNPCData(v.param_1,v.param_2,v.param_3)
end
if mainControl:isInScene(eSceneType.eZongmen)then
emergenciesControl_HuiJuan:initNPC()
end
end
end

function npcController.do_protocol_22_10(len,recvList)
if len>0 then
local isZongMen=mainControl:isInScene(eSceneType.eZongmen)
for i,v in ipairs(recvList)do
emergenciesControl_HuiJuan:removeNPCData(v)
if isZongMen then
emergenciesControl_HuiJuan:removeHuiJuan(v)
end
end
end
end

function npcController.do_protocol_22_11(subId,endTime)
emergenciesControl_HuiJuan:updateNPCEndTime(subId,endTime)
local now=timeHelper.getServerShortTime()
if now>=endTime then
if mainControl:isInScene(eSceneType.eZongmen)then
emergenciesControl_HuiJuan:removeHuiJuan(subId)
end
end
end
function npcController.onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
emergenciesControl_HuiJuan:initNPC()
elseif etype==homeEvent.eLeaveHome then
emergenciesControl_HuiJuan:clearHuiJuan()
end
end