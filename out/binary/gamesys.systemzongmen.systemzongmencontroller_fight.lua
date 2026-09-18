
local _teamEntity={}
local _teamHUD={}
local _teamBt={}

local _teamSpeak={}
local _teamTimer=nil
local _kofModel=3
local _againSend_26_33_delay=10
local _againSend_26_33_list={}

local _NewDay5AMHandle={
[systemZongMenFightFlagType.eNone]=function(infoData,nowTime)
if infoData.sg_reward_num>0 then
local oldNum=infoData.sg_reward_num
infoData.sg_reward_num=0
notifySystem:postNotify(notifyConfig.onSystemZMVassalRewardChange,infoData.serial,oldNum,infoData.sg_reward_num)
end
end,
[systemZongMenFightFlagType.eBeAttacked]=function(infoData,nowTime)

end,
[systemZongMenFightFlagType.eAttacking]=function(infoData,nowTime)
if infoData.sg_reward_num>0 then
local oldNum=infoData.sg_reward_num
infoData.sg_reward_num=0
notifySystem:postNotify(notifyConfig.onSystemZMVassalRewardChange,infoData.serial,oldNum,infoData.sg_reward_num)
end
end,
[systemZongMenFightFlagType.eSurrender]=function(infoData,nowTime)

if infoData.end_time<nowTime then
systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eNone,0)
end
end,
[systemZongMenFightFlagType.eVassal]=function(infoData,nowTime)

local oldNum=infoData.sg_reward_num
infoData.sg_reward_num=oldNum+1
notifySystem:postNotify(notifyConfig.onSystemZMVassalRewardChange,infoData.serial,oldNum,infoData.sg_reward_num)

if infoData.end_time<nowTime then
systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eNone,0)
end
end,
[systemZongMenFightFlagType.eExpel]=function(infoData,nowTime)



end,
}

function systemZongMenController:showFightPrepare(infoData)
local defenseInfo=systemZongMenModel:getDefenseInfo(infoData.serial)
local teamList=defenseInfo.team
local monsterList={}
local count=fightPreSelectModel.maxPosNum*_kofModel
local maxTM=#cfg_discipletianminglevelconfig()
for index=1,_kofModel do
if monsterList[index]==nil then
monsterList[index]={}
end
for pos=1,fightPreSelectModel.maxPosNum do
local i=(index-1)*fightPreSelectModel.maxPosNum+pos
local discipleStruct=teamList[i]
if discipleStruct and discipleStruct.disciple_id>0 then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(discipleStruct.discipledata,discipleStruct.discipleimage)
discipleStruct.discipleweapon=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"syssectWeapon")
discipleStruct.tmlv=imageInfo.color>=eQualityColor.eOrange and maxTM or nil
table.insert(monsterList[index],{pos=pos,typo=fightEntityType.diZi,guid=discipleStruct.discipleguid,netData=discipleStruct})
end
end
end

local selectTeam=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.systemZongMenAttack,_kofModel)
for tIdx,tList in pairs(selectTeam)do
for guidStr,data in pairs(tList)do
local discipleguid=data[3]
if not UIDiscipleModel:checkDZStateToDoSomething(discipleguid,eCheckDiscipleStateOpType.eDispatch2)then
tList[guidStr]=nil
end
end
end

