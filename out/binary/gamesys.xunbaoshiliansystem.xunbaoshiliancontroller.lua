








xunBaoShiLianController=gameState.addListener({})




function xunBaoShiLianController:onAppStart()

xunBaoShiLianModel:onAppStart()



socketManager:register_receiver(25,40,xunBaoShiLianController.recv_25_40)
socketManager:register_receiver(25,41,xunBaoShiLianController.recv_25_41)
socketManager:register_receiver(25,42,xunBaoShiLianController.recv_25_42)
socketManager:register_receiver(25,43,xunBaoShiLianController.recv_25_43)
socketManager:register_receiver(25,44,xunBaoShiLianController.recv_25_44)
socketManager:register_receiver(25,45,xunBaoShiLianController.recv_25_45)






end


function xunBaoShiLianController:onEnterState(isReconnect)
xunBaoShiLianModel:onEnterState()
end


function xunBaoShiLianController:onProtocolReq()
xunBaoShiLianModel:onProtocolReq()
end


function xunBaoShiLianController:onLeaveState(isReconnect)
xunBaoShiLianModel:onLeaveState(isReconnect)

self.data={}
end


function xunBaoShiLianController:onLostConnection()

end


function xunBaoShiLianController:onReConnection(isInitPro)

end




function xunBaoShiLianController:reqGetTargetReward(modeId,maxGetChapterId,maxGetRewardIdx)
if modeId==XBSL_DIFFICULTY_MODE.Normal then
socketManager:send_25_42(maxGetChapterId,maxGetRewardIdx)
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
socketManager:send_25_43(maxGetChapterId,maxGetRewardIdx)
end
end

function xunBaoShiLianController:reqGetXuanShangReward(bountyId)
socketManager:send_25_44(bountyId)
end


function xunBaoShiLianController.recv_25_40(args)
local trainningOpenTime=args[1]
local normalChapterId=args[2]
local normalLevelIdx=args[3]
local hardChapterId=args[4]
local hardLevelIdx=args[5]
local normalTargetLen=args[6]
local normalTargetDataList=args[7]
local hardTargetLen=args[8]
local hardTargetDataList=args[9]
local xuanShangLen=args[10]
local xuanShangDataList=args[11]

xunBaoShiLianModel:setShiLianData(trainningOpenTime,normalChapterId,normalLevelIdx,hardChapterId,hardLevelIdx)
xunBaoShiLianModel:setTargetData(normalTargetLen,normalTargetDataList,hardTargetLen,hardTargetDataList)
xunBaoShiLianModel:setXuanShangData(xuanShangLen,xuanShangDataList)
xunBaoShiLianModel:setCurrentLevelAllNum()

reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
notifySystem:postNotify(notifyConfig.oneXunBaoShiLianLVChange,nil)
end


function xunBaoShiLianController.recv_25_41(trainningOpenTime)
xunBaoShiLianModel:setShiLianOpenTime(trainningOpenTime)

reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
end


function xunBaoShiLianController.recv_25_42(chapterId,rewardIdx)
local modeId=XBSL_DIFFICULTY_MODE.Normal
xunBaoShiLianModel:setTargetDataByModeId(modeId,chapterId,rewardIdx)

