














function xianmengController:onAppStart_TYSC()
socketManager:register_receiver(248,11,xianmengController.recv_248_11)
socketManager:register_receiver(248,12,xianmengController.recv_248_12)
socketManager:register_receiver(248,13,xianmengController.recv_248_13)
socketManager:register_receiver(248,14,xianmengController.recv_248_14)
socketManager:register_receiver(248,15,xianmengController.recv_248_15)
socketManager:register_receiver(248,16,xianmengController.recv_248_16)
socketManager:register_receiver(248,17,xianmengController.recv_248_17)
socketManager:register_receiver(248,18,xianmengController.recv_248_18)
socketManager:register_receiver(248,19,xianmengController.recv_248_19)
socketManager:register_receiver(248,20,xianmengController.recv_248_20)
socketManager:register_receiver(248,21,xianmengController.recv_248_21)
socketManager:register_receiver(248,22,xianmengController.recv_248_22)
socketManager:register_receiver(248,23,xianmengController.recv_248_23)
socketManager:register_receiver(248,24,xianmengController.recv_248_24)
end

function xianmengController:onEnterState_TYSC()
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen_TYSC)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange_TYSC)

notifySystem:listenNotify(notifyConfig.startEndCloud,self.onCloudOpen)
end

function xianmengController:onLeaveState_TYSC(isReconnet)
xianmengModel:clearData_TYSC()
xianmengController:clearMarkData_TYSC()
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen_TYSC)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange_TYSC)
notifySystem:removelistener(notifyConfig.startEndCloud,self.onCloudOpen)
end

function xianmengController:init_TYSC()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eTianYuanShouChao)
if actInfo then
if xianmengModel:hasXM()and actInfo:checkOpen()then
if not xianmengModel:checkInit_TYSC()then
xianmengController:send_248_11()
else
if actInfo:checkDoing()then
xianmengModel:initMonsterList_TYSC()
end
end
end
end
end

function xianmengController.onLimitActOpen_TYSC(actID,flag)
if actID==LIMIT_ACT_TYPE.eTianYuanShouChao and flag and xianmengModel:hasXM()then
xianmengController:send_248_11()
end
end

function xianmengController.onLimitActStateChange_TYSC(actID,state)
if actID~=LIMIT_ACT_TYPE.eTianYuanShouChao then return end
if state==limitActivitiesModel.actPreviewState then




elseif state==limitActivitiesModel.actDoingState then



xianmengModel:clearData_TYSC()

local func=function()
xianmengController:send_248_11()
end
timeEventController.delayDo(1,func)
elseif state==limitActivitiesModel.actFinishState then
local data=xianmengModel:getData_TYSC()

local score=xianmengModel:getNowScore_TYSC()
data.jifenPre=score

local level=xianmengModel:getLevel_TYSC()
data.preLevel=level

local newcfg=cfgHelper.get1(cfg_skyshouchaojibieconfig_get,data.preLevel)
local needScore=newcfg.needJiFen

if needScore>data.jifenPre then
data.level=1
end


end
end

function xianmengController:openSellRewardWin_TYSC()
local isNew=xianmengModel:checkNewSellRewards_TYSC()
if isNew then
xianmengController:send_248_22()
else
UIManager:showWindow('UIXM_TYSC_sellRewardWin')
end
end

function xianmengController:openRankWin_TYSC()
local isNew=xianmengModel:checkNewRank_TYSC()
if isNew then
xianmengModel:setRankListMark_TYSC()
xianmengController:send_248_24()
xianmengController:send_248_21()
else
UIManager:showWindow('UIXM_TYSC_RankWin')
end
end