local allSmCfg=cfg_shanmendazhenconfig()
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local config=cfgHelper.get1(cfg_syssectconfig_get,infoData.id)
local params=config.dazhenLv or baseCfg.dzParams
local paramA=params[1]
local paramB=params[2]
local level=Mathf.Clamp(math.floor(infoData.level*paramA+paramB),0,#allSmCfg)
local smCfg=allSmCfg[level]
local sheildID=smCfg.hudunBar
local maxVal=smCfg.shield
local curVal=defenseInfo.value
local percent=curVal/maxVal*100

local args={
sheildParam=sheildID and{sheildID,false}or nil,
notNeedDealOverTime=true,
enterTxt="进攻",
isHomeBattle=false,
kofMode=_kofModel,
multipleMonsterListEx=monsterList,
multipleTeams=selectTeam,
extraWin="UISystemZongMenFightPrepareInfoWin",
extraParams={infoData=infoData,defenseInfo=defenseInfo},
cancelCallBack=function()
UIFullSystemZongMenControl:showMainWindow({serial=infoData.serial})
end,
enterCallBack=function(selectList,zfId)
local executeFunc=function()
if infoData.flag~=systemZongMenFightFlagType.eBeAttacked then
UIManager.error("攻打已结束")
UIManager:invokeUIMethod("UIFightPrepareWin","onCancelButton")
elseif(infoData.end_time-timeHelper.getServerShortTime())<=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"teamMoveTime",1)then
UIManager.error("剩余时间已不足派遣进攻队伍")
UIManager:invokeUIMethod("UIFightPrepareWin","onCancelButton")
else
local dzList=fightPreSelectModel.convertFightStruct2DiscipleMutli(selectList)
local commonFight=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"attackedMap")
local removes={}
for i=1,_kofModel do
local have=false
for j=1,fightPreSelectModel.maxPosNum do
local idx=(i-1)*fightPreSelectModel.maxPosNum+j
if mathHelper.validInt64(dzList[idx])then
have=true
break
end
end
if not have then
for j=1,fightPreSelectModel.maxPosNum do
local idx=(i-1)*fightPreSelectModel.maxPosNum+j
table.insert(removes,idx)
end
end
end
if#removes>0 then
table.sort(removes,function(a,b)return a>b end)
for i,v in ipairs(removes)do
table.remove(dzList,v)
end
end
systemZongMenController:req_send_attackTeam(infoData.serial,dzList,commonFight)
fightController:closeSelectStage(false)
UIFullFightPrepareControl:closeUI()
end
end

local executeFunc2=function()
if config.strengthIcon==1 then
UIDialogManager.getConfirmDialog3(nil,"该宗门实力强大，请做好准备",executeFunc,REPEAT_TYPE.eSystemZMStrength)
else
executeFunc()
end
end

local emptyList=fightPreSelectModel.getFightStructEmptyList(selectList,_kofModel)
local emptyCount=#emptyList
if emptyCount>=_kofModel then
UIManager.error("至少需要有一支弟子队伍")
elseif emptyCount>0 then
UIDialogManager.getCommonDialog(nil,"存在没有弟子的队伍，确认进攻？",executeFunc2)
else
executeFunc2()
end
end
}
fightController.showPrepareWin(fightPreSelectModel.fightType.systemZongMenAttack,args)
end

function systemZongMenController:onLXShowTick(nowTime)
local list=systemZongMenModel:getAllAttackInfo()
for serial_str,info in pairs(list)do
if not info.passShow and nowTime>=info.showStamp then
info.passShow=true
if mainControl:isInScene(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
self:createZongMenSceneEntity()
end
end
end
end

function systemZongMenController:onBattleSendTick(nowTime)
local list=systemZongMenModel:getAllBattleWaitResult()
for i,v in ipairs(list)do

if v.waitSend and v.gameStamp<nowTime then
v.waitSend=false
self:req_attack_team(v.serial,v.teamIndex,true)
end
end
end

function systemZongMenController:onBattleResultDelayTick(nowTime)
local list=systemZongMenModel:getAllWaitNotifyResult()
local deals={}
local duration=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"reportDuration")
for key,data in pairs(list)do
if nowTime>(data.timeStamp+duration)then
table.insert(deals,data.serial)
end
end
if#deals>0 then
local tasks=worldTaskModel:findAllFake_UnitType(eWorldUnitTpye.SYSTEMZM)
for idx,serial in ipairs(deals)do
self:popBattleResultNotify(serial)
end
notifySystem:postNotify(notifyConfig.onSystemZMFightRecordNew)
end
end

function systemZongMenController:changeSystemZongMenFlag(infoData,flag,start_time)
if infoData==nil or flag==nil then return end
if flag~=infoData.flag then

local oOutgoer=systemZongMenModel:checkFightFlagOutgoerShow(infoData.flag)

systemZongMenModel:deleteFightFlagLookup(infoData.serial,infoData.flag)

local oldFlag=infoData.flag
infoData.flag=flag
infoData.start_time=start_time or timeHelper.getServerShortTime()
infoData.end_time=systemZongMenModel:getFightFlagEndTime(infoData)

systemZongMenModel:checkAddFightFlagLookup(infoData)

if flag==systemZongMenFightFlagType.eBeAttacked then
local sgNum=infoData.sg_reward_num
if sgNum>0 then
infoData.sg_reward_num=0
notifySystem:postNotify(notifyConfig.onSystemZMVassalRewardChange,infoData.serial,sgNum,infoData.sg_reward_num)
end





end

local nOutgoer=systemZongMenModel:checkFightFlagOutgoerShow(infoData.flag)

