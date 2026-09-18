




moneySystem=gameState.addListener({})

local _guid=0
local _callbackList={}
local _callbackParamsList={}
local _data={}


local _shieldList={
[GameLog.clShangPuBuyItem]={
all=true,
},
[GameLog.clMonijyNPruduct]={
all=true,
},
[GameLog.clMonijyPPruduct]={
all=true,
},
[GameLog.clMoneyAutoIncr]={
all=false,
[eMoneyType.mtChuanDao]=true,
},
[GameLog.clTuFaEventSucceed]={
all=true,
},
[GameLog.clEverydayTaskReward]={
all=true,
},
[GameLog.clBaoLingShuChouJiang]={
all=true,
},
[GameLog.clMoneyExchange]={
all=true,
},
}

local _skipMoneyTypes=
{

eMoneyType.mtAct2,
eMoneyType.mtXMLingShi,
eMoneyType.mtXMJieShi,
eMoneyType.mtXMXuKongJing,
eMoneyType.mtYuBi,
eMoneyType.mtIncense,
}
local _skipMoneyLookup={}
for i,v in ipairs(_skipMoneyTypes)do
_skipMoneyLookup[v]=true
end

local _bugRecvSuperTips={
[eMoneyType.mtLingPai]=true,
[eMoneyType.mtTianMoRuQin]=true,
[eMoneyType.mtLingShanBattleTimes1]=true,
[eMoneyType.mtXianLing]=true,
[eMoneyType.mtMoLing]=true,
}

local _moneyInfoTips=
{
[eMoneyType.mtChenYuan]=true,
[eMoneyType.mtXianYuan]=true,
}



local _money_monk=
{
[eMoneyType.mtFLSoldier1_1]="获得 <color=#5ac0e2>筑基修士</color>x{0}",
[eMoneyType.mtFLSoldier2_1]="获得 <color=#5ac0e2>结丹修士</color>x{0}",
[eMoneyType.mtFLSoldier3_1]="获得 <color=#5ac0e2>元婴修士</color>x{0}",
[eMoneyType.mtFLSoldier4_1]="获得 <color=#bb8cf1>化神修士</color>x{0}",
[eMoneyType.mtFLSoldier5_1]="获得 <color=#bb8cf1>炼虚修士</color>x{0}",
[eMoneyType.mtFLSoldier6_1]="获得 <color=#bb8cf1>合体修士</color>x{0}",
[eMoneyType.mtFLSoldier7_1]="获得 <color=#efb150>大乘修士</color>x{0}",
[eMoneyType.mtFLSoldier8_1]="获得 <color=#efb150>渡劫修士</color>x{0}",
[eMoneyType.mtFLSoldier9_1]="获得 <color=#efb150>天仙修士</color>x{0}",
}

local _moneyAddDelay=
{
[eMoneyType.mtYuBi]=2,
}


function moneySystem:onAppStart()
moneyBuyModel:onAppStart()

socketManager:register_receiver(254,1,moneySystem.recvInitMoney)
socketManager:register_receiver(254,2,moneySystem.recvOnMoneyChanged)
socketManager:register_receiver(254,32,moneySystem.recvMoneyExchanged)
socketManager:register_receiver(254,43,moneySystem.recvMoneyBuyInit)
socketManager:register_receiver(254,44,moneySystem.recvMoneyBuyResult)
socketManager:register_receiver(254,56,moneySystem.recvInitMoney2)
socketManager:register_receiver(254,57,moneySystem.recvOnMoneyChanged)
socketManager:register_receiver(254,79,moneySystem.recvInitMoney3)
socketManager:register_receiver(254,80,moneySystem.recvOnMoneyChanged)
socketManager:register_receiver(20,171,moneySystem.recvInitMoney4)
socketManager:register_receiver(20,172,moneySystem.recvXMOnMoneyChanged)
end

function moneySystem:onEnterState()
moneyModel.init()
moneySystem:reset()
moneyBuyModel:onEnterState()
moneyPlanModel:clearPlanModel()
end

