






local _MODULENAME="worldXiuZhenJiaZuController"




gameState.addListener(def_table(_MODULENAME))
worldXiuZhenJiaZuController.name=_MODULENAME


worldXiuZhenJiaZuController.data={}

function worldXiuZhenJiaZuController:onAppStart()
worldXiuZhenJiaZuModel:onAppStart()



socketManager:register_receiver(5,51,worldXiuZhenJiaZuController.recv_5_51)
socketManager:register_receiver(5,52,worldXiuZhenJiaZuController.recv_5_52)
socketManager:register_receiver(5,53,worldXiuZhenJiaZuController.recv_5_53)
socketManager:register_receiver(5,54,worldXiuZhenJiaZuController.recv_5_54)
socketManager:register_receiver(5,55,worldXiuZhenJiaZuController.recv_5_55)
socketManager:register_receiver(5,56,worldXiuZhenJiaZuController.recv_5_56)
socketManager:register_receiver(5,57,worldXiuZhenJiaZuController.recv_5_57)
socketManager:register_receiver(5,58,worldXiuZhenJiaZuController.recv_5_58)
socketManager:register_receiver(5,59,worldXiuZhenJiaZuController.recv_5_59)
socketManager:register_receiver(5,60,worldXiuZhenJiaZuController.recv_5_60)




worldController:registerSceneState(1,4,function()
local world=worldModel.world
local datas=worldXiuZhenJiaZuModel:getAllFamilyData(world)

for i,v in pairs(datas)do
if worldBlockModel:checkBlockState(v.world,v.block,eWorldBlockState.OPEN)then
worldXiuZhenJiaZuController:pushUnitObjectInWord(v.familyId,v.position,v.guid,v.flip)
end
end
end)
end


function worldXiuZhenJiaZuController:onEnterState()
worldXiuZhenJiaZuModel:onEnterState()











notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickFamilyObj)