local outgoers=systemZongMenModel:findOutgoerDataBySerial(infoData.serial)
if#outgoers>0 and oOutgoer~=nOutgoer then
if nOutgoer then
for i,v in ipairs(outgoers)do
local data=systemZongMenModel:getOutgoerDataImp(v)
if worldController:isInWorld()and worldModel:isSameWorld(data.world)then
self:createOutgoerEntity(data)
end
end
else
local same=systemZongMenController:isSceneBelongSystemZongMen(infoData.serial)
if same and not systemZongMenController:isOutgoerSceneDoing()then
systemZongMenController:closeOutgoerScene()
UIManager.info("宗门情况有变，外出弟子已迅速返回")
end

for i,v in ipairs(outgoers)do
local data=systemZongMenModel:getOutgoerDataImp(v)
if worldController:isInWorld()and worldModel:isSameWorld(data.world)then
self:deleteOutgoerEntity(data.discipleguid)
end
end
end
end

systemZongMenController:updateEntityModelByFightFlag(infoData.serial,oldFlag,infoData.flag)

local unitKey=systemZongMenModel:convertUnitKey(infoData.serial)
worldHUDModel:onUpdateHUD(unitKey)

if infoData.flag==systemZongMenFightFlagType.eAttacking then




systemZongMenModel:addBattleWaitResult(infoData.serial,0,infoData.end_time,infoData.start_time)
elseif oldFlag==systemZongMenFightFlagType.eAttacking then
if mainControl:isInScene(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
local temp=systemZongMenModel:findDefenseWaitNotifyResult()
if temp==nil then
self:deleteZongMenSceneEntity()
end
end
end

notifySystem:postNotify(notifyConfig.onSystemZMFightFlagChanged,infoData.serial,oldFlag,infoData.flag)

if oldFlag==systemZongMenFightFlagType.eSurrender or infoData.flag==systemZongMenFightFlagType.eSurrender then
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eXiTongZongMen)
notifySystem:postNotify(notifyConfig.on_UIWorldWin_infoBtn_reddotChange)
end
else
infoData.start_time=start_time or timeHelper.getServerShortTime()
infoData.end_time=systemZongMenModel:getFightFlagEndTime(infoData)
end
end

function systemZongMenController:pushBattleResultNotify(serial,teamIndex,result,reports,discipleguid,rewards)
systemZongMenModel:setWaitNotifyResult(serial,teamIndex,result,reports,discipleguid,rewards)

if teamIndex==0 then
self:refreshZongMenSceneHUD()
elseif teamIndex>0 then
local tasks=worldTaskModel:findAllFakeEx(function(t)
return t.target_type==eWorldUnitTpye.SYSTEMZM and teamIndex==t.target_id and mathHelper.compareInt64(serial,t.target_guid)
end)
for i,v in ipairs(tasks)do
local task=worldTaskModel:getTask(v)
task:callExpressFunc("checkEffectShow")
end
end

self:startUpdateHandle()

local unitKey=systemZongMenModel:convertUnitKey(serial)
worldHUDModel:onUpdateHUD(unitKey)

notifySystem:postNotify(notifyConfig.onSystemZMFightResultNew,serial,teamIndex)
end

function systemZongMenController:popBattleResultNotify(serial)
local data=systemZongMenModel:removeWaitNotifyResult(serial)
if data then

if data.teamIndex>0 then
local tasks=worldTaskModel:findAllFakeEx(function(t)
return t.target_type==eWorldUnitTpye.SYSTEMZM and data.teamIndex==t.target_id and mathHelper.compareInt64(serial,t.target_guid)
end)
for i,v in ipairs(tasks)do
local task=worldTaskModel:getTask(v)
task:back()
end
elseif data.teamIndex==0 then

self:deleteZongMenSceneEntity()

if mainControl:isInScene(eSceneType.eZongmen)and isometricMapSystem:IsInHome()and zongmenModel:getMountainId()==mapIdType.zhufeng then

local infoData=systemZongMenModel:getInfoData(serial)
local zmName=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
if data.result==fightResultType.Victory then
local descStr=FMT.fmt("没有抵挡住<color=#d48700><{0}></color>的攻势",zmName)
msgWinControl:addMsgWin(msgWinType.eSystemZongMenDefenseFailure,{itemDatas=data.rewards,desc=descStr})
else
local descStr=FMT.fmt("弟子们击退了<color=#d48700><{0}></color>的进攻，全体弟子士气大涨",zmName)
msgWinControl:addMsgWin(msgWinType.eSystemZongMenDefenseSuccess,{itemDatas=data.rewards,discipleguid=data.discipleguid,desc=descStr})
end
end
end