function moneySystem:onLeaveState()
moneyModel.init()
moneySystem:reset()
moneyBuyModel:onLeaveState()
end

function moneySystem:reset()
_guid=0
_callbackList={}
_callbackParamsList={}
end

function moneySystem:onPlayerCreate(player)

end

function moneySystem:reqExchangeMoney(moneyType,moneyValue,guid)
socketManager:send_254_32(moneyType,moneyValue,guid)
end


function moneySystem.recvInitMoney(len,moneyArray)
moneyModel.initMoney(moneyArray,1)
end

function moneySystem.recvInitMoney2(len,moneyArray)
moneyModel.initMoney(moneyArray,2)
end

function moneySystem.recvInitMoney3(len,moneyArray)
moneyModel.initMoney(moneyArray,3)
end

function moneySystem.recvInitMoney4(len,moneyArray)
moneyModel.initMoney(moneyArray,4)
xianmengModel:initkufangBag(moneyArray)
end

function moneySystem.recvOnMoneyChanged(singleArray)
local moneyType=singleArray.param_1
local lastVal=moneyModel.getMoney(moneyType)
moneyModel.setMoneyArray(singleArray)
dzSpecialityEffectManager.onMoneyChanged(moneyType)
local val=moneyModel.getMoney(moneyType)
local changeType=singleArray.param_3
local haveTopMoneyType=UIManager:invokeUIMethod('UITopMoneyWin','getMoneyRoot',moneyType)
local func=function()
notifySystem:postNotify(notifyConfig.on_money_changed,moneyType,lastVal,val,changeType)

local isMoneyInit=moneyModel.checkInit()
local change=val-lastVal
if isMoneyInit and change>0 then
if moneySystem.checkShieldTips(changeType,moneyType)then

if not _skipMoneyLookup[moneyType]then

local isPrizeState=showPrizeControl.isPrizeState()

if _moneyInfoTips[moneyType]then
if haveTopMoneyType then
UIManager.moneyInfo(moneyType,FMT.fmt('+{0}',change))
else
UIManager.rewardInfo(iconHelper.getIconName(moneyType),FMT.fmt('X{0}',change))
end
elseif not isPrizeState and _money_monk[moneyType]then
UIManager.info(FMT.fmt(_money_monk[moneyType],change))
elseif not isPrizeState or moneyType==eMoneyType.mtLingFuJingYuan then
UIManager.rewardInfo(iconHelper.getIconName(moneyType),FMT.fmt('X{0}',change))
end
end
end
end
end

if haveTopMoneyType and _moneyAddDelay[moneyType]and val>lastVal then
_data.timer=timer.new()
_data.timer:start(_moneyAddDelay[moneyType],func,1)
else
func()
end
end

function moneySystem.recvXMOnMoneyChanged(singleArray)
moneySystem.recvOnMoneyChanged(singleArray)
UIManager:invokeUIMethod('UIXMKuFangWin','refreshKuFangMoneyPanel')
UIManager:invokeUIMethod('UIXianMengMouLueSetWin','RefreshMoneyAll')
xianmengModel:kufangBagChanged(singleArray)

end


function moneySystem.checkShieldTips(changeType,moneyType)
if _shieldList[changeType]~=nil then
if _shieldList[changeType].all==true then
return false
else
if _shieldList[changeType][moneyType]then
return false
end
end
end
return true
end


function moneySystem.recvMoneyExchanged(moneyType,moneyValue,guid)
if _callbackList[guid]then
local params=_callbackParamsList[guid]
_callbackList[guid](params)
end
end

function moneySystem.recvMoneyBuyInit(len,list)
moneyBuyModel:setAllCount(list)
end

function moneySystem.recvMoneyBuyResult(money,count,need_buy_times)
local oldCnt=moneyBuyModel:getCount(money)
moneyBuyModel:setCount(money,count)
local day=moneyBuyModel:getBuyMax(money)
local delta=math.max(count-math.max(oldCnt,day),0)
local least=moneyBuyModel:getLeast(money)

moneyBuyModel:setLeast(money,math.max(least-delta,0))