UIManager:invokeUIMethod("UIXBSL_targetWin","refresh",true)
UIManager:invokeUIMethod("UIXBSL_mainWin","refreshBtnReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
end


function xunBaoShiLianController.recv_25_43(chapterId,rewardIdx)
local modeId=XBSL_DIFFICULTY_MODE.Hard
xunBaoShiLianModel:setTargetDataByModeId(modeId,chapterId,rewardIdx)

UIManager:invokeUIMethod("UIXBSL_targetWin","refresh",true)
UIManager:invokeUIMethod("UIXBSL_mainWin","refreshBtnReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
end


function xunBaoShiLianController.recv_25_44(bountyId,freeIdx,investIdx)
xunBaoShiLianModel:setXuanShangIdxByBountyId(bountyId,freeIdx,investIdx)

UIManager:invokeUIMethod("UIXBSL_xuanShangWin","refreshPage",true)
UIManager:invokeUIMethod("UIXBSL_xuanShangWin","refreshMenuReddot")
UIManager:invokeUIMethod("UIXBSL_mainWin","refreshBtnReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
end


function xunBaoShiLianController.recv_25_45(bountyId)
xunBaoShiLianModel:setXuanShangBuyStateByBountyId(bountyId)

UIManager:invokeUIMethod("UIXBSL_xuanShangWin","refreshPage",true)
UIManager:invokeUIMethod("UIXBSL_xuanShangWin","refreshMenuReddot")
UIManager:invokeUIMethod("UIXBSL_mainWin","refreshBtnReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
end



function xunBaoShiLianController:onLevelComplete(chapterId,levelIdx,isHardFlag)
local modeId=isHardFlag==1 and XBSL_DIFFICULTY_MODE.Hard or XBSL_DIFFICULTY_MODE.Normal
xunBaoShiLianModel:setShiLianDataByModeId(modeId,chapterId,levelIdx)
xunBaoShiLianModel:setCurrentLevelAllNum()


reddotControl.on_change_catch_type(CATCH_TYPE.eBaoLingShuXBSL)
notifySystem:postNotify(notifyConfig.oneXunBaoShiLianLVChange,nil)
end


function xunBaoShiLianController:openXBSLFight(chapterId,levelIdx,modeId)
local chapterCfg=xunBaoShiLianModel:checkModelChapter(modeId,chapterId)

local guanqiaIdList={}
local isHardFlag=0
if modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
isHardFlag=1
guanqiaIdList=chapterCfg.difficulty_ids
end
local guanqiaId=guanqiaIdList[levelIdx]
if not guanqiaId then
return
end

local cfg=cfgHelper.get1(cfg_treasuretrainninggqconfig_get,guanqiaId)
if not cfg then
return
end
local mId=cfg.mon_ids
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)

local winArgs={
enterTxt="寻宝试炼",
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
isHomeBattle=true,
monsterList=mcfg.monList,
groupId=mId,
enterCallBack=function(guidList,zfId)
UIManager:closeWindow('UIXBSL_fightExtraWin')
fightLaunchController:sendFight(eBattleLaunch.xunbaoshilian,guidList,mcfg.mapId or 0,zfId,{chapterId,levelIdx,isHardFlag})
end,
cancelCallBack=function()
UIManager:closeWindow('UIXBSL_fightExtraWin')
UIFullBaoLingShuControl:showXunBaoShiLianWindow({args={chapterId=chapterId,standLevel=levelIdx}})
end,
}
local isShowExtraWin=modeId==XBSL_DIFFICULTY_MODE.Hard
fightController.showPrepareWin(fightPreSelectModel.fightType.xunbaoshilian,winArgs,function()
if not isShowExtraWin then
return
end
UIManager:showWindow('UIXBSL_fightExtraWin',{chapterId=chapterId,levelIdx=levelIdx,guanqiaId=guanqiaId})
end)
end


function xunBaoShiLianController:setShiLianEnterNextChapter(modeId)
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(modeId)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(modeId)

local chapterCfg=xunBaoShiLianModel:checkModelChapter(modeId,clearChapterId)
if chapterCfg then
local guanqiaIdList={}
if modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=chapterCfg.difficulty_ids
end
if clearLevelIdx>=#guanqiaIdList then

local nextChapterId=clearChapterId+1
local nextLevelIdx=0
xunBaoShiLianModel:setShiLianDataByModeId(modeId,nextChapterId,nextLevelIdx)
end
end
end


function xunBaoShiLianController:onFightResultBaseBtn(this,battleId,param)
local data=param[1]
local fightType=data.fighttype
local chapterId=data.chapter_id
local levelIdx=data.training_idx
local isHardFlag=data.is_difficulty
local modeId=isHardFlag==1 and XBSL_DIFFICULTY_MODE.Hard or XBSL_DIFFICULTY_MODE.Normal
local hasNext=false

local quitCallBack=function()
fightResultController:afterShowResult()
end

local chapterCfg=xunBaoShiLianModel:checkModelChapter(modeId,chapterId)
local guanqiaIdList={}
if modeId==XBSL_DIFFICULTY_MODE.Normal then
guanqiaIdList=chapterCfg.simple_ids
elseif modeId==XBSL_DIFFICULTY_MODE.Hard then
guanqiaIdList=chapterCfg.difficulty_ids
end

local nextLevelIdx=levelIdx+1
local guanqiaId=guanqiaIdList[nextLevelIdx]
local mapId
if nextLevelIdx<=#guanqiaIdList and guanqiaId then
local isUnlock,tips=xunBaoShiLianModel:checkGuanQiaIsUnlock(guanqiaId)
if isUnlock then
hasNext=true

local guanqiaCfg=cfgHelper.get1(cfg_treasuretrainninggqconfig_get,guanqiaId)
local mId=guanqiaCfg.mon_ids
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
mapId=mcfg.mapId
end
end

local continueCallBack=function()
local battle=fightModel:getBattle(battleId)
local entities=battle:getEntities()

for i=6,10 do
if entities and entities[i]then
battle:removeEntity(i)
end
end

for i=101,110 do
if entities and entities[i]then
battle:removeEntity(i)
end
end
local func=function()
fightModel:onBattleContinue(battleId)
local guidList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.xunbaoshilian)
local team={}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
team[i]={1,guidList[i]}
else
team[i]={0,int64.zero}
end
end
fightLaunchController:sendFight(eBattleLaunch.xunbaoshilian,team,mapId or 0,0,{chapterId,nextLevelIdx,isHardFlag})
end
loadingControl.openCloud(func,1.5)
end

if hasNext then
return fightResultWinConfig:getBaseWinParam(this.baseWin,3,'继续挑战',continueCallBack,"退 出",quitCallBack,5,false)
else
return fightResultWinConfig:getBaseWinParam(this.baseWin,1,"退 出",quitCallBack)
end
end