self:stopUpdateHandle()

local unitKey=systemZongMenModel:convertUnitKey(serial)
worldHUDModel:onUpdateHUD(unitKey)

notifySystem:postNotify(notifyConfig.onSystemZMFightRecordNew,serial,data.teamIndex)
end
end

function systemZongMenController:playFightBattle(serial,showResult)
local temp=systemZongMenModel:getWaitNotifyResult(serial)
if temp then
self:playFightBattleImp(temp,showResult)
return true
else
loggerUtil.logErrFMT("不存在对应系统宗门战斗数据:{0}",tostring(serial))
return false
end
end

function systemZongMenController:playFightBattleImp(resultTemp,showResult)
if resultTemp.reports and#resultTemp.reports>0 then
local replayType=resultTemp.teamIndex>0 and eRePlayerType.systemZongMenAttack or eRePlayerType.systemZongMenDefense
local args={
eReplayType=replayType,
showBattle=true,
showResult=showResult,
resultData=resultTemp,
}
fightController:send_log_list(resultTemp.reports,args)
else
self:popBattleResultNotify(resultTemp.serial)
end




end

function systemZongMenController:playFightRecord(reports,replayType)
if reports and#reports>0 then
local args={
eReplayType=replayType,
showBattle=true,
showResult=false,
resultData=nil,
}
fightController:send_log_list(reports,args)
end
end

function systemZongMenController:onFightNewDay5amHandle()
local nowTime=timeHelper.getServerShortTime()

local infoList=systemZongMenModel:getInfoList()
for index,infoData in ipairs(infoList)do
local handle=_NewDay5AMHandle[infoData.flag]
if handle then
handle(infoData,nowTime)
end
end
end

function systemZongMenController:addAgainSend_26_33(serial,teamIndex)
local data={
serial=serial,
teamIndex=teamIndex,
timeStamp=timeHelper.getServerShortTime(),
}
table.insert(_againSend_26_33_list,data)

self:startUpdateHandle()
end

function systemZongMenController:clearAgainSend_26_33()
table.clear(_againSend_26_33_list)
end

function systemZongMenController:removeAgainSend_26_33(serial,teamIndex)
local index=nil
for i,v in ipairs(_againSend_26_33_list)do
if mathHelper.compareInt64(v.serial,serial)and v.teamIndex==teamIndex then
index=i
break
end
end
table.remove(_againSend_26_33_list,index)

self:stopUpdateHandle()
end

function systemZongMenController:hasAgainSend_26_33()
return#_againSend_26_33_list>0
end

function systemZongMenController:updateAgainSend_26_33(nowTime)
for i,v in ipairs(_againSend_26_33_list)do
if v.timeStamp+_againSend_26_33_delay<=nowTime then
self:req_attack_team(v.serial,v.teamIndex)
v.timeStamp=nowTime
end
end
end

function systemZongMenController:createZongMenSceneEntity()
local attackInfo=systemZongMenModel:getAnyAttackInfo()
if not attackInfo or not attackInfo.passShow then
return
end
local result=systemZongMenModel:findDefenseWaitNotifyResult()
for i=1,fightPreSelectModel.maxPosNum*_kofModel do
local posCfg=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"LXPos")
local pos=posCfg[i]
if pos then
local exist=_teamEntity[i]
local discipleShow=attackInfo.teamList[i]
if discipleShow and discipleShow.disciple_id<=0 then
discipleShow=nil
end
if exist then