local mCfg=cfgHelper.get1(cfg_moneyconfig_get,money)
if mCfg.buy then
if _bugRecvSuperTips[money]then
UIManager.info(FMT.fmt("{0}+{1}",mCfg.name,need_buy_times*mCfg.buy[1]))
else
UIManager.info(FMT.fmt("{0}+{1}",mCfg.name,mCfg.buy[1]))
end
end
end

function moneySystem:canUseMoney(moneylist)
local temp={}
for i,v in ipairs(moneylist)do
local moneyType=v[1]
local needValue=v[2]
local hasValue=moneyModel.getMoney(moneyType)
if needValue>hasValue then
local flag,replace=moneySystem:canReplaceMoney(moneyType,needValue-hasValue)
if flag then
temp[moneyType]=replace
else
return false,moneyType
end
end
end
return true,temp
end

function moneySystem:canReplaceMoney(moneyType,needValue)
local temp={}
local exchangeList=moneyConfig.getExchangeTypeList(moneyType)
local left=needValue
if exchangeList then
for _,exType in ipairs(exchangeList)do
local hasValue=moneyModel.getMoney(exType)
local nextleft=left-hasValue
local put=nextleft>=0 and hasValue or left
temp[#temp+1]={exType,put}
if nextleft<=0 then
return true,temp
end
left=nextleft
end
end
return false
end


function moneySystem:checkReplaceMoney(moneyType,needValue)
if moneyModel.checkEnoughMoney(moneyType,needValue)then
return true,moneyType
end
local exchangeList=moneyConfig.getExchangeTypeList(moneyType)
if exchangeList then
for _,exType in ipairs(exchangeList)do
if moneyModel.checkEnoughMoney(exType,needValue)then
return true,exType
end
end
end
return false,moneyType
end


function moneySystem:countAndExchange(datas,moneyType,callback,warnType,exchangeType)
local count=0
for i,v in ipairs(datas)do
local k=v[1]
if moneyType==k then
count=count+v[2]
end
end
return moneySystem:useMoney(moneyType,count,callback,warnType,exchangeType)
end



function moneySystem:countAndExchangeEx(datas,types,callback,warnType)
local clist={}
for i,v in ipairs(datas)do
local k=v[1]
if types[k]then
clist[k]=(clist[k]or 0)+v[2]
end
end
local k,v
local nextFunc
nextFunc=function()
k,v=next(clist,k)
if k then
local ct=k
local cv=v
local check=self:useMoney(ct,cv,nextFunc,warnType,types[k])
if not check then
nextFunc()
end
else
callback()
end
end
nextFunc()
end

function moneySystem:useMoneys(consume,callback,warnType)
local nextFunc
nextFunc=function(index)
local cost=consume[index]
if cost then
self:useMoney(cost[1],cost[2],function()
nextFunc(index+1)
end,warnType,nil)




else
callback()
end
end
nextFunc(1)
end


function moneySystem:useMoney(moneyType,needValue,callback,warnType,exchangeType,callbackParams)
local enough=moneyModel.checkEnoughMoney(moneyType,needValue)
if enough then
callback(callbackParams)
return true
end
local flag=false
local moneyName=moneyModel.getMoneyName(moneyType)
local exchangeList=moneyConfig.getExchangeTypeList(moneyType)
if exchangeList==nil then
flag=false
else
local hasValue=moneyModel.getMoney(moneyType)
local leftValue=needValue-hasValue
local exchangeFun=function(exType,cb,cbParams)
local enough=moneyModel.checkEnoughMoney(exType,leftValue)
if not enough then
return false
end
_guid=_guid+1
local guid=_guid
_callbackList[guid]=cb
_callbackParamsList[guid]=cbParams

local cb=function()
moneySystem:reqExchangeMoney(moneyType,leftValue,guid)
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eExchargeXianyuMoney)
if flag then
cb()
return true
end