notifySystem:listenNotify(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
end


function worldXiuZhenJiaZuController:onServerDataInitFinish()
worldXiuZhenJiaZuModel:onServerDataInitFinish()
end


function worldXiuZhenJiaZuController:onLeaveState(isReconnet)
worldXiuZhenJiaZuModel:onLeaveState(isReconnet)

self.data={}
notifySystem:removelistener(notifyConfig.onClickObjectInWorld,self.onClickFamilyObj)

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:removelistener(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:removelistener(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:removelistener(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:removelistener(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
end


function worldXiuZhenJiaZuController:onLostConnection()

end



function worldXiuZhenJiaZuController:req_xzfamily_data(world)
socketManager:send_5_51(world)
end


function worldXiuZhenJiaZuController:req_quzhu_xzfamily(world,guid,dzLen,dzList)
socketManager:send_5_52(world,guid,dzLen,dzList)
end


function worldXiuZhenJiaZuController:req_giveup_xzfamily(world,guid)
socketManager:send_5_53(world,guid)
end


function worldXiuZhenJiaZuController:req_change_xzfamily(world,guid,teamListLen,teamList)
socketManager:send_5_54(world,guid,teamListLen,teamList)
end


function worldXiuZhenJiaZuController:req_zhengduo_xzfamily(world,guid,dzLen,dzList)
socketManager:send_5_55(world,guid,dzLen,dzList)
end


function worldXiuZhenJiaZuController:req_jinzhu_xzfamily(world,guid,teamListLen,teamList)
socketManager:send_5_56(world,guid,teamListLen,teamList)
end


function worldXiuZhenJiaZuController:req_firstReward_xzfamily(world,guid)
socketManager:send_5_57(world,guid)
end



function worldXiuZhenJiaZuController.recv_5_51(world,len,familyData)







end



function worldXiuZhenJiaZuController.recv_5_52(len,array)
worldXiuZhenJiaZuModel:init()
if worldController:isInWorld()then
local datas=worldXiuZhenJiaZuModel:getAllFamilyData(worldModel.world)
for i,v in ipairs(datas)do
local unitKey=worldXiuZhenJiaZuModel:convertKey(v.guid)
worldController:popUnit(unitKey)
end
end
worldXiuZhenJiaZuModel:clearOpenFamilyData()
worldXiuZhenJiaZuModel:clearAllFamilyData()
chatGGModel.initJiazu(array)

worldXiuZhenJiaZuModel:checkPosition(array or{})
if len>0 then
for i=1,len do
local info=array[i]

worldXiuZhenJiaZuController:createFamilyObject(info.world_id,info.xzfamilyList or{})
end
end
UIRecruitModel:initFamilyNeedCost()
worldModel:finishInit(eWorldUnitTpye.FAMILY)
notifySystem:postNotify(notifyConfig.on_family_init)
end


function worldXiuZhenJiaZuController.recv_5_53(world,guid)
UIManager.info('已放弃占领该家族')
worldXiuZhenJiaZuModel:changeFamilyState(guid,familyState.neutral)
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKeys=worldTaskModel:findAllTaskKey_ByTarget(unitKey)
for i,v in ipairs(taskKeys)do
local task=worldTaskModel:getTask(v)
if task.progress_state<=eWorldTripProgress.Work then
worldTaskController:returnMission(v)

end
end





worldHUDModel:UpdateHUDByKey(unitKey)

worldXiuZhenJiaZuController:refreshFamilyLeftWin(guid)
worldXiuZhenJiaZuController:refreshFamilyRightWin(guid)
worldController:resetRightView()
UIManager:callWindowFunc("UIWorldXiuZhenJiaZuListWin","refreshCount")
end


function worldXiuZhenJiaZuController.recv_5_54(world,guid,teamListLen,teamList)

worldXiuZhenJiaZuModel:changeFamilyDzList(guid,teamListLen,teamList)
worldXiuZhenJiaZuController:refreshFamilyRightWin(guid)

end



function worldXiuZhenJiaZuController.recv_5_55(guid,dzLen,dzList,result,fightLog)

end


function worldXiuZhenJiaZuController.recv_5_56(world,guid,teamListLen,teamList)
local dzs={}
for i=1,teamListLen do
local dz=teamList[i]
local dzId=dz.unitId
local isInOther=worldXiuZhenJiaZuModel:checkDzIsInOtherFamily(dzId,guid)
local insertType=0
local insertDzId=int64.zero
if not isInOther then
insertType=1
insertDzId=dzId
end
table.insert(dzs,{insertType,insertDzId})
end
worldXiuZhenJiaZuController:req_change_xzfamily(world,guid,teamListLen,dzs)

UIManager:callWindowFunc("UIWorldXiuZhenJiaZuListWin","refreshCount")

notifySystem:postNotify(notifyConfig.onXiuZhenJiaZuJinZhu,world,guid,teamListLen,teamList)
end


function worldXiuZhenJiaZuController.recv_5_57(world,guid)
worldXiuZhenJiaZuModel:setFirstRewardFlag(guid)
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
local initFamilyCfg=cfg_xiuzhenfamilyinitdataconfig()
local conf={}
for i,v in ipairs(initFamilyCfg)do
if v.familyId==familyData.familyId then
local firstReward=v.helloRewards
for _,reward in ipairs(firstReward)do
local itemid=reward[1]
local count=reward[2]
table.insert(conf,{itemid=itemid,num=count})
end
end
end

local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
worldHUDModel:UpdateHUDByKey(unitKey)
if next(conf)then
showPrizeControl.showWindowNow(conf,function()
worldController:changeRightView("UIWorldXiuZhenJiaZuInfoWin",guid)

end)
end
UIManager:invokeUIMethod("UIWorldXiuZhenJiaZuListWin","refreshMainItemReddotByGuid",guid)
UIManager:invokeUIMethod("UIWorldXiuZhenJiaZuListWin","refreshSubItem",guid)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eXiuZhenFamily)
end



function worldXiuZhenJiaZuController.recv_5_58(world,familyLen,familyList)
worldXiuZhenJiaZuModel:changeFamilyPeople(familyLen,familyList)

notifySystem:postNotify(notifyConfig.onXiuZhenJiaZuChange,world,familyLen,familyList)
end


function worldXiuZhenJiaZuController.recv_5_59(world,guid)
local mainIndex,subIndex=worldXiuZhenJiaZuModel:getOpenListIndexByGuid(guid)
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
local name=worldXiuZhenJiaZuModel:getZuZhangName(guid)
worldXiuZhenJiaZuModel:removeFamilyData(guid)
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
worldController:popUnit(unitKey)

local zuZhangCfg=worldXiuZhenJiaZuModel:getElderConfig(data.familyId)
local model=worldXiuZhenJiaZuModel:getZuZhangImageInfoInSide(zuZhangCfg.model)

local afterCB=function()
UIManager.info("家族已被驱逐")
end

gameplotController:showPlotBoard({image=model,name=name,groupid=zuZhangCfg.remove_talk,callback=afterCB})

local win=UIManager:findActiveWindow("UIWorldXiuZhenJiaZuListWin")
if win then
win:refreshMainItemByGuid(guid)
end
worldController:resetRightView()

UIRecruitModel:initFamilyNeedCost()
UIManager:callWindowFunc("UIWorldXiuZhenJiaZuListWin","refreshCount")

notifySystem:postNotify(notifyConfig.onXiuZhenJiaZuDead,world,guid)
end


function worldXiuZhenJiaZuController.recv_5_60(world,familyLen,familyData)
if familyLen>0 and worldXiuZhenJiaZuModel:isInit()then
worldXiuZhenJiaZuController:createFamilyObject(world,familyData)
end
end



function worldXiuZhenJiaZuController.onClickFamilyObj(args)
if args and args[1]==worldModel.UNITTYPE.FAMILY and args[2]then

AudioManager.playBtnClick()

local guid=args[2]
local task_data=worldXiuZhenJiaZuModel:getFightResult(guid)

if task_data then
local taskProgress=worldXiuZhenJiaZuController:chessMissionProgress(guid)
if taskProgress==eWorldTripProgress.Work then
local task_data=worldXiuZhenJiaZuModel:getFightResult(guid)
local subType=task_data[4]
local world=task_data[3]
local logIdx=task_data[2]
local fightResult=task_data[1]
worldXiuZhenJiaZuController.fight(world,guid,subType,fightResult,logIdx)
elseif taskProgress==eWorldTripProgress.Back then
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
if familyData.firstRewardFlag==0 then
worldController:changeRightView("UIWorldXiuZhenJiaZuInfoWin",guid)
else
UIManager:showWindow("UIWorldXiuZhenJiaZuFirstRewardWin",guid)

end
end
else
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
if familyData.firstRewardFlag==0 then
worldController:changeRightView("UIWorldXiuZhenJiaZuInfoWin",guid)




else
UIManager:showWindow("UIWorldXiuZhenJiaZuFirstRewardWin",guid)

end
end
end
end














function worldXiuZhenJiaZuController.onWorldBlockDataChanged(world,block,state)
if state==worldBlockModel.BLOCKSTATE.OPEN then
worldXiuZhenJiaZuModel:addNewOpenFamilyDataByUnlock(world,block)
end
end


function worldXiuZhenJiaZuController.onWorldBlockStateChanged(world,block,state)
if state==worldBlockModel.BLOCKSTATE.OPEN then



local blockFamilyList=worldXiuZhenJiaZuModel:getBlockFamilyData(world,block)
for i,v in ipairs(blockFamilyList)do
worldXiuZhenJiaZuController:pushUnitObjectInWord(v.familyId,v.position,v.guid,v.flip)
end
end
end

function worldXiuZhenJiaZuController.onWorldBlockDataInited(reInit)
worldXiuZhenJiaZuModel:initLibrary()
if initProControl.isDone()and worldController:isInWorld()then
local world=worldModel.world
local datas=worldXiuZhenJiaZuModel:getAllFamilyData(world)
for i,v in ipairs(datas)do
local unitKey=worldXiuZhenJiaZuModel:convertKey(v.guid)
worldController:popUnit(unitKey)
end
for i,v in ipairs(datas)do
if worldBlockModel:checkBlockState(v.world,v.block,eWorldBlockState.OPEN)then
worldXiuZhenJiaZuController:pushUnitObjectInWord(v.familyId,v.position,v.guid,v.flip)
end
end
end
end

function worldXiuZhenJiaZuController:createFamilyObject(world,familyData)
for i,v in ipairs(familyData)do
worldXiuZhenJiaZuModel:addFamilyObjData(world,v)
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(v.guid)
if worldModel:isSameWorld(world)and worldBlockModel:checkBlockState(world,data.block,eWorldBlockState.OPEN)then
self:pushUnitObjectInWord(data.familyId,data.position,data.guid,data.flip)
worldXiuZhenJiaZuModel:addOpenFamilyData(data.guid)
end
end
end

function worldXiuZhenJiaZuController:pushUnitObjectInWord(familyId,pos,guid,flip)
if not systemModel.isOpen(SYSTEM_DEFINE.eXiuZhenFamily)then return end
local unitType=eWorldUnitTpye.FAMILY
local config=worldBlockModel:getUnitConfig(unitType,familyId)
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local hudSetting=worldModel:getHUDSetting(config.hudRes)

local index=worldXiuZhenJiaZuModel:getFamilyScaleData(guid)
local models=config.modelRes
local modelRes=models[index]
local modelSettings=worldModel:getModelSettings(modelRes,unitType)




worldController:pushUnit(unitKey,pos,{unitType,guid,familyId},modelSettings,hudSetting)

local isFlipX=flip or false
worldController:setUnitFlipX(unitKey,isFlipX)
end

function worldXiuZhenJiaZuController:refreshFamilyLeftWin(guid)






UIManager:invokeUIMethod("UIWorldXiuZhenJiaZuListWin","refreshSubItem",guid)
end

function worldXiuZhenJiaZuController:refreshFamilyRightWin(guid)
UIManager:invokeUIMethod("UIWorldXiuZhenJiaZuInfoWin","refreshStateInfo",guid)




end


function worldXiuZhenJiaZuController.startMission(guid,familyId,subType,world,teamList,zfId)
local targetKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

if not taskKey then
local disciples=fightPreSelectModel.convertFightStruct2Disciple(teamList)
worldTaskController:startMission(eWorldUnitTpye.FAMILY,guid,familyId,disciples,zfId)

fightLaunchController:sendFight(eBattleLaunch.family,teamList,0,zfId or 0,{subType,world,guid})
else
local task=worldTaskModel:getTask(taskKey)
if task.progress_state<=eWorldTripProgress.Work then
UIManager.error("仍在大世界狂奔")
else
local disciples=fightPreSelectModel.convertFightStruct2Disciple(teamList)
worldTaskController:startMission(eWorldUnitTpye.FAMILY,guid,familyId,disciples,zfId)

fightLaunchController:sendFight(eBattleLaunch.family,teamList,0,zfId or 0,{subType,world,guid})
end
end
end

function worldXiuZhenJiaZuController:checkMission(guid)

local targetKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey then
return true
end
return false
end


function worldXiuZhenJiaZuController:checkPassForward(guid)

local targetKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)

if taskKey then
if worldTaskModel:containTask(taskKey)then
local task=worldTaskModel:getTask(taskKey)
return task.progress_state==eWorldTripProgress.Work
end
end
return false
end

function worldXiuZhenJiaZuController:chessMissionProgress(guid)
local targetKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey then
if worldTaskModel:containTask(taskKey)then
local task=worldTaskModel:getTask(taskKey)
return task.progress_state
end
end
end


function worldXiuZhenJiaZuController.fight(world,guid,subType,fightResult,logIdx)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.worldFamilyJinZhu,fightResult,logIdx,world,guid,subType)
end

function worldXiuZhenJiaZuController.on_money_change(moneyType,lastVal,val,changeType)
if changeType==GameLog.clWorldXZFamilyFengLu then
local changeNum=val-lastVal
local msg=FMT.fmt(cfgHelper.getlang('jiazu_fenglu_chat_1'),gameUtilityModel.getGameYearPass(),changeNum)
local msgType=chatConfig.getLangMsgType('jiazu_fenglu_chat_1')
chatControl.reqSystemMesg(msgType,{CHAT_CHANNNEL.eSystem},msg)
end
end

function worldXiuZhenJiaZuController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.FAMILY then
local guid=int64.new(rData.key)
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
if data.initId>0 then
loggerUtil.logErrFMT("固定家族位置被顶替：{0}， {1}",serializeHelper.serialize(rData),serializeHelper.serialize(aData))
return
end
local world=data.world
local library=worldXiuZhenJiaZuModel:getLibrary(world)
local check,temp=worldPositionLibrary:extract(library)
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
local position,block=worldPositionConfig:getPosition(world,{x,z})
data.x=x
data.z=z
data.flip=flip
data.block=block
data.position=position
worldPositionLibrary:eraseData(data.guid)
if valid then
worldPositionLibrary:markData(world,x,z,flip,eWorldUnitTpye.FAMILY,data.guid)
local unitKey=worldXiuZhenJiaZuModel:convertKey(data.guid)
worldTaskModel:changeTaskTargetDestination(unitKey)
if worldController:isInWorld()and worldModel:isSameWorld(data.world)then
worldController:setUnitFlipX(unitKey,data.flip)
worldController:setUnitPosition(unitKey,data.position)
end
end
end
end