if discipleShow then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(discipleShow.discipledata,discipleShow.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
_MapManager.ChangeBody(exist,modelParams.body,modelParams.componets,modelParams.scale)
local escale=modelParams.scale
local ent=_EntityManager:GetEntity(exist)
ent:Mount(1110012,nil,"root",escale,Vector3.zero,nil)

else
_MapManager.RemoveTilemapObject(exist)
_teamEntity[i]=nil
local hud=_teamHUD[i]
if hud then
hudControl:removeHUD(hud)
_teamHUD[i]=nil
end
hud=_teamSpeak[i]
if hud then
hudControl:removeHUD(hud)
_teamSpeak[i]=nil
end
local bt=_teamBt[i]
if bt then
behaviorManager:removeBehaviorTree(bt)
_teamBt=nil
end
end
else

if discipleShow then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(discipleShow.discipledata,discipleShow.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
pos=_MapManager.ToVector3Int(pos[1],pos[2],0)
local guid=isometricMapSystem:createRoleEntity(objectType.eDefault,mapIdType.zhufeng,0,modelParams.body,modelParams.componets,SortingLayers.ITSky1,modelParams.scale,pos)
local escale=modelParams.scale
local ent=_EntityManager:GetEntity(guid)
ent:Mount(1110012,nil,"root",escale,Vector3.zero,nil)

local offset=_MapManager.GetObjectHeadOffset(guid)
if(i%fightPreSelectModel.maxPosNum)==1 then
local hud=hudControl:addHUD(INSTANCE_TYPE.eSystemZongMenDefense,guid,offset,true,true,function(id)
if _teamHUD[i]~=id then
hudControl:removeHUD(id)
return
end

local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(0,function()
local result=systemZongMenModel:findDefenseWaitNotifyResult()
if result then
self:playFightBattle(result.serial,true)
end
end)

local result=systemZongMenModel:findDefenseWaitNotifyResult()
widget:SetChildActive(0,result~=nil)
end)
_teamHUD[i]=hud
end

local speakHUD=hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,guid,offset,true,true,function(id)
if _teamSpeak[i]~=id then
hudControl:removeHUD(id)
return
end
local widget=hudControl:getHUDWidget(id)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(2)
widget:SetChildCSImageSprite(1,abName,skinName)
widget:SetChildActive(-1,false)
end)
_teamSpeak[i]=speakHUD

local btArgs={
stId=guid,
}
local btShare={
stateId=result and 1 or 0,
}
local bt=behaviorManager:addBehaviorTree("ai_systemzm_lx",btArgs,true,btShare,true)
_teamBt[i]=bt

_teamEntity[i]=guid
end
end
end
end

if next(_teamSpeak)then
self:startZongMenSceneSpeakTimer()
else
self:startZongMenSceneSpeakTimer()
end
end

function systemZongMenController:deleteZongMenSceneEntity()
for index,guid in pairs(_teamEntity)do
_MapManager.RemoveTilemapObject(guid)
end
for index,hud in pairs(_teamHUD)do
hudControl:removeHUD(hud)
end
for index,hud in pairs(_teamSpeak)do
hudControl:removeHUD(hud)
end
for index,bt in pairs(_teamBt)do
behaviorManager:removeBehaviorTree(bt)
end
table.clear(_teamEntity)
table.clear(_teamHUD)
table.clear(_teamSpeak)
table.clear(_teamBt)
self:stopZongMenSceneSpeakTimer()
end

function systemZongMenController:refreshZongMenSceneHUD()
local result=systemZongMenModel:findDefenseWaitNotifyResult()
local show=result~=nil
for index,hud in pairs(_teamHUD)do
local widget=hudControl:getHUDWidget(hud)
if widget then
widget:SetChildActive(0,show)
end
end
for index,bt in pairs(_teamBt)do
bt:setSharedVar("stateId",show and 1 or 0)
bt:broke()
bt:reset()
end
end

function systemZongMenController:startZongMenSceneSpeakTimer()
if not self.speakTimer then
self.speakTimer=timer.new()
self.speakTimer:start(3,function()
self:randomZongMenSceneSpeak()
end,-1)
end
end

function systemZongMenController:stopZongMenSceneSpeakTimer()
if self.speakTimer then
self.speakTimer:cancel()
self.speakTimer=nil
end
end

function systemZongMenController:randomZongMenSceneSpeak()
local result=systemZongMenModel:findDefenseWaitNotifyResult()
local hudList={}
for index,hud in pairs(_teamSpeak)do
table.insert(hudList,hud)

local widget=hudControl:getHUDWidget(hud)
if widget then
widget:SetChildActive(-1,false)
end
end
for i=1,3 do
local count=#hudList
if count<=0 then
return
end

local r1=math.random(1,count)
local contentLib=cfgHelper.get2(cfg_syssectbaseconfig_get,1,result~=nil and"lxSpeak2"or"lxSpeak")
local r2=math.random(1,#contentLib)
local content=contentLib[r2]
local hud=table.remove(hudList,r1)
local widget=hudControl:getHUDWidget(hud)
if widget then
widget:SetChildActive(-1,true)
widget:SetChildText(0,chatEmotHelper.decodeEmot(content))
end
end
end