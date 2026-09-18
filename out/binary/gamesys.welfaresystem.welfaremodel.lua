











welfareModel={}




welfareModel.data={}


WELFARE_CHECK_OPEN_FUN={
[FULL_TAB_TYPE.eDailySignIn]=function()

return systemModel.isOpen(SYSTEM_DEFINE.eEveryDayQianDao)
end,
[FULL_TAB_TYPE.eSevenDaySignIn]=function()

return systemModel.isOpen(SYSTEM_DEFINE.eSevenDayQianDao)and not welfareModel:checkSevenDaySignInFinish()
end,
[FULL_TAB_TYPE.eZongmenLevelInvestor]=function()

if verifyManager:isHideBusinessActivity()then
return false
end
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
return false
end

return systemModel.isOpen(SYSTEM_DEFINE.eGuildInvest)and not welfareModel:checkZongmenLevelInvestorEnd()
end,
[FULL_TAB_TYPE.eZongmenLevelInvestor2]=function()

if verifyManager:isHideBusinessActivity()then
return false
end
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
return false
end

return systemModel.isOpen(SYSTEM_DEFINE.eGuildInvest2)and not welfareModel:checkZongmenLevelInvestorEnd2()
end,
[FULL_TAB_TYPE.eKaiZongZengLi]=function()

return systemModel.isOpen(SYSTEM_DEFINE.eGuildGift)and not welfareModel:checkKaiZongAllGot()
end,
[FULL_TAB_TYPE.eLoginReward]=function()

return welfareModel:checkInLoginRewarTime()
end,
[FULL_TAB_TYPE.eDailyRebate]=function()

return welfareModel:checkDailyRebateEnterOpen()
end,
[FULL_TAB_TYPE.eCdKey]=function()
if verifyManager:isOpen()and(deviceHelper.isRunIOS()or deviceHelper.isRunAndroid())then
return false
end

if not systemModel.isOpen(SYSTEM_DEFINE.eCdKey)then
return false
end
return true
end,
[FULL_TAB_TYPE.eYaoQingMa]=function()

return welfareModel:isOpenYaoQingMa()
end,
[FULL_TAB_TYPE.eXianYuanShare]=function()

return welfareModel:isOpenYaoQingMa()and not xianyuanShareModel:isFuncOver()
end,
[FULL_TAB_TYPE.eSheQuAct]=function()

return shequModel:isHasSheQuAct()
end,
[FULL_TAB_TYPE.eSheQuAct2]=function()

return shequModel:isHasSheQuAct2()
end,
[FULL_TAB_TYPE.eSheQuAct3]=function()

return shequModel:isHasSheQuAct3()
end,
[FULL_TAB_TYPE.eGuanZhuAct]=function()

return welfareModel:checkGuanZhuActOpen()
end,
[FULL_TAB_TYPE.eWeekendWelfare]=function()

return welfareModel:checkWeekendWelfareOpen()
end,
[FULL_TAB_TYPE.eXianYouZhaoHui]=function()

return welfareModel:checkXianYouZhaoHuiOpen()
end,
[FULL_TAB_TYPE.eHuiGuiBangDing]=function()

return welfareModel:checkHuiGuiBangDingOpen()
end,
[FULL_TAB_TYPE.eWXGameCircle]=function()

return welfareModel:checkWXGameCircleOpen()
end,
[FULL_TAB_TYPE.eActivityCalendar]=function()

return welfareController:checkActivityCalendarOpen()
end,
[FULL_TAB_TYPE.eWXAddReward]=function()

return welfareController:checkWXAddRewardTabOpen()
end,
[FULL_TAB_TYPE.eHaoPingYouLi]=function()
if verifyManager:isOpen()then
return false
end
if pfwindowslController:checkIsGameVersion_yuenan()then
return false
end

return pfwindowslController:canVisiableHaoPingYouLi()
end,
[FULL_TAB_TYPE.eChangeAct]=function()

return ChangeActController:checkHDisOpen()
end,
[FULL_TAB_TYPE.eJiFenShangChengFT]=function()

return systemModel.isOpen(SYSTEM_DEFINE.eJiFenShangChengFT)
end,
[FULL_TAB_TYPE.eChangeBaoZhiYin]=function()

return ChangeActController:checkHBZYOpen()
end,
}

INVITATION_CODE_MIN_POS_COUNT=6


function welfareModel:onAppStart()

end


function welfareModel:onEnterState()
self.data.dailySignIn={}
self.data.sevenDaySignIn={}
self.data.zongmenLevelInvestor={}
self.data.loginRewardData={}
self.data.zongmenLevelInvestor2={}
end


function welfareModel:onLeaveState()

self.data={}
end


function welfareModel:onServerDataInitFinish()

end

function welfareModel:onProtocolReq()

end





function welfareModel:setDailySignInData(arg)
self.data.dailySignIn.roundId=arg[1]
self.data.dailySignIn.signInDayCount=arg[2]
self.data.dailySignIn.gotRewardListLen=arg[3]
self.data.dailySignIn.gotRewardList=arg[4]
self.data.dailySignIn.leijiDay=arg[5]
self.data.dailySignIn.leijiRewardFlag=arg[6]
self.data.dailySignIn.leijiConfId=arg[7]
end


function welfareModel:setDailySignInRewardList(rwListLen,rwList)
self.data.dailySignIn.gotRewardListLen=rwListLen
self.data.dailySignIn.gotRewardList=rwList
end


function welfareModel:setDailySignInLeiJiRewardFlag(result)
if result==0 then
self.data.dailySignIn.leijiRewardFlag=1
end
end


function welfareModel:getDailySignInData()
if self.data.dailySignIn and next(self.data.dailySignIn)then
return self.data.dailySignIn
else
return nil
end
end


function welfareModel:checkDailySignInReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eDailySignIn]()then
return false
end
if self.data.dailySignIn and next(self.data.dailySignIn)then
if self.data.dailySignIn.signInDayCount>self.data.dailySignIn.gotRewardListLen then
return true
end

local rewardTargetDay=cfgHelper.get2(cfg_everydayqiandaoleijiconfig_get,self.data.dailySignIn.leijiConfId,"rewards")[1]
if self.data.dailySignIn.leijiDay>=rewardTargetDay and self.data.dailySignIn.leijiRewardFlag==0 then
return true
end
end
return false
end

function welfareModel:checkDailySignInReddot_hasSignInReward()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eDailySignIn]()then
return false
end
if self.data.dailySignIn and next(self.data.dailySignIn)then
if self.data.dailySignIn.signInDayCount>self.data.dailySignIn.gotRewardListLen then
return true
end
end
return false
end