local markMonster
local markMonsterPos
local continueData
local buyFightData
function xianmengController:getMarkMonster_TYSC()
return markMonster
end
function xianmengController:setMarkMonster_TYSC(data)
markMonster=data
end
function xianmengController:getMarkMonsterPos_TYSC()
return markMonsterPos
end
function xianmengController:setMarkMonsterPos_TYSC(pos)
markMonsterPos=pos
end
function xianmengController:getContinueData_TYSC()
return continueData
end
function xianmengController:setContinueData_TYSC(data)
continueData=data
end
function xianmengController:getBuyFightData_TYSC()
return buyFightData
end
function xianmengController:setBuyFightData_TYSC(data)
buyFightData=data
end
function xianmengController:clearMarkData_TYSC()
xianmengController:setMarkMonster_TYSC(nil)
xianmengController:setMarkMonsterPos_TYSC(nil)
xianmengController:setContinueData_TYSC(nil)
xianmengController:setBuyFightData_TYSC(nil)
end

function xianmengController:doMonsterFight_TYSC(monsterType,monsterGroupId,m_id,score)
local curNum=xianmengModel:getChallengeNum1_TYSC()

if curNum<=0 then
UIManager.error('挑战次数不足')
return
end
xianmengController:doReqFight_TYSC(monsterType,monsterGroupId,m_id,score)
end

function xianmengController:doBossFight_TYSC(monsterType,monsterGroupId,m_id,score)
local monster=xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
local curNum=xianmengModel:getChallengeNum2_TYSC(monster.guid)
if curNum<=0 then
UIManager.error('挑战次数不足')
return
end

score=nil
xianmengController:doReqFight_TYSC(monsterType,monsterGroupId,m_id,score)
end


function xianmengController:showBuyBossDialouge_TYSC(guid,callback)
local slGuild=guid
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local maxBuyNum=shoulingNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum2_TYSC(slGuild)
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
return
end

local costItemID=shoulingNum[3]
local haveNum=itemsModel.getCount(costItemID)
local costNumList=shoulingNum[4]
local canBuyNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+lerpBuyNum do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
if haveNum>=n then
canBuyNum=canBuyNum+1
haveNum=haveNum-n
else
break
end
end