local exchangeName=moneyModel.getMoneyName(exType)
local desc=FMT.fmt(cfg_lang_get('exchargemoneytitle_1'),moneyName,leftValue,exchangeName,leftValue,moneyName)
self.costMoneyDialogue=UIDialogManager.getConfirmDialog(self.costMoneyDialogue,'提示',desc)
self.costMoneyDialogue.choosetext="今日不再提示"
self.costMoneyDialogue.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eExchargeXianyuMoney,flag)
end
self.costMoneyDialogue.okcallback=function()
cb()
end
self.costMoneyDialogue:show()
return true
end

if exchangeType then
flag=exchangeFun(exchangeType,callback)
else

for i,exType in ipairs(exchangeList)do
if exchangeFun(exType,callback,false)then
flag=true
break
end
end
end
end

if not flag then
if warnType==WARNING_TYPE.eWarning then
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
gainControl:showGainWin(moneyType)
elseif warnType==WARNING_TYPE.eRechargeDialogue then
moneySystem:showBuyDialogue()
elseif warnType==WARNING_TYPE.eOnlyWaring then
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
end
end
return flag
end


function moneySystem:showBuyDialogue()
jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=FULL_TAB_TYPE.eRecharge}})
end

function moneySystem:showBuyTips(id)
local cfg=itemsConfig.getConfig(id)
if itemsConfig.isMoney(id)then
if cfg.buy then

local single=cfg.buy[1]
local cost=cfg.buy[2]
local cnt=#cost
local haveCnt=moneyBuyModel:getCount(id)
local max=moneyBuyModel:getMax(id)
local costItemID=cost[1][1][1]

if haveCnt<max then
local getCostNum=function(num)
local costItemNum=0
for i=1,num do
local costIndex=haveCnt+i
costIndex=costIndex>cnt and cnt or costIndex
local n=cost[costIndex][1][2]
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
local contentStr=FMT.fmt('是否花费{0}购买<color=#6833c0>{1}*{2}</color>',costStr,cfg.name,num*single)
return contentStr
end
local tipContent=FMT.fmt("上一天的剩余购买次数可存储到次日\n存储上限最多为{0}次",cfg.buy[3]+cfg.buy[4])

local show_data={
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,
max=max-haveCnt,
tips=FMT.fmt("（今日剩余次数：{0}）",max-haveCnt),
oktext='购买',
canceltext='取消',
tipContent=tipContent,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)


if moneyModel.checkMoneyOverflow(cfg.id,num*single)then
return
end

local itemNum=getCostNum(num)
local func=function()

socketManager:send_254_44(id,num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
UIManager.error("购买次数不足")
end
end
return false
end
if cfg.buy then
local single=cfg.buy[1]
local cost=cfg.buy[2]
local haveCnt=moneyBuyModel:getCount(id)
local max=moneyBuyModel:getMax(id)
if haveCnt<max then
local costStr=""
local costList=cost[haveCnt+1]
for i,v in ipairs(costList)do
local moneyStr=FMT.fmt("{0}",v[2])
moneyStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",
moneyModel.checkEnoughMoney(v[1],v[2])and"549327FF"or"FF0000FF",moneyStr,
moneyModel.getIconNameEx(v[1]))
costStr=FMT.fmt("{0}{1}{2}",costStr,i==1 and""or"和",moneyStr)
end
local content1=FMT.fmt("是否确认花费{0}购买<color=#6833c0>{1}*{2}</color>",costStr,cfg.name,single)
local content2=FMT.fmt("(今日剩余次数：{0})",max-haveCnt)
local tipContent=FMT.fmt("上一天的剩余购买次数可存储到次日\n存储上限最多为{0}次",cfg.buy[3]+cfg.buy[4])
local show_data={
type='UIDialougeWithTips',
title='提示',
content=content1,
otherContent=content2,
tipContent=tipContent,
tipsPos=Vector2.New(140,15),
oktext='购买',
canceltext='取消',
okcallback=function()








moneySystem:countAndExchangeEx(costList,{[2]=3},function()
socketManager:send_254_44(id,1)
end,WARNING_TYPE.eWarning)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
else
UIManager.error("今日购买次数已耗尽")
end
end
return false
end