






local _MODULENAME="MojiePreviewExtendController"

gameState.addListener(def_table(_MODULENAME))
MojiePreviewExtendController.name=_MODULENAME
MojiePreviewExtendController.data={}

function MojiePreviewExtendController:onAppStart()

MojiePreviewExtendModel:onAppStart()


socketManager:register_receiver(39,24,MojiePreviewExtendController.recv_39_24)
socketManager:register_receiver(39,25,MojiePreviewExtendController.recv_39_25)
socketManager:register_receiver(39,26,MojiePreviewExtendController.recv_39_26)
socketManager:register_receiver(39,28,MojiePreviewExtendController.recv_39_28)
socketManager:register_receiver(39,29,MojiePreviewExtendController.recv_39_29)
socketManager:register_receiver(39,34,MojiePreviewExtendController.recv_39_34)
socketManager:register_receiver(39,40,MojiePreviewExtendController.recv_39_40)


end


function MojiePreviewExtendController:onEnterState(isReconnect)
MojiePreviewExtendModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
end


function MojiePreviewExtendController:onProtocolReq()
MojiePreviewExtendModel:onProtocolReq()
end


function MojiePreviewExtendController:onLeaveState(isReconnect)
MojiePreviewExtendModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)

self.data={}
end


function MojiePreviewExtendController:onLostConnection()

end


function MojiePreviewExtendController:onReConnection(isInitPro)

end

function MojiePreviewExtendController.onNewDay()













MojiePreviewExtendController.req_39_24()
end




function MojiePreviewExtendController.recv_39_24(args)
local data={}
data.seasonId=args[1]

data.myScore=args[2]
data.myReward=args[3]
data.xianyuScore=mathHelper.int64_to_number(args[4])
data.xianyuReward=args[5]
data.bzzmRwFlag=args[6]
data.chapterMaxId=args[7]
data.mzyhReward=args[8]
MojiePreviewExtendModel:setData(data)
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end

function MojiePreviewExtendController.recv_39_25(myReward,xianyuReward)
local data=MojiePreviewExtendModel:getData()
data.myReward=myReward
data.xianyuReward=xianyuReward
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
UIManager.info("已领取奖励")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end

function MojiePreviewExtendController.recv_39_26(seasonId,myScore,xianyuScore)
local data=MojiePreviewExtendModel:getData()
data.seasonId=seasonId
data.myScore=myScore
data.xianyuScore=mathHelper.int64_to_number(xianyuScore)
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end

function MojiePreviewExtendController.recv_39_28(bzzmRwFlag)
local data=MojiePreviewExtendModel:getData()
data.bzzmRwFlag=bzzmRwFlag
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end




function MojiePreviewExtendController.recv_39_29(crossId,xianyuScore)
local _crossId=loginModel:getCrossServerId()
if _crossId==crossId then
local data=MojiePreviewExtendModel:getData()
data.xianyuScore=mathHelper.int64_to_number(xianyuScore)
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end
end

function MojiePreviewExtendController.recv_39_40(rwFlag)
local data=MojiePreviewExtendModel:getData()
data.mzyhReward=rwFlag
UIManager:invokeUIMethod("UIMoJieCDOpenWin","updateMzyhRewardClaimState")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end

function MojiePreviewExtendController.initSeverData(len,data)
MojiePreviewExtendModel:setSeverData(data)
notifySystem:postNotify(notifyConfig.onSeasonChange)
end

function MojiePreviewExtendController.recv_39_34(chapterMaxId)
local data=MojiePreviewExtendModel:getData()
data.chapterMaxId=chapterMaxId
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end


function MojiePreviewExtendController.req_39_24()
socketManager:send_39_24()
end








function MojiePreviewExtendController.req_39_25(rwType)
socketManager:send_39_25(rwType)
end

function MojiePreviewExtendController.req_39_28(id)
socketManager:send_39_28(id)
end

function MojiePreviewExtendController.req_39_34(id)
socketManager:send_39_34(id)
end

function MojiePreviewExtendController.req_39_40()
socketManager:send_39_40()
end

function MojiePreviewExtendController.checkSysReddot()
return MojiePreviewExtendController.checkReddot()or MojiePreviewExtendController.checkAllBZZhengMoReddot()
end