local getCostNum=function(num)
local costItemNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+num do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
costItemNum=costItemNum+n
end
return costItemNum
end
local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买首领挑战次数？',costStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=canBuyNum,
tips=FMT.fmt("（当前可购买次数：{0}）",canBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
if not xianmengController:canFightBoss2_TYSC(slGuild,true)then
return
end
local itemNum=getCostNum(num)
local func=function()
if callback then
callback()
end
xianmengController:send_248_15(slGuild,num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eOnlyWaring)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function xianmengController:showBuyMonDialouge_TYSC(callback)
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shouchaoNum')
local maxBuyNum=shouchaoNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum1_TYSC()
local lerpBuyNum=maxBuyNum-curBuyNum

if lerpBuyNum<=0 then
return false
end

local costItemID=shouchaoNum[3]
local haveNum=itemsModel.getCount(costItemID)
local costNumList=shouchaoNum[4]
local canBuyNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+lerpBuyNum do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
if haveNum>=n then
canBuyNum=canBuyNum+1
haveNum=haveNum-n
else
break
end
end




local getCostNum=function(num)
local costItemNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+num do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
costItemNum=costItemNum+n
end
return costItemNum
end
local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买兽潮挑战次数？',costStr)
return contentStr
end

local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=canBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",canBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
local itemNum=getCostNum(num)
local func=function()
if callback then
callback()
end
xianmengController:send_248_14(num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eOnlyWaring)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function xianmengController:canFightBoss_TYSC(guid,isWarning)
if not xianmengController:canFightBoss2_TYSC(guid,isWarning)then
return false
end
local curNum=xianmengModel:getChallengeNum2_TYSC(guid)
if curNum<=0 then
if isWarning then
UIManager.error('挑战次数不足')
end
return false
end

return true
end

function xianmengController:canFightBoss2_TYSC(guid,isWarning)
local data=xianmengModel:getBossDataByGuid_TYSC(guid)
if data==nil then
if isWarning then
UIManager.error('首领已剿灭')
end
return false
end

return true
end

function xianmengController:canBuyBoss_TYSC(guid,isWarning)
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local maxBuyNum=shoulingNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum2_TYSC(guid)
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
if isWarning then
UIManager.error('购买次数已用完')
end
return false
end












return true
end

function xianmengController:doReqFight_TYSC(monsterType,monsterGroupId,m_id,score)
xianmengController:setContinueData_TYSC(nil)
local monster=xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
local posIdx=monster.posIdx
local monType=monsterType
local gwzId=monsterGroupId
local fight=xianmengModel:getMonsterFight_TYSC(monsterType,m_id)
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local titleStr
if score then
titleStr=FMT.fmt('天渊积分：{0}/只',score)
end
local posX=UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','getMapRootPosX')
xianmengController:setMarkMonsterPos_TYSC(posX)
local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
if limitActivitiesController:checkJump(nil,LIMIT_ACT_TYPE.eTianYuanShouChao)then
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)
local check=monster_~=nil
if check then
local guid_=monster_.guid
if monType~=MONSTER_TYPE.eShouLing then
local markMonster_={monType,posIdx}
xianmengController:setMarkMonster_TYSC(markMonster_)
local continueData_={table.deepCopy(selectList),mapId,zfId,{monType,gwzId,guid_}}
xianmengController:setContinueData_TYSC(continueData_)
else
local continueData_={table.deepCopy(selectList),mapId,zfId,{monType,gwzId,guid_}}
xianmengController:setContinueData_TYSC(continueData_)
end
limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eTianYuanShouChao,'clearRewardList')
local now=timeHelper.getServerShortTime()
xianmengModel:setChallengeStamp(now)
local args={}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)
fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,selectList,mapId,zfId,{monType,gwzId,guid_})
xianmengController:RecordTYSC_ChallengNum(1)
else
if monType==MONSTER_TYPE.eShouLing then
UIManager.error('该首领已被盟友消灭')
end
end
end
end,
enterTxt="天渊兽潮",
cancelCallBack=function()
fightController:closeSelectStage()
xianmengController:finishFightOpen_TYSC()
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
closeByCloud=true,
closeByCloudDelay=0.5,
}
if monsterType==MONSTER_TYPE.eShouLing then
winArgs.monsterFight=fight
winArgs.multiTitleStr=titleStr
else
winArgs.singleFightDescStr=titleStr
end
fightController.showPrepareWin(fightPreSelectModel.fightType.tianyuanshouchao,winArgs)
end

function xianmengController:doReqFight_TYSCquick(monsterType,monsterGroupId,m_id,score)
xianmengController:setContinueData_TYSC(nil)
local monster=xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
local posIdx=monster.posIdx
local monType=monsterType
local gwzId=monsterGroupId
local fight=xianmengModel:getMonsterFight_TYSC(monsterType,m_id)
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local titleStr
if score then
titleStr=FMT.fmt('天渊积分：{0}/只',score)
end
local posX=UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','getMapRootPosX')
xianmengController:setMarkMonsterPos_TYSC(posX)
local winArgs=
{

enterCallBack=function(selectList,zfId,mapId)
if limitActivitiesController:checkJump(nil,LIMIT_ACT_TYPE.eTianYuanShouChao)then
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)
local check=monster_~=nil
if check then
local guid_=monster_.guid
if monType~=MONSTER_TYPE.eShouLing then
local markMonster_={monType,posIdx}


local continueData_={table.deepCopy(selectList),mapId,zfId,{monType,gwzId,guid_}}
xianmengController:setContinueData_TYSC(continueData_)
else
local continueData_={table.deepCopy(selectList),mapId,zfId,{monType,gwzId,guid_}}
xianmengController:setContinueData_TYSC(continueData_)
end
limitActivitiesModel:invokeMethod(LIMIT_ACT_TYPE.eTianYuanShouChao,'clearRewardList')
local now=timeHelper.getServerShortTime()
xianmengModel:setChallengeStamp(now)

UIManager:invokeUIMethod('UIFightPrepareWin',"onCloseFunc")
UIManager.info("保存成功")
else
if monType==MONSTER_TYPE.eShouLing then
UIManager.error('该首领已被盟友消灭')
end
end
end
end,
enterTxt="天渊兽潮",
cancelCallBack=function()
fightController:closeSelectStage()
local Callback=function()


xianmengModel:GeTMonsterData({monType,gwzId,m_id})
end
xianmengController:finishFightOpen_TYSC(nil,Callback)
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
closeByCloud=true,
closeByCloudDelay=0.5,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
}
if monsterType==MONSTER_TYPE.eShouLing then
winArgs.monsterFight=fight
winArgs.multiTitleStr=titleStr
else
winArgs.singleFightDescStr=titleStr
end
fightController.showPrepareWin(fightPreSelectModel.fightType.tianyuanshouchao,winArgs)
end

function xianmengController:finishFightOpen_TYSC(closeCloud,Callback)
limitActivitiesController:jump(LIMIT_ACT_TYPE.eTianYuanShouChao,{closeCloud=closeCloud,Callback=Callback})
end

function xianmengController:finishFight_TYSC(result)
if result~=fightResultType.Victory then
xianmengController:setMarkMonster_TYSC(nil)
end
xianmengController:finishFightOpen_TYSC(true)
end






function xianmengController:send_248_11()
socketManager:send_248_11()
end


function xianmengController:send_248_12(level)

socketManager:send_248_12(level)
end


function xianmengController:send_248_13()
socketManager:send_248_13()
end


function xianmengController:send_248_24()
socketManager:send_248_24(0,0)
end


function xianmengController:send_248_14(buyNum)


if not limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eTianYuanShouChao)or not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eTianYuanShouChao)then
UIManager.error('活动未开启')
return
end

socketManager:send_248_14(buyNum)
end


function xianmengController:send_248_15(slGuid,buyNum)



if not limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eTianYuanShouChao)or not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eTianYuanShouChao)then
UIManager.error('活动未开启')
return
end
socketManager:send_248_15(slGuid,buyNum)
end



function xianmengController:send_248_16(is_assistant)
socketManager:send_248_16(is_assistant or 0)
end


function xianmengController:send_248_21()
socketManager:send_248_21()
end


function xianmengController:send_248_22()
socketManager:send_248_22()
end






function xianmengController.recv_248_11(args)




























local data={}
data.jifenPre=args[1]
data.jifenNow=args[2]
data.jifenMy=args[3]
data.level=args[4]
data.tzNum1=args[5]
data.monDieNum=args[6]
local shoulingList_=args[8]or{}
if#shoulingList_>0 then
for i,sl in ipairs(shoulingList_)do
sl.fight=mathHelper.int64_to_number(sl.fight)
end
end
data.shoulingList=shoulingList_
data.myJiFenReward=args[9]
data.pmpNum=args[10]
data.scBuyNum=args[11]
data.preLevel=args[12]
data.monster1Level=args[13]
data.monster2Level=args[14]
data.scHisNum=args[15]

xianmengModel:initData_TYSC(data)
xianmengModel:initNotes_TYSC(args[17])
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eTianYuanShouChao)then
xianmengModel:initMonsterList_TYSC()
end
local actID=LIMIT_ACT_TYPE.eTianYuanShouChao
local isdoing=limitActivitiesModel:checkActDoing(actID)

if UIManager:isActive('UIXM_TYSC_MainWin')then
if isdoing then
limitActivitiesController:jump(actID)
else
local left=limitActivitiesModel:getActStartLeftTime(actID)
if left<5 then
timeEventController.delayDo(left+1,function()
local isdoing_=limitActivitiesModel:checkActDoing(actID)
if isdoing_ then
limitActivitiesController:jump(actID)
end
end)
end
end
elseif UIManager:isActive('UIXM_TYSC_BattleWin')then
if isdoing then
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','onRefreshView')
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eTianYuanShouChao)
end