function welfareModel:checkDailySignInReddot_hasLeiJiReward()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eDailySignIn]()then
return false
end
if self.data.dailySignIn and next(self.data.dailySignIn)then
local rewardTargetDay=cfgHelper.get2(cfg_everydayqiandaoleijiconfig_get,self.data.dailySignIn.leijiConfId,"rewards")[1]
if self.data.dailySignIn.leijiDay>=rewardTargetDay and self.data.dailySignIn.leijiRewardFlag==0 then
return true
end
end
return false
end

function welfareModel:checkLoginRewardReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eLoginReward]()then
return false
end

local data=welfareModel:getLoginRewardData()
if not data or data.id==0 then
return false
end
local btime=data.beginTime
local ctime=gameUtilityModel.getServerShortTime()
local dtime=ctime-btime
local day=math.ceil(dtime/86400)
local isPaid=data.recharge_id>0
local cfg=cfgHelper.get1(cfg_logingiftconfig_get,data.id)
if cfg then
for i=1,day do
if cfg.login_gift[i]and(i>data.recv_day1 or(isPaid and i>data.recv_day2))then
return true
end
end
end
return false
end


function welfareModel:getDailySignInRewardByDayRange(startDay,endDay)
if not self.data.dailySignIn or next(self.data.dailySignIn)==nil then
return nil
end


local round=self.data.dailySignIn.roundId or 1
local rwCfg=cfgHelper.get1(cfg_everydayqiandaoconfig_get,round).rewards
local zongmenLv=zongmenModel:getLevel()
local rewardList={}
for i=startDay,endDay do
if rwCfg[i]then
local tmpCfg=rwCfg[i]
local tmpRewardList=nil
for k,v in ipairs(tmpCfg)do
if v[1]<=zongmenLv and v[2]>=zongmenLv then
tmpRewardList=v[3]
break
end
end

if tmpRewardList and next(tmpRewardList)then
local key,nextReward=next(tmpRewardList)
if type(nextReward)=='table'then

for k,v in ipairs(tmpRewardList)do
table.insert(rewardList,v)
end
else

table.insert(rewardList,tmpRewardList)
end
end
end
end

return rewardList
end


function welfareModel:getDailySignInLeiJiReward()
if not self.data.dailySignIn or next(self.data.dailySignIn)==nil then
return nil
end


local rewardCfg=cfgHelper.get2(cfg_everydayqiandaoleijiconfig_get,self.data.dailySignIn.leijiConfId,"rewards")
local rewardList=rewardCfg[2]

return rewardList
end




function welfareModel:setSevenDaySignInData(qdListLen,qdList)
self.data.sevenDaySignIn.signInDayListLen=qdListLen
self.data.sevenDaySignIn.signInDayList=qdList or{}
end


function welfareModel:getSevenDaySignInData()
if self.data.sevenDaySignIn and next(self.data.sevenDaySignIn)then
return self.data.sevenDaySignIn
else
return nil
end
end


function welfareModel:checkSevenDaySignInReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eSevenDaySignIn]()then
return false
end
local reddot=false
if self.data.sevenDaySignIn and next(self.data.sevenDaySignIn)then
for k,v in pairs(self.data.sevenDaySignIn.signInDayList)do
if v.rewardFlag==0 then
reddot=true
break
end
end
end
return reddot
end


function welfareModel:checkSevenDaySignInFinish()
local isFinish=false
if self.data.sevenDaySignIn and next(self.data.sevenDaySignIn)then
if self.data.sevenDaySignIn.signInDayListLen>=7 and self.data.sevenDaySignIn.signInDayList[7].rewardFlag==1 then
isFinish=true
end
end
return isFinish
end


function welfareModel:getSevenDaySignInRewardByDayRange(startDay,endDay)
if not self.data.sevenDaySignIn or next(self.data.sevenDaySignIn)==nil then
return nil
end


local rwCfg=cfg_sevendayqiandaoconfig()
local rewardList={}
for i=startDay,endDay do
if rwCfg[i]then
local tmpCfg=rwCfg[i].rewards

if tmpCfg and next(tmpCfg)then
local key,nextReward=next(tmpCfg)
if type(nextReward)=='table'then

for k,v in ipairs(tmpCfg)do
table.insert(rewardList,v)
end
else

table.insert(rewardList,tmpCfg)
end
end
end
end

return rewardList
end




function welfareModel:setZongmenLevelInvestorData(len,gotRewardList,recharge_id)
if len and len>0 then
self.data.zongmenLevelInvestor.taskStateList={}
self.data.zongmenLevelInvestor.allRewardGotTaskCount=0
for _,v in pairs(gotRewardList)do
if v.len and v.len>0 then
for i,taskId in pairs(v.task_lst)do
if not self.data.zongmenLevelInvestor.taskStateList[taskId]or v.invest_type==2 then
self.data.zongmenLevelInvestor.taskStateList[taskId]=v.invest_type
if v.invest_type==2 then
self.data.zongmenLevelInvestor.allRewardGotTaskCount=self.data.zongmenLevelInvestor.allRewardGotTaskCount+1
end
end
end
end
end

end
self.data.zongmenLevelInvestor.recharge_id=recharge_id
end


function welfareModel:getZongmenLevelInvestorData()
if self.data.zongmenLevelInvestor and next(self.data.zongmenLevelInvestor)then
return self.data.zongmenLevelInvestor
end

return nil
end


function welfareModel:checkZongmenLevelInvestorBuy()
local isBuy=false
if self.data.zongmenLevelInvestor and next(self.data.zongmenLevelInvestor)then
if self.data.zongmenLevelInvestor.recharge_id and self.data.zongmenLevelInvestor.recharge_id~=0 then
local cfg=cfgHelper.get1(cfg_guildinvestbasicconfig_get,1)
local chaozhiRechargeId=cfg.recharge_id
if self.data.zongmenLevelInvestor.recharge_id==chaozhiRechargeId then
isBuy=true
else
logErr(FMT.fmt("下发的充值id:{0} 与配置中的充值id:{1} 不匹配",self.data.zongmenLevelInvestor.recharge_id,chaozhiRechargeId))
end
end
end
return isBuy
end





function welfareModel:checkZongmenLevelInvestorTaskStateByTaskId(taskId)
local taskState=0
if self.data.zongmenLevelInvestor.taskStateList and next(self.data.zongmenLevelInvestor.taskStateList)then
if self.data.zongmenLevelInvestor.taskStateList[taskId]then
taskState=self.data.zongmenLevelInvestor.taskStateList[taskId]
end
end
return taskState
end


function welfareModel:setZongmenLevelInvestorTaskStateByTaskId(taskId)
if not self.data.zongmenLevelInvestor.taskStateList then
self.data.zongmenLevelInvestor.taskStateList={}
end