function MojiePreviewExtendController.checkTabShow(index,getTips)
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
if getTips then
return false,"未开启","魔界赛季未开启"
else
return false
end

end
local sId=enterData.sId
local baseCfg=cfg_mojieyugaoextbaseconfig_get(sId)
local ygDays=baseCfg.ygDays
local ygDay=(index>=1 and index<=#ygDays)
and ygDays[index]
or-1


if ygDay==nil or ygDay==-1 then
return false
else
local showTime=enterData.sTime-ygDay*86400
local nowTime=timeHelper.getServerShortTime()
if nowTime>=enterData.eTime then
if getTips then
return false,"已结束","魔界赛季已结束"
else
return false
end
end
if showTime>nowTime then
if getTips then
local day=math.ceil((showTime-nowTime)/86400)
local tips=FMT.fmt("{0}天后开启",day)
return false,tips,tips
else
return false
end
end
for i,v in ipairs(baseCfg.tabCfgList)do
local contentIndex=v.contentIndex
if index==contentIndex then
local check,tabName,tips=MojiePreviewExtendController:checkCdn(v.cdn,getTips)
if not check then
if getTips then
return false,tabName,tips
else
return false
end
end
end
end
return true
end
end


function MojiePreviewExtendController.checkReddot()
if MojiePreviewExtendController.checkOverPreview()then
return false
end
if not MojiePreviewExtendController.checkTabShow(2)then
return false
end
return MojiePreviewExtendController.checkMyTaskReddot()or
MojiePreviewExtendController.checkXyTaskReddot()or
MojiePreviewExtendController.checkTJYXTodayReddot()
end

function MojiePreviewExtendController.checkMyTaskReddot()
local flag=MojiePreviewExtendModel:getData_myReward()==1
if flag then
return false
end

local myTaskId=MojiePreviewExtendModel:getData_taskId()
local mytaskCfg=cfg_mojieyugaogerentaskconfig_get(myTaskId)
if not mytaskCfg then
logErr("魔界预告拓展没有任务配置 id-->>",myTaskId)
return
end
local targetScore=mytaskCfg.score
local curScore=MojiePreviewExtendModel:getData_myScore()
return curScore>=targetScore
end

function MojiePreviewExtendController.checkXyTaskReddot()
local flag=MojiePreviewExtendModel:getData_xianyuReward()==1
if flag then
return false
end
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local xianyuTask=cfg.xianyuTask
local xyTargetScore=xianyuTask[1]
local curXyScore=MojiePreviewExtendModel:getData_xianyuScore()
return curXyScore>=xyTargetScore
end


function MojiePreviewExtendController.checkTJYXTodayReddot()

local flag=MojiePreviewExtendModel:getData_xianyuReward()==1
if flag then
return false
end
flag=MojiePreviewExtendModel:getData_myReward()==1
if flag then
return false
end
flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMJYG_TJYX)
return not flag
end


function MojiePreviewExtendController.checkAllBZZhengMoReddot()
if MojiePreviewExtendController.checkOverPreview()then
return false
end
if not MojiePreviewExtendController.checkTabShow(3)then
return false
end

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local bzzmItems=cfg.bzzmItems
for id,v in pairs(bzzmItems)do
if MojiePreviewExtendController.checkBZZhengMoReddot(id)or MojiePreviewExtendController.checkBZZhengMoLookReddot(id)then
return true
end
end
return false
end



function MojiePreviewExtendController.checkBZZhengMoReddot(id)
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false
end
local flag=MojiePreviewExtendModel:getData_bzzmRwFlag()
if flag>=id then
return false
end







local chapterMaxId=MojiePreviewExtendModel:getData_chapterMaxId()
return chapterMaxId>=id
end



function MojiePreviewExtendController.checkBZZhengMoLookReddot(id)
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false
end
local flag=MojiePreviewExtendModel:getData_bzzmRwFlag()
if flag>=id then
return false
end
if not MojiePreviewExtendController.checkBZZhengMoCanLook(id)then
return false
end
local chapterMaxId=MojiePreviewExtendModel:getData_chapterMaxId()
if id==2 then
return chapterMaxId>=1 and chapterMaxId<id
end
return chapterMaxId<id
end

function MojiePreviewExtendController.checkMzyhRewardReddot()
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false
end
if enterData.sId~=4 and enterData.sId~=5 then return false end

local flag=MojiePreviewExtendModel:getData_mzyhReward()
return flag==0
end

function MojiePreviewExtendController.checkBZZhengMoCanLook(id)
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false,0
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local bzzmlimt=cfg.bzzmlimt
local limtDay=bzzmlimt[id]
local lookTime=enterData.sTime-limtDay*86400
local nowTime=timeHelper.getServerShortTime()
if nowTime<lookTime then
return false,math.ceil((lookTime-nowTime)/86400)
end
return true
end


function MojiePreviewExtendController.checkOverPreview()
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return true
end
local nowTime=timeHelper.getServerShortTime()
local stratDayZeroTime=timeHelper.getServerZeroShortStamp(enterData.sTime)
if nowTime>=stratDayZeroTime then
return true
end
return false
end




function MojiePreviewExtendController.checkPoKaiMoJieFlag()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local sData=MojiePreviewExtendModel:getSeverData()
if sData and table.containsValue(sData,enterData.sId)then
return true
end
end
return false
end


function MojiePreviewExtendController.pokaiMjieTrigger()

local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local sceneType=xianjieModel:sceneIndex2SceneType(cfg.sceneidx)

xianjieController:jumpXianJie(sceneType,{triggerMojieSeasonStageBehavier=true})









else
logErr("触发跳转魔界 没有魔界数据")
end

end


function MojiePreviewExtendController.onSeasonStageChange(season_id,chapter_idx)
local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local tabCfgList=cfg.tabCfgList
local dirtyFlag=false
for i,v in ipairs(tabCfgList)do
if v.cdn then
for ii,vv in ipairs(v.cdn)do
if vv[1]==1 and vv[2]==chapter_idx then
dirtyFlag=true
break
end
end
end
if dirtyFlag then
break
end
end
if dirtyFlag then
UIManager:invokeUIMethod("UIMoJieCDOpenWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end
end


function MojiePreviewExtendController.checkPopWin()
local mjEnterData=xianjieModel:getMoJieEnterData()
local enterXYFlag=xianjieModel:checkJoin()
local initData=initProControl.isDoneKF()

if initProControl.isDoneKF()and enterXYFlag and mjEnterData then
local nowTime=timeHelper.getServerShortTime()

if nowTime<mjEnterData.sTime then


msgWinControl:addMsgWin(msgWinType.eMoJieOpenCD,nil,nil,true)
else
if not MojiePreviewExtendController.checkPoKaiMoJieFlag()then

msgWinControl:addMsgWin(msgWinType.eMoJieOpenCD,nil,nil,true)
end
end

if nowTime<mjEnterData.eTime then


msgWinControl:addMsgWin(msgWinType.eMoJieCloseCD,nil,nil,true)
end
end
end

function MojiePreviewExtendController.checkPopFinishWin()
local mjEnterData=xianjieModel:getMoJieEnterData()
local enterXYFlag=xianjieModel:checkJoin()
local initData=initProControl.isDoneKF()

if initProControl.isDoneKF()and enterXYFlag and mjEnterData then
local nowTime=timeHelper.getServerShortTime()
if nowTime<mjEnterData.eTime then


msgWinControl:addMsgWin(msgWinType.eMoJieCloseCD,nil,nil,true)
end
end
end





function MojiePreviewExtendController.printSeverData()
local data=MojiePreviewExtendModel:getSeverData()
local enterData=xianjieModel:getMoJieEnterData()
if enterData then

if data then


else

end
else

end
end

function MojiePreviewExtendController.initSeverDataTest()
local sData={}
MojiePreviewExtendModel:setSeverData(sData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.MoJieYuGao,#sData,sData)
notifySystem:postNotify(notifyConfig.onSeasonChange)
end

function MojiePreviewExtendController:checkCdn(cdn,getTips)
if not cdn then
return true
end
for i,v in ipairs(cdn)do
local type=v[1]

if type==1 then
local chapter_idx=v[2]
if not seasonController:checkSeasonStageBegined(0,chapter_idx)then
if getTips then
return false,"暂未开启",FMT.fmt("需要完成重建仙域第{0}章",mathHelper.numberToChinese(chapter_idx))
else
return false
end
end
end
end
return true
end