function xianmengController.recv_248_12(level)


local data=xianmengModel:getData_TYSC()
if data==nil then return end
if level==-1 then
UIManager.error('活动结算尚未完成')
return
end

data.level=level
UIManager.error('选择成功')

UIManager:invokeUIMethod('UIXM_TYSC_MainWin','rec_select')
UIManager:invokeUIMethod('UIXM_TYSC_LevelInfoWin','rec_select')
end


function xianmengController.recv_248_13(listLen,rankList)








if listLen>1 then
table.sort(rankList,function(a,b)
return a.rank<b.rank
end)
end
xianmengModel:setXMRankList_TYSC(rankList or{})
if xianmengModel:checkOpenRankList_TYSC()then
UIManager:showWindow('UIXM_TYSC_RankWin')
end
end


function xianmengController.recv_248_24(listLen,rankList,page,rankLen)








if listLen>1 then
table.sort(rankList,function(a,b)
return a.rank<b.rank
end)
end
xianmengModel:setXMRankList_TYSC(rankList or{})
if xianmengModel:checkOpenRankList_TYSC()then
UIManager:showWindow('UIXM_TYSC_RankWin')
end
end


function xianmengController.recv_248_14(tzNum,buyNum)



local data=xianmengModel:getData_TYSC()
if data==nil then return end
data.tzNum1=tzNum
data.scBuyNum=buyNum

if not xiaoZhuShouController:checkRunning()then
UIManager.info('购买成功')
end
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','recv_buy')

local fightData=xianmengController:getBuyFightData_TYSC()
if fightData~=nil then
xianmengController:setBuyFightData_TYSC(nil)
local func=function()

xianmengController:finishFightOpen_TYSC()
xianmengController:setContinueData_TYSC(fightData)
local args={isSkip=true}
local now=timeHelper.getServerShortTime()
xianmengModel:setChallengeStamp(now)
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)
fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,fightData[1],fightData[2],fightData[3],fightData[4])
xianmengController:RecordTYSC_ChallengNum(1)
end
loadingControl.openCloud(func,10)
end
UIManager:invokeUIMethod('UIXM_TYSCquickWin','refreshRightWin')
UIManager:invokeUIMethod('UIXM_TYSCquickWin','quicktimer',tzNum)
end


function xianmengController.recv_248_15(slGuid,tzNum,buyNum)




local sldata=xianmengModel:getBossDataByGuid_TYSC(slGuid)
if sldata==nil then return end

sldata.tzNum=tzNum
sldata.buyNum=buyNum

if not xiaoZhuShouController:checkRunning()then
UIManager.info('购买成功')
end
UIManager:invokeUIMethod('UIXM_TYSC_bossWin','recv_buy')
local fightData=xianmengController:getBuyFightData_TYSC()
if fightData~=nil then
xianmengController:setBuyFightData_TYSC(nil)
local func=function()

xianmengController:finishFightOpen_TYSC()
xianmengController:setContinueData_TYSC(fightData)
local args={isSkip=true}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)
local now=timeHelper.getServerShortTime()
xianmengModel:setChallengeStamp(now)
fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,fightData[1],fightData[2],fightData[3],fightData[4])
xianmengController:RecordTYSC_ChallengNum(1)
end
loadingControl.openCloud(func,10)
end
UIManager:invokeUIMethod('UIXM_TYSCquickWin','refreshRightWin')
UIManager:invokeUIMethod('UIXM_TYSCquickWin','quicktimer',xianmengModel:getChallengeNum2_TYSC(slGuid))
if UIManager:isActive("UIXM_TYSCquickWin")then
UIManager.info("开始挑战")
end
end



function xianmengController.recv_248_16(jifen,is_assistant)

local data=xianmengModel:getData_TYSC()
if data==nil then return end
data.myJiFenReward=jifen