local isBuy=welfareModel:checkZongmenLevelInvestorBuy()
local state=isBuy and 2 or 1
self.data.zongmenLevelInvestor.taskStateList[taskId]=state
if isBuy then

self.data.zongmenLevelInvestor.allRewardGotTaskCount=self.data.zongmenLevelInvestor.allRewardGotTaskCount+1
end
end



function welfareModel:checkZongmenLevelInvestorEnd()
local isEnd=false

if not welfareModel:checkZongmenLevelInvestorBuy()then

return isEnd
end


local allTaskCfg=cfg_guildinvestconfig()
local allTaskCount=#allTaskCfg
if self.data.zongmenLevelInvestor.allRewardGotTaskCount and self.data.zongmenLevelInvestor.allRewardGotTaskCount>=allTaskCount then

isEnd=true
end

return isEnd
end


function welfareModel:checkZongmenLevelInvestorReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eZongmenLevelInvestor]()then
return false
end


local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eGuildInvest)
if not isOpen then

return false
end

local allTaskCfg=cfg_guildinvestconfig()
local zmLevel=zongmenModel:getLevel()
local isBuy=welfareModel:checkZongmenLevelInvestorBuy()
local reddotRuleState=isBuy and 1 or 0
for i=1,#allTaskCfg do
local needCount=allTaskCfg[i].aimnum
if zmLevel>=needCount then

local taskState=welfareModel:checkZongmenLevelInvestorTaskStateByTaskId(allTaskCfg[i].id)
if taskState<=reddotRuleState then
return true
end
end
end

return false
end


function welfareModel:setZongmenLevelInvestorData2(len,gotRewardList,recharge_id)
if len and len>0 then
self.data.zongmenLevelInvestor2.taskStateList={}
self.data.zongmenLevelInvestor2.allRewardGotTaskCount=0
for _,v in pairs(gotRewardList)do
if v.len and v.len>0 then
for i,taskId in pairs(v.task_lst)do
if not self.data.zongmenLevelInvestor2.taskStateList[taskId]or v.invest_type==2 then
self.data.zongmenLevelInvestor2.taskStateList[taskId]=v.invest_type
if v.invest_type==2 then
self.data.zongmenLevelInvestor2.allRewardGotTaskCount=self.data.zongmenLevelInvestor2.allRewardGotTaskCount+1
end
end
end
end
end

end
self.data.zongmenLevelInvestor2.recharge_id=recharge_id
end


function welfareModel:getZongmenLevelInvestorData2()
if self.data.zongmenLevelInvestor2 and next(self.data.zongmenLevelInvestor2)then
return self.data.zongmenLevelInvestor2
end

return nil
end


function welfareModel:checkZongmenLevelInvestorBuy2()
local isBuy=false
if self.data.zongmenLevelInvestor2 and next(self.data.zongmenLevelInvestor2)then
if self.data.zongmenLevelInvestor2.recharge_id and self.data.zongmenLevelInvestor2.recharge_id~=0 then
local chaozhiRechargeId=cfgHelper.getdef(cfg_guildinvest2config,"recharge_id")

if self.data.zongmenLevelInvestor2.recharge_id==chaozhiRechargeId then
isBuy=true
else
logErr(FMT.fmt("下发的充值id:{0} 与配置中的充值id:{1} 不匹配",self.data.zongmenLevelInvestor2.recharge_id,chaozhiRechargeId))
end
end
end
return isBuy
end





function welfareModel:checkZongmenLevelInvestorTaskStateByTaskId2(taskId)
local taskState=0
if self.data.zongmenLevelInvestor2.taskStateList and next(self.data.zongmenLevelInvestor2.taskStateList)then
if self.data.zongmenLevelInvestor2.taskStateList[taskId]then
taskState=self.data.zongmenLevelInvestor2.taskStateList[taskId]
end
end
return taskState
end


function welfareModel:setZongmenLevelInvestorTaskStateByTaskId2(taskId)
if not self.data.zongmenLevelInvestor2.taskStateList then
self.data.zongmenLevelInvestor2.taskStateList={}
end


local isBuy=welfareModel:checkZongmenLevelInvestorBuy2()
local state=isBuy and 2 or 1
self.data.zongmenLevelInvestor2.taskStateList[taskId]=state
if isBuy then

self.data.zongmenLevelInvestor2.allRewardGotTaskCount=self.data.zongmenLevelInvestor2.allRewardGotTaskCount+1
end
end



function welfareModel:checkZongmenLevelInvestorEnd2()
local isEnd=false

if not welfareModel:checkZongmenLevelInvestorBuy2()then

return isEnd
end


local allTaskCfg=cfg_guildinvest2config()
local allTaskCount=#allTaskCfg
if self.data.zongmenLevelInvestor2.allRewardGotTaskCount and self.data.zongmenLevelInvestor2.allRewardGotTaskCount>=allTaskCount then

isEnd=true
end

return isEnd
end

function welfareModel:checkZongmenLevelInvestorReddot2()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eZongmenLevelInvestor2]()then
return false
end


local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eGuildInvest2)
if not isOpen then

return false
end

local allTaskCfg=cfg_guildinvest2config()
local zmLevel=zongmenModel:getLevel()
local isBuy=welfareModel:checkZongmenLevelInvestorBuy2()
local reddotRuleState=isBuy and 1 or 0
for i=1,#allTaskCfg do
local needCount=allTaskCfg[i].aimnum
if zmLevel>=needCount then

local taskState=welfareModel:checkZongmenLevelInvestorTaskStateByTaskId2(allTaskCfg[i].id)
if taskState<=reddotRuleState then
return true
end
end
end

return false
end






function welfareModel:checkCdKeyReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eCdKey]()then
return false
end
local cdkeyGuideFinish=welfareModel:getCdKeyGuideFinishMark()
if not cdkeyGuideFinish then
return true
end
return false
end


function welfareModel:setCdKeyGuideFinishMark()
local newbieId=500001
newbieModel.setFinish(newbieId)
end


function welfareModel:getCdKeyGuideFinishMark()
local newbieId=500001
return newbieModel.isFinish(newbieId)
end


function welfareModel:getDefaultCdKey_sortById()
local cdKeyStr=""
local realCdKeyStr=""

local config=cfg_servercdkey()
local cdKeyList={}
for i,v in pairs(config)do
local weight=math.abs(v.id)
cdKeyList[#cdKeyList+1]={id=v.id,weight=weight,cfg=v}
end

table.sort(cdKeyList,function(a,b)
return a.weight<b.weight
end)

local gameVersion=pfwindowslController:getGameVersion()
for i,v in ipairs(cdKeyList)do
local cfg=v.cfg
local keystr=cfg.keystr
local keystr_version=cfg.keystr_version
local str
if keystr_version and keystr_version[gameVersion]then
str=keystr_version[gameVersion]
else
str=keystr
end
if pfwindowslController:checkIsGameVersion_yuenan()then
cdKeyStr=FMT.fmt("{0}\n{1}",cdKeyStr,str)
realCdKeyStr=FMT.fmt("{0}\n{1}",realCdKeyStr,keystr)
else
cdKeyStr=FMT.fmt("{0}\n {1}",cdKeyStr,str)
realCdKeyStr=FMT.fmt("{0}\n {1}",realCdKeyStr,keystr)
end
end

return cdKeyStr,realCdKeyStr
end




function welfareModel:setKaiZongGiftFlag(flagList)
self.data.KaiZongGiftFlag=flagList
end

function welfareModel:setKaiZongGiftAgainFlag(flagList)
self.data.KaiZongGiftAgainFlag=flagList
end

function welfareModel:checkKaiZongGiftGot(id)
local flagList=self.data.KaiZongGiftFlag
if flagList then
local bei=math.floor(id/32)
local flag=flagList[bei+1]
if flag then
return bitHelper.check_pos(flag,(id-bei*32)-1)
end
end
return false
end

function welfareModel:getAgainNum(diziJJCountList,condLv)
local count=0
for lv,c in pairs(diziJJCountList)do
if lv>=condLv then
count=count+c
end
end
return count
end

function welfareModel:checkKaiZongGiftAgainGot(id)
local flagList=self.data.KaiZongGiftAgainFlag
if flagList then
local bei=math.floor(id/32)
local flag=flagList[bei+1]
if flag then
return bitHelper.check_pos(flag,(id-bei*32)-1)
end
end
return false
end

function welfareModel:checkKaiZongReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eKaiZongZengLi]()then
return false
end

if not systemModel.isOpen(SYSTEM_DEFINE.eGuildGift)then
return false
end
local level=zongmenModel:getLevel()
local diziJJCountList=UIDiscipleModel:getDiscipleCount_Jingjie()
local cfg=cfg_guildgiftconfig()
for i,v in ipairs(cfg)do
local id=v.id
local conditions=v.conditions
local condLv=0
for _,vv in ipairs(conditions)do
if vv[1]==1 then
condLv=vv[2]
break
end
end
local isGot=welfareModel:checkKaiZongGiftGot(id)
local isFinish=level>=condLv
local jjGet=welfareModel:checkKaiZongAgainGet(diziJJCountList,v)
if(isFinish and not isGot)or jjGet then
return true
end
end
return false
end

function welfareModel:checkKaiZongGet(level,cfg)
local id=cfg.id
local conditions=cfg.conditions
local condLv=0
for _,v in ipairs(conditions)do
if v[1]==1 then
condLv=v[2]
break
end
end
local isGot=welfareModel:checkKaiZongGiftGot(id)
local isFinish=level>=condLv

return isFinish and not isGot
end

function welfareModel:checkKaiZongAgainGet(diziJJCountList,cfg)
local id=cfg.id

local isFinish=false

local again_conditions=cfg.again_conditions
for _,v in ipairs(again_conditions)do
if v[1]==1 then
local count=welfareModel:getAgainNum(diziJJCountList,v[2])

isFinish=count>=v[3]
break
end
end
local isGot=welfareModel:checkKaiZongGiftGot(id)
local isGotAgain=welfareModel:checkKaiZongGiftAgainGot(id)
return isFinish and isGot and not isGotAgain
end

function welfareModel:checkKaiZongGotMaxIndex()
local index=0
local level=zongmenModel:getLevel()
local diziJJCountList=UIDiscipleModel:getDiscipleCount_Jingjie()
local cfg=cfg_guildgiftconfig()
for i,v in ipairs(cfg)do
local expGot=welfareModel:checkKaiZongGet(level,v)
local jjGot=welfareModel:checkKaiZongAgainGet(diziJJCountList,v)
if(expGot or jjGot)and v.id>index then
index=v.id
end
end
return index
end

function welfareModel:checkKaiZongAllGot()
if not systemModel.isOpen(SYSTEM_DEFINE.eGuildGift)then
return false
end
local cfg=cfg_guildgiftconfig()
for i,v in ipairs(cfg)do
local id=v.id
local isGot=welfareModel:checkKaiZongGiftGot(id)
local isGotAgain=welfareModel:checkKaiZongGiftAgainGot(id)
if(not isGot)or(not isGotAgain)then
return false
end
end
return true
end




function welfareModel:checkInLoginRewarTime()
if not systemModel.isOpen(SYSTEM_DEFINE.eLoginGift)then
return false
end
local data=welfareModel:getLoginRewardData()
if not data or data.id==0 then
return false
end
local btime=data.beginTime
local cfg=cfgHelper.get1(cfg_logingiftconfig_get,data.id)
if not cfg then
return false
end
local etime=btime+cfg.duration*86400
local dt=etime-gameUtilityModel.getServerShortTime()
return dt>0,dt
end

function welfareModel:setLoginRewardData(datas)
local data={}
data.id=datas[1]
data.beginTime=datas[2]
data.recv_day1=datas[4]
data.recv_day2=datas[3]
data.recharge_id=datas[5]
data.level=datas[6]
self.data.loginRewardData.data=data
end

function welfareModel:getLoginRewardData()
return self.data.loginRewardData.data
end




function welfareModel:setDailyRebateData(len,rebateDataList)
self.data.rebateData={}
if len and len>0 then
for _,v in pairs(rebateDataList)do
local gradeId=v.dcId
self.data.rebateData[gradeId]={
gradeId=gradeId,
roundIndex=v.lcIdIndex,
freeRewardGotFlag=v.freeFlag and bitHelper.check_pos(v.freeFlag,0)or false,
maxGotDay=v.rwMaxDay or 0,
rechargeDay=v.czDays or 0,
openActZmLevel=v.playerLevel,
isEndAct=v.endFlag and bitHelper.check_pos(v.endFlag,0)or false,
}
end
end
end


function welfareModel:getDailyRebateData()
if self.data.rebateData and next(self.data.rebateData)then
return self.data.rebateData
end

return nil
end


function welfareModel:getDailyRebateDataByGradeId(gradeId)
if self.data.rebateData and next(self.data.rebateData)then
return self.data.rebateData[gradeId]
end

return nil
end


function welfareModel:setDailyRebateGradeData(gradeId)
if not self.data.rebateData then
self.data.rebateData={}
return
end

local data={
gradeId=gradeId,
roundIndex=1,
freeRewardGotFlag=false,
maxGotDay=0,
rechargeDay=0,
openActZmLevel=zongmenModel:getLevel(),
isEndAct=false,
}
self.data.rebateData[gradeId]=data
end


function welfareModel:setDailyRebateFreeRewardGotFlag(gradeId,roundIndex,freeFlag)
if not self.data.rebateData or not next(self.data.rebateData)then
return
end

if self.data.rebateData[gradeId]and self.data.rebateData[gradeId].roundIndex==roundIndex then
self.data.rebateData[gradeId].freeRewardGotFlag=freeFlag and bitHelper.check_pos(freeFlag,0)or false
end
end


function welfareModel:getDailyRebateFreeRewardGotFlag(gradeId)
if not self.data.rebateData or not next(self.data.rebateData)then
return false
end

if self.data.rebateData[gradeId]then
return self.data.rebateData[gradeId].freeRewardGotFlag or false
end
return false
end


function welfareModel:setDailyRebateMaxGotDay(gradeId,roundIndex,maxGotDay)
if not self.data.rebateData or not next(self.data.rebateData)then
return
end

if self.data.rebateData[gradeId]and self.data.rebateData[gradeId].roundIndex==roundIndex then
self.data.rebateData[gradeId].maxGotDay=maxGotDay or 0
end
end


function welfareModel:getDailyRebateMaxGotDay(gradeId)
if not self.data.rebateData or not next(self.data.rebateData)then
return 0
end

if self.data.rebateData[gradeId]then
return self.data.rebateData[gradeId].maxGotDay or 0
end
return 0
end


function welfareModel:getDailyRebateRechargeDay(gradeId)
if not self.data.rebateData or not next(self.data.rebateData)then
return 0
end

if self.data.rebateData[gradeId]then
return self.data.rebateData[gradeId].rechargeDay or 0
end
return 0
end


function welfareModel:getDailyRebateOpenActZmLevel(gradeId)
if not self.data.rebateData or not next(self.data.rebateData)then
return nil
end

if self.data.rebateData[gradeId]then
return self.data.rebateData[gradeId].openActZmLevel
end
return nil
end


function welfareModel:getDailyRebateEndFlag(gradeId)
if not self.data.rebateData or not next(self.data.rebateData)then
return false
end

if self.data.rebateData[gradeId]then
return self.data.rebateData[gradeId].isEndAct or false
end
return false
end


function welfareModel:checkDailyRebateGradeIsOpen(gradeId,isCheckGot)
if not self.data.rebateData or not next(self.data.rebateData)then
return false
end

if not self.data.rebateData[gradeId]then
return false
end

local isEnd=welfareModel:getDailyRebateEndFlag(gradeId)
if isEnd then
return false
end

local isOpen=welfareModel:checkDailyRebateGradeOpenLimit(gradeId)
if not isOpen then
return false
end

if isCheckGot then

local maxGotDay=welfareModel:getDailyRebateMaxGotDay(gradeId)
local goalTypeCfg=cfgHelper.get1(cfg_tiantianfanlidangciactconfig_get,gradeId)
local roundIndex=self.data.rebateData[gradeId].roundIndex
local roundId=goalTypeCfg.lunci[roundIndex]
local allLevelTaskCfgList_lookup=cfgHelper.get2(cfg_tiantianfanlilunciactconfig_get,roundId,'czlist')
local maxDay=0
for targetDay,cfg in pairs(allLevelTaskCfgList_lookup)do
if targetDay>maxDay then
maxDay=targetDay
end
end
return maxGotDay<maxDay
end

return true
end


function welfareModel:checkDailyRebateGradeOpenLimit(gradeId)
local isOpen=true
local goalTypeCfg=cfgHelper.get1(cfg_tiantianfanlidangciactconfig_get,gradeId)
if goalTypeCfg then
local openLimitCfgList=goalTypeCfg.openLimit
if openLimitCfgList then
local openLimit=pfwindowsModel:getVersionAndPfCfg(openLimitCfgList)
if openLimit then
local openDayLimit=openLimit[1]
local openLevelLimit=openLimit[2]
local openDay=timeHelper.getServerOpenDay()
local zmLevel=zongmenModel:getLevel()
isOpen=openDay>=openDayLimit and zmLevel>=openLevelLimit
end
end
else
isOpen=false
end

return isOpen
end


function welfareModel:checkDailyRebateGradeReddot(gradeId)
if not self.data.rebateData or not next(self.data.rebateData)then
return false
end

if not self.data.rebateData[gradeId]then
return false
end

local isOpenGrade=welfareModel:checkDailyRebateGradeIsOpen(gradeId)
if not isOpenGrade then
return false
end


local isGotFreeReward=welfareModel:getDailyRebateFreeRewardGotFlag(gradeId)
if not isGotFreeReward then
return true
end

local maxGotDay=welfareModel:getDailyRebateMaxGotDay(gradeId)
local rechargeDay=welfareModel:getDailyRebateRechargeDay(gradeId)
local goalTypeCfg=cfgHelper.get1(cfg_tiantianfanlidangciactconfig_get,gradeId)
local roundIndex=self.data.rebateData[gradeId].roundIndex
local roundId=goalTypeCfg.lunci[roundIndex]
local allLevelTaskCfgList_lookup=cfgHelper.get2(cfg_tiantianfanlilunciactconfig_get,roundId,'czlist')
for targetDay,cfg in pairs(allLevelTaskCfgList_lookup)do
local isFinish=rechargeDay>=targetDay
local isGot=maxGotDay>=targetDay
if isFinish and not isGot then
return true
end
end
return false
end


function welfareModel:checkDailyRebateEnterReddot()
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eDailyRebate]()then
return false
end

if not self.data.rebateData or not next(self.data.rebateData)then
return false
end

for gradeId,v in pairs(self.data.rebateData)do
local reddot=welfareModel:checkDailyRebateGradeReddot(gradeId)
if reddot then
return true
end
end

return false
end


function welfareModel:checkDailyRebateEnterOpen()

if verifyManager:isHideBusinessActivity()then
return false
end
if not self.data.rebateData or not next(self.data.rebateData)then
return false
end

for gradeId,v in pairs(self.data.rebateData)do
local isOpen=welfareModel:checkDailyRebateGradeIsOpen(gradeId)
if isOpen then
return true
end
end

return false
end




function welfareModel:isOpenYaoQingMa()
if systemModel.isOpen(SYSTEM_DEFINE.eYaoQingMa)and houtaiModel:isOpenYaoQingMa()then
return true
end
return false
end

function welfareModel:setBindInvitationCode(invitationCode)
if not self.data.invitationCodeData then
self.data.invitationCodeData={}
end
self.data.invitationCodeData.bindInvitationCodeNum=invitationCode
end


function welfareModel:getBindInvitationCode()
if self.data.invitationCodeData then
return self.data.invitationCodeData.bindInvitationCodeNum
end
end


function welfareModel:setSelfInvitationCode(invitationCode)
if not self.data.invitationCodeData then
self.data.invitationCodeData={}
end

self.data.invitationCodeData.selfInvitationCodeNum=invitationCode


if webGLHelper:isRunMiniGame()then
webGLHelper:setShareData()
end
end


function welfareModel:getSelfInvitationCode()
if self.data.invitationCodeData then
local invitationCode=self.data.invitationCodeData.selfInvitationCodeNum
if invitationCode and not mathHelper.compareInt64(invitationCode,int64.new('0'))then
return invitationCode
end
end


welfareController:checkSelfInvitationCode()
end

function welfareModel:getSelfInvitationString()
local selfInvitationCode_int_64=welfareModel:getSelfInvitationCode()
if selfInvitationCode_int_64 and not mathHelper.compareInt64(selfInvitationCode_int_64,int64.new('0'))then
local str=mathHelper.convertDecimalTo35System(mathHelper.int64_to_number(selfInvitationCode_int_64),INVITATION_CODE_MIN_POS_COUNT)
return str
end
end


function welfareModel:setInvitationTaskData(updateTaskCount,updateTaskList,finishTaskCount,taskDataList)
if not self.data.invitationCodeData then
self.data.invitationCodeData={}
end
self.data.invitationCodeData.updateTaskCount=updateTaskCount
self.data.invitationCodeData.updateTaskList_lookup={}
if updateTaskList and next(updateTaskList)then
for i,taskId in ipairs(updateTaskList)do
self.data.invitationCodeData.updateTaskList_lookup[taskId]=true
end
end

self.data.invitationCodeData.finishTaskCount=finishTaskCount
self.data.invitationCodeData.taskDataList_lookup={}
if taskDataList and next(taskDataList)then
for i,v in ipairs(taskDataList)do
local taskId=v.param_1
local finishCount=v.param_2
local gotCount=v.param_3
self.data.invitationCodeData.taskDataList_lookup[taskId]={
id=taskId,
finishCount=finishCount,
gotCount=gotCount,
}
end
end
end

function welfareModel:getInvitationAllFinishTaskCount()
if self.data.invitationCodeData and self.data.invitationCodeData.taskDataList_lookup then
return self.data.invitationCodeData.finishTaskCount or 0
end
end

function welfareModel:getInvitationTaskDataByTaskId(taskId)
if self.data.invitationCodeData and self.data.invitationCodeData.taskDataList_lookup then
return self.data.invitationCodeData.taskDataList_lookup[taskId]
end
end

function welfareModel:checkInvitationUpdateTaskById(taskId)
if not self.data.invitationCodeData or not self.data.invitationCodeData.updateTaskList_lookup then
return false
end

return self.data.invitationCodeData.updateTaskList_lookup[taskId]or false
end


function welfareModel:setInvitationUpdateTaskById(taskId)
if not self.data.invitationCodeData then
self.data.invitationCodeData={}
end

if welfareModel:checkInvitationUpdateTaskById(taskId)then

return
end
self.data.invitationCodeData.updateTaskCount=self.data.invitationCodeData.updateTaskCount+1
if not self.data.invitationCodeData.updateTaskList_lookup then
self.data.invitationCodeData.updateTaskList_lookup={}
end
self.data.invitationCodeData.updateTaskList_lookup[taskId]=true
end


function welfareModel:setInvitationTaskGotCountByTaskId(taskId,gotCount)
if not self.data.invitationCodeData then
self.data.invitationCodeData={}
end
if not self.data.invitationCodeData.taskDataList_lookup then
self.data.invitationCodeData.taskDataList_lookup={}
end
if not self.data.invitationCodeData.taskDataList_lookup[taskId]then
self.data.invitationCodeData.taskDataList_lookup[taskId]={
taskId=taskId,
finishCount=gotCount,
gotCount=gotCount,
}
else
self.data.invitationCodeData.taskDataList_lookup[taskId].gotCount=gotCount
end
end


function welfareModel:setInvitedData(num,dataList)
if not self.data.invitationCodeData then
self.data.invitationCodeData={}
end
self.data.invitationCodeData.invitedCount=num
self.data.invitationCodeData.invitedDataList=dataList or{}
end


function welfareModel:getInvitedCount()
if self.data.invitationCodeData then
return self.data.invitationCodeData.invitedCount or 0
end
return 0
end


function welfareModel:getInvitedDataList()
if self.data.invitationCodeData then
return self.data.invitationCodeData.invitedDataList
end
end

function welfareModel:checkInvitationAllTaskReddot()
if not self.data.invitationCodeData or not self.data.invitationCodeData.taskDataList_lookup or not next(self.data.invitationCodeData.taskDataList_lookup)then
return false
end

for taskId,v in pairs(self.data.invitationCodeData.taskDataList_lookup)do
local reddot=welfareModel:checkInvitationTaskReddotById(taskId)
if reddot then
return true
end
end

return false
end

function welfareModel:checkInvitationTaskReddotById(taskId)
if not self.data.invitationCodeData or not self.data.invitationCodeData.taskDataList_lookup or not next(self.data.invitationCodeData.taskDataList_lookup)then
return false
end

if self.data.invitationCodeData.taskDataList_lookup[taskId]then
local taskCfg=cfgHelper.get1(cfg_yaoqingmaconfig_get,taskId)
local data=self.data.invitationCodeData.taskDataList_lookup[taskId]or{}
if taskCfg then
local finishCount=data.finishCount or 0
local gotCount=data.gotCount or 0

local isGotAll=gotCount>=taskCfg.maxNum
local isFinish=finishCount>gotCount
if isFinish and not isGotAll then
return true
end
end
end

return false
end

function welfareModel:checkInvitationCodeEnterReddot()

local isOpen=welfareModel:isOpenYaoQingMa()
if not isOpen then
return false
end
if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eYaoQingMa]()then
return false
end

if welfareModel:checkInvitationFreeRewardCanGet()then

return true
end

if welfareModel:checkInvitationAllTaskReddot()then

return true
end

return false
end

function welfareModel:checkInvitationFreeRewardCanGet()
local nowZmLevel=zongmenModel:getLevel()
local const_def=cfg_yaoqingmaconfig().const_def
local targetZmLevel=const_def.openLv
if nowZmLevel>=targetZmLevel then

return false
end

local giftId=const_def.freeRewardId
if giftId then
return FreeGiftController.GetFreeGift(giftId)
else

return false
end
end


function welfareModel:test_openInvitationCode()
if not houtaiModel.phpData then
houtaiModel.phpData={}
end

if not houtaiModel.phpData[HOUTAI_TYPE.eYaoQingMa]then
houtaiModel.phpData[HOUTAI_TYPE.eYaoQingMa]={}
end

houtaiModel.phpData[HOUTAI_TYPE.eYaoQingMa]["is_open"]="1"
end



function welfareModel:setBindReturnCode(returnCode)
if not self.data.returnCodeData then
self.data.returnCodeData={}
end
self.data.returnCodeData.bindReturnCodeNum=returnCode
end


function welfareModel:getBindReturnCode()
if self.data.returnCodeData then
return self.data.returnCodeData.bindReturnCodeNum
end
end


function welfareModel:setReturnCodeData(self_zhm,bind_zhm,invite_num,reward_idx)
if not self.data.returnCodeData then
self.data.returnCodeData={}
end
self.data.returnCodeData.bindReturnCodeNum=bind_zhm
self.data.returnCodeData.selfReturnCodeNum=self_zhm
self.data.returnCodeData.invite_num=invite_num
self.data.returnCodeData.reward_idx=reward_idx
end


function welfareModel:setReturnCodePlayerData(invite_num,zhmInviteInfo)
if not self.data.returnCodeData then
self.data.returnCodeData={}
end
self.data.returnCodeData.invite_num=invite_num
self.data.returnCodeData.retrunPlayerInfo=zhmInviteInfo
end


function welfareModel:getReturnCodePlayerData()
if self.data.returnCodeData then
return self.data.returnCodeData.retrunPlayerInfo
end
end


function welfareModel:getReturnCodeInviteNum()
if self.data.returnCodeData then
return self.data.returnCodeData.invite_num
end
end


function welfareModel:setReturnCodeRewardIdx(reward_idx)
if not self.data.returnCodeData then
self.data.returnCodeData={}
end
self.data.returnCodeData.reward_idx=reward_idx
end


function welfareModel:getReturnCodeRewardIdx()
if self.data.returnCodeData then
return self.data.returnCodeData.reward_idx
end
end


function welfareModel:setSelfReturnCode(returnCode)
if not self.data.returnCodeData then
self.data.returnCodeData={}
end
self.data.returnCodeData.selfReturnCodeNum=returnCode
end


function welfareModel:getSelfReturnCode()
if self.data.returnCodeData then
local returnCode=self.data.returnCodeData.selfReturnCodeNum
if returnCode and not mathHelper.compareInt64(returnCode,int64.new('0'))then
return returnCode
end
end


welfareController:checkSelfReturnCode()
end

function welfareModel:checkReturnCodeAllTaskReddot()
local targetCfgList=cfg_zhaohuimaconfig()
for taskId,v in ipairs(targetCfgList)do
if welfareModel:checkReturnCodeTaskReddot(taskId)then
return true
end
end
return false
end

function welfareModel:checkReturnCodeTaskReddot(taskId)
local taskCfg=cfgHelper.get1(cfg_zhaohuimaconfig_get,taskId)
local recallNum=welfareModel:getReturnCodeInviteNum()or 0
local receive_idx=welfareModel:getReturnCodeRewardIdx()or 0
if recallNum>=taskCfg.num and receive_idx<taskId then
return true
end
return false
end

function welfareModel:checkXianYouZhaoHuiOpen()
local yqm_const_def=cfg_yaoqingmaconfig().const_def
local zmLevel=zongmenModel:getLevel()
if zmLevel<yqm_const_def.openLv then
return false
end
local zhm_const_def=cfg_zhaohuimaconfig().const_def
local limitOpenDay,limitMinDay=zhm_const_def.min_openday[1],zhm_const_def.min_openday[2]
local serverOpenDay=timeHelper.getServerOpenDay()
if serverOpenDay<limitOpenDay then
return false
end
local sTime,eTime=zhm_const_def.opentime[1],zhm_const_def.opentime[2]
local sTimeStamp=timeHelper.getDateStamp(sTime)
local eTimeStamp=timeHelper.getDateStamp(eTime)
local nowTime=timeHelper.getServerLongTime()
local openDay=timeHelper.getServerOpenDayByStamp(eTimeStamp-limitMinDay*86400)
if openDay<limitOpenDay then
return false
end
if nowTime<sTimeStamp or nowTime>eTimeStamp then
return false
end
return true
end

function welfareModel:checkXianYouZhaoHuiReddot()
if not welfareModel:checkXianYouZhaoHuiOpen()then
return false
end
return welfareModel:checkXianYouZhaoHuiFreeRewardCanGet()or welfareModel:checkReturnCodeAllTaskReddot()
end

function welfareModel:checkXianYouZhaoHuiFreeRewardCanGet()
local const_def=cfg_zhaohuimaconfig().const_def
local giftId=const_def.zhmFreeReward
if giftId then
local openTime=const_def.opentime
return FreeGiftController.GetFreeGift(giftId,{openTime[1],openTime[2],const_def.min_openday})
else

return false
end
end

function welfareModel:checkHuiGuiBangDingOpen()
local zhm_open=welfareModel:checkXianYouZhaoHuiOpen()
local isReturningPlayer=welfareModel:checkReturningPlayer()
return zhm_open and isReturningPlayer
end

function welfareModel:checkHuiGuiBangDingFreeRewardCanGet()
local const_def=cfg_zhaohuimaconfig().const_def
local giftId=const_def.bindFreeReward
if giftId then
local openTime=const_def.opentime
return FreeGiftController.GetFreeGift(giftId,{openTime[1],openTime[2],const_def.min_openday})
else

return false
end
end

function welfareModel:checkHuiGuiBangDingReddot()
if not welfareModel:checkHuiGuiBangDingOpen()then
return false
end
return welfareModel:checkHuiGuiBangDingFreeRewardCanGet()
end

function welfareModel:checkReturningPlayer()
local zhm_const_def=cfg_zhaohuimaconfig().const_def
for i,actid in ipairs(zhm_const_def.actlist or{})do
if actRoleController:isOpen(actid)then
return true
end
end
return false
end

local guanzhuLocalKey='guanzhuLocalKey'


function welfareModel:checkGuanZhuActOpen()
local data=houtaiModel:getGongZhongHaoData()
return data.isOpen and systemModel.isOpen(SYSTEM_DEFINE.eMediaGuide)and self:checkOpen_RecvAll()
end

function welfareModel:checkGuanZhuActReddot()
local visitlist=welfareModel:getLocalGuanZhuVisitList()
local gameVersion=pfwindowslController:getGameVersion()
local taskCfg=cfgHelper.get2(cfg_guanzhuactconfig_get,gameVersion,'tasks')

if not WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eGuanZhuAct]()then
return false
end

for k,taskData in ipairs(taskCfg or{})do
local taskId=taskData[1]
local giftId=taskData[3]

local isCanGetGift=FreeGiftController.GetFreeGift(giftId,nil)
local isVisited=(visitlist[taskId]or 0)==1

if self.oneGuanZhuReddot==nil and isCanGetGift then
self.oneGuanZhuReddot=true
end

if isCanGetGift and isVisited then
return true
end
end

return self.oneGuanZhuReddot or false
end


function welfareModel:checkOpen_RecvAll()
local data=houtaiModel:getGongZhongHaoData()
if not data.isOpen or not systemModel.isOpen(SYSTEM_DEFINE.eMediaGuide)then
return false
end
local visitlist=welfareModel:getLocalGuanZhuVisitList()
local gameVersion=pfwindowslController:getGameVersion()
local taskCfg=cfgHelper.get2(cfg_guanzhuactconfig_get,gameVersion,'tasks')
for k,taskData in ipairs(taskCfg or{})do
local taskId=taskData[1]
local giftId=taskData[3]
local isCanGetGift=FreeGiftController.GetFreeGift(giftId,nil)
local isVisited=(visitlist[taskId]or 0)==1
if not isVisited then
return true
end
if isCanGetGift then
return true
end
end
return false
end

function welfareModel:setOneGuanZhuReddot()
self.oneGuanZhuReddot=false
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end



function welfareModel:checkWeekendWelfareOpen()
local isOpen=weekendBenifitsModel:checkOpen()
return isOpen
end

function welfareModel:checkWeekendWelfareReddot()
if not welfareModel:checkWeekendWelfareOpen()then
return false
end

return weekendBenifitsModel:checkReddot()
end




function welfareModel:setLocalGuanZhuVisitList(visitList)
local temp={}
if visitList~=nil and next(visitList)~=nil then
for k,v in pairs(visitList)do
table.insert(temp,{k,v})
end
end
userActorSetting.set(guanzhuLocalKey,temp)
userActorSetting.flush()
end

function welfareModel:getLocalGuanZhuVisitList()
local guanZhuList=userActorSetting.get(guanzhuLocalKey,{})
local temp={}
if#guanZhuList>0 then
for k,v in pairs(guanZhuList)do
temp[v[1]]=v[2]
end
end
return temp
end




function welfareModel:checkXianYuanShareOpen()
return WELFARE_CHECK_OPEN_FUN[FULL_TAB_TYPE.eXianYuanShare]()
end



function welfareModel:setData_WXGameCircle(data)
self.data.WXGameCircleData=data
end

function welfareModel:getData_WXGameCircle()
return self.data.WXGameCircleData
end

function welfareModel:checkWXGameCircleOpen()
if welfareModel:getWXGameCircleIsDouYin()then
if deviceHelper.getAPILevel()<390 then
return false
end
return systemModel.isOpen(SYSTEM_DEFINE.eWechatGame)
end
if not webGLHelper:isRunWebGL()then
return false
end
return systemModel.isOpen(SYSTEM_DEFINE.eWechatGame)
end

function welfareModel:checkWXGameCircleReddot()
if not self:checkWXGameCircleOpen()then
return false
end
return self:checkWXGameCircleReddot_FreeReward()or self:checkWXGameCircleRecv()or self:checkOpenWXGameCircle()
end

function welfareModel:checkWXGameCircleReddot_FreeReward()
local giftId=cfgHelper.get2(cfg_wechatgamebaseconfig_get,1,'giftId')
return FreeGiftController.GetFreeGift(giftId)
end

function welfareModel:checkWXGameCircleRecv()
local curRound=self:getWXGameCircle_Round()
local cfg=cfg_wechatgameconfig()
local curRoundCfg=cfg[curRound]
for i,v in ipairs(curRoundCfg)do
if self:checkWXGameCircleCanRecv(v.idx)then
return true
end
end
return false
end

function welfareModel:checkOpenWXGameCircle()
local openWinTime=self:getWXGameCircle_openWinTime()
return not timeHelper.isTodayShort(openWinTime)
end

function welfareModel:checkWXGameCircleCanRecv(idx)
if self:checkWXGameCircleRecvFlag(idx)then
return false
end
local curRound=self:getWXGameCircle_Round()
local curDay=self:getWXGameCircle_SignDay()
local cfg=cfg_wechatgameconfig()
local curRoundCfg=cfg[curRound]
local day=curRoundCfg[idx].day
return day<=curDay
end

function welfareModel:checkWXGameCircleNextRound()
local curDay=self:getWXGameCircle_SignDay()
local curRound=self:getWXGameCircle_Round()
local cfg=cfg_wechatgameconfig()
local curRoundCfg=cfg[curRound]
local maxIdx=#curRoundCfg
local maxDay=curRoundCfg[maxIdx].day
if curDay<maxDay then
return false
end
for i,v in ipairs(curRoundCfg)do
if self:checkWXGameCircleCanRecv(v.idx)then
return false
end
end
return true
end

function welfareModel:NextRoundWXGameCircle()
local curDay=self:getWXGameCircle_SignDay()
local curRound=self:getWXGameCircle_Round()
local cfg=cfg_wechatgameconfig()
local maxRound=#cfg
curRound=curRound+1
if curRound>maxRound then
curRound=1
end
local data={}
data.round=curRound
data.day=0
data.flag=0
data.today=0
self:setData_WXGameCircle(data)
end

function welfareModel:checkWXGameCircleRecvFlag(idx)
local flag=self:getWXGameCircle_Flag()
return mathHelper.getBitValue(flag,idx-1)
end

function welfareModel:getWXGameCircle_SignDay()
return self.data.WXGameCircleData and self.data.WXGameCircleData.day or 0
end

function welfareModel:getWXGameCircle_Round()
return self.data.WXGameCircleData and self.data.WXGameCircleData.round or 1
end

function welfareModel:getWXGameCircle_Flag()
return self.data.WXGameCircleData and self.data.WXGameCircleData.flag or 0
end

function welfareModel:getWXGameCircle_Today()
return self.data.WXGameCircleData and self.data.WXGameCircleData.today or 0
end

function welfareModel:getWXGameCircle_openWinTime()
if self.data.WXGameCircleData then
if self.data.WXGameCircleData.openWinTime then
return self.data.WXGameCircleData.openWinTime
else
self.data.WXGameCircleData.openWinTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWXGameCircle,'openWinTime',0)
return self.data.WXGameCircleData.openWinTime
end
else
return 0
end
end

function welfareModel:setWXGameCircle_openWinTime(time)
if self.data.WXGameCircleData then
self.data.WXGameCircleData.openWinTime=time
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWXGameCircle,'openWinTime',self.data.WXGameCircleData.openWinTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWXGameCircle)
end
end

function welfareModel:getWXGameCircleName()
if welfareModel:getWXGameCircleIsDouYin()then
return"小游戏站"
else
return"游戏圈"
end
end

function welfareModel:getWXGameCircleIsDouYin()
return webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()
end