UIManager:invokeUIMethod('UIXM_TYSC_RankWin','recv_reward')
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','recv_reward')
UIManager:invokeUIMethod('UIXM_TYSC_MainWin','recv_reward')
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eTianYuanShouChao)
end


function xianmengController.recv_248_17(killNum,xmJiFen,myJiFen,pmpNum)





local data=xianmengModel:getData_TYSC()
if data==nil then return end
data.monDieNum=killNum
data.jifenNow=xmJiFen
data.jifenMy=myJiFen
data.pmpNum=pmpNum

UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','recv_score_change')
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eTianYuanShouChao)
end


function xianmengController.recv_248_18(shouling,scHisNum)



if not xianmengModel:checkInit_TYSC()then return end
if not xianmengModel:checkInitMonster_TYSC()then return end

xianmengModel:setRefreshBossNum_TYSC(scHisNum)
shouling.fight=mathHelper.int64_to_number(shouling.fight)

local flag=xianmengModel:updataBossList_TYSC(shouling,CHANGE_TYPE.eAdd)
if flag then
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','recv_boss_change')
UIManager:invokeUIMethod('UILimitActStorageWin','refreshTipsShow',LIMIT_ACT_TYPE.eTianYuanShouChao)
end
end


function xianmengController.recv_248_19(shouling)


if not xianmengModel:checkInit_TYSC()then return end
if not xianmengModel:checkInitMonster_TYSC()then return end

shouling.fight=mathHelper.int64_to_number(shouling.fight)

local flag=xianmengModel:updataBossList_TYSC(shouling,CHANGE_TYPE.eChanged)
if flag then
UIManager:invokeUIMethod('UIXM_TYSC_bossWin','recv_blood_change')
end
end


function xianmengController.recv_248_20(shouling)


if not xianmengModel:checkInit_TYSC()then return end
if not xianmengModel:checkInitMonster_TYSC()then return end

local flag=xianmengModel:updataBossList_TYSC(shouling,CHANGE_TYPE.eDelete)
if flag then
UIManager:invokeUIMethod('UIXM_TYSC_BattleWin','recv_boss_change')
UIManager:invokeUIMethod('UIXM_TYSC_bossWin','recv_boss_dead',shouling.guid)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshTipsShow',LIMIT_ACT_TYPE.eTianYuanShouChao)
end
end


function xianmengController.recv_248_21(listLen,rankList)








table.sort(rankList,function(a,b)
local isRank1=a.rank and a.rank>0
local isRank2=b.rank and b.rank>0
if not isRank1 and not isRank2 then
local fightvalue1=a.fightvalue and mathHelper.int64_to_number(a.fightvalue)or 0
local fightvalue2=b.fightvalue and mathHelper.int64_to_number(b.fightvalue)or 0
return fightvalue1>fightvalue2
end
local sortWeight1=not isRank1 and 100000 or 0
local sortWeight2=not isRank2 and 100000 or 0
return sortWeight1+a.rank<sortWeight2+b.rank
end)
xianmengModel:setmemberRankList_TYSC(rankList or{})
if xianmengModel:checkOpenRankList_TYSC()then
UIManager:showWindow('UIXM_TYSC_RankWin')
end
end


function xianmengController.recv_248_22(listLen,itemList)




xianmengModel:setSellRewards_TYSC(itemList or{})
UIManager:showWindow('UIXM_TYSC_sellRewardWin')
end


function xianmengController.recv_248_23(note)


xianmengModel:setNotesNew_TYSC(note)
end



function xianmengController.onCloudOpen()

end


function xianmengController:RecordTYSC_ChallengNum(num)
local lastnum=xianmengController:loadTYSC_ChallengNum()
userActorSetting.set("TYSC_ChallengNum",{nownum=lastnum+num})
userActorSetting.flush()
end

function xianmengController:loadTYSC_ChallengNum()
local record=userActorSetting.get("TYSC_ChallengNum",{})
return record["nownum"]or 0
end