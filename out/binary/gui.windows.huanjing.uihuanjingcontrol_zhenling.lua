
HouShanZhenLingLayerStateList={
Lock=1,
NoChallenge=2,
Challenge=3,
QuickChallenge=4,
LayerFinish=5,
FinishAll=6,
}

function UIHuanJingControl:onAppStart_ZhengLing()

socketManager:register_receiver(6,112,self.recv_6_112)
socketManager:register_receiver(6,113,self.recv_6_113)
socketManager:register_receiver(6,114,self.recv_6_114)
socketManager:register_receiver(6,115,self.recv_6_115)


end



function UIHuanJingControl:req_init_zhenling()
socketManager:send_6_112()
end


function UIHuanJingControl.recv_6_112(len,hszlList,sdcsDayBuy,sdcsDay,sdcsbuy)
UIHuanJingControl:setZLInitData(len,hszlList,sdcsDayBuy,sdcsDay,sdcsbuy)
end


function UIHuanJingControl:req_buy_sdcs(buyCount)
socketManager:send_6_113(buyCount)
end

function UIHuanJingControl.recv_6_113(sdcsDayBuy,sdcsbuy)
UIManager.info('购买成功')
UIHuanJingControl:setZLTodayBuyCount(sdcsDayBuy,sdcsbuy)
UIHuanJingControl:freshZLState()
end



function UIHuanJingControl:req_unlock_zhenling(type)
socketManager:send_6_114(type)
end

function UIHuanJingControl.recv_6_114(type)
UIHuanJingControl:setZLMoneyUnlock(type)
UIHuanJingControl:freshZLState()
end




function UIHuanJingControl:req_Quick_Challenge_zhenling(type,layer,sdNum,is_assistant)
socketManager:send_6_115(type,layer,sdNum,is_assistant or 0)
end

function UIHuanJingControl.recv_6_115(type,layer,sdcsDay,sdcsBuy,is_assistant)

UIHuanJingControl:setAddZlTodaySdCount(layer)
end


function UIHuanJingControl:setZLInitData(len,hszlList,sdcsDayBuy,sdcsDay,sdcsbuy)
local hszlLoopUp={}
self.data.zlServerData={
len=len,
hszlList=hszlList or{},
sdcsDay=sdcsDay or 0,
sdcsDayBuy=sdcsDayBuy or 0,
sdcsbuy=sdcsbuy or 0,
hszlLoopUp=hszlLoopUp,
openList={}
}
if len>0 then
for k,hszlData in pairs(hszlList)do
hszlLoopUp[hszlData.zltype]=hszlData
end
end

self:freshOpenList()
end

function UIHuanJingControl:setZLTodayBuyCount(sdcsDayBuy,sdcsbuy)
self.data.zlServerData.sdcsDayBuy=sdcsDayBuy
self.data.zlServerData.sdcsbuy=sdcsbuy
end

function UIHuanJingControl:setAddZlTodaySdCount()
self.data.zlServerData.sdcsDay=self.data.zlServerData.sdcsDay+1
end

function UIHuanJingControl:resetZlTodaySdCount()
self.data.zlServerData.sdcsDay=0
end

function UIHuanJingControl:resetZlTodayBuySdCount()
self.data.zlServerData.sdcsDayBuy=0
end

function UIHuanJingControl:setZLMoneyUnlock(type)
local data=self.data.zlServerData.hszlLoopUp[type]

if data then
data.buyFlag=1
else
local temp={
zltype=type,
buyFlag=1,
stMaxLayer=0
}
self.data.zlServerData.len=self.data.zlServerData.len+1
table.insert(self.data.zlServerData.hszlList,temp)
self.data.zlServerData.hszlLoopUp[type]=temp
end


self:freshOpenList()
end

function UIHuanJingControl:resetZLMoneyUnlock()
local zlList=self.data.zlServerData.hszlList
for index,zlData in ipairs(zlList)do
if zlData.buyFlag==1 then
zlData.buyFlag=0
end
end
end


function UIHuanJingControl:freshOpenList()

local weekDay=timeHelper.getWeakDateEx()

local dayOpenLimit=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'dayOpenLimit')

local passtime=timeHelper.getServerTodayPass()
local limit
if passtime>18000 then
limit=dayOpenLimit[weekDay]
else
limit=dayOpenLimit[(weekDay+6)%7]
end

local openlist=table.weakCopy(limit)


local zlList=self.data.zlServerData.hszlLoopUp
for index,zlData in pairs(zlList)do
if zlData.buyFlag==1 then
table.insert(openlist,zlData.zltype)
end
end



table.sort(openlist,function(a,b)return a<b end)

local temp2={}
for k,v in ipairs(openlist)do
temp2[v]=true
end

self.data.zlServerData.openList=temp2
end

function UIHuanJingControl:updateZLData(type,max_layer)
local zlData=self:getZLData(type)
zlData.stMaxLayer=max_layer

UIHuanJingControl:refreshHud()
notifySystem:postNotify(notifyConfig.onHouShanZhenLingLVChange,type,max_layer)
end


function UIHuanJingControl:getZLData(type)
if not self.data.zlServerData.hszlLoopUp then
return nil
end

local data=self.data.zlServerData.hszlLoopUp[type]

if not data then
data={
zltype=type,
buyFlag=0,
stMaxLayer=0
}
self.data.zlServerData.hszlLoopUp[type]=data
end

return data
end

function UIHuanJingControl:getsdcsDayBuy()
return self.data.zlServerData.sdcsDayBuy
end

function UIHuanJingControl:getsdcsDay()
return self.data.zlServerData.sdcsDay
end

function UIHuanJingControl:getTodayFirstOpenType()
return next(self.data.zlServerData.openList)
end

function UIHuanJingControl:getJumpLayer(type)
local data=self:getZLData(type)
return Mathf.Max(data.stMaxLayer-2,0)
end

function UIHuanJingControl:getZLLayerData(type,layer)
local typeAllCfg=cfgHelper.get1(cfg_houshanzhenlingjiecengconfig_get,type)

local cfg=typeAllCfg[layer]
local data
if cfg then
data={}

data.cfg=cfg

local zmlv=zongmenModel:getLevel()
data.isUnlock=zmlv>=cfg.zmLevel

data.layerState=self:getLayerState(type,layer)

data.openTip=FMT.fmt('宗门{0}级\n开启',cfg.zmLevel)

local itemIconName=iconHelper.getIconName(cfg.sdUse[1])
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
local numStr=cfg.sdUse[2]
if itemsModel.getCount(cfg.sdUse[1])<cfg.sdUse[2]then
numStr=toColorString(FONT_COLOR.eRedColor,cfg.sdUse[2])
end
data.costTxt=FMT.fmt("{0} {1}\n扫荡",iconStr,numStr)

data.rewardTxt=data.layerState>3 and'扫荡奖励'or'首通奖励'
if data.layerState>3 then
data.showRewardList=zongmenControl:getRewardConfigData(cfg.sdItems,zongmenModel:getLevel())
else
data.showRewardList=cfg.stItems
end
end
return data

end

function UIHuanJingControl:getTypeSuitLayer(type)
local allTypeCfg=cfgHelper.get1(cfg_houshanzhenlingjiecengconfig_get,type)
local zlData=self:getZLData(type)
local totalLen=#allTypeCfg
local finalShowLayer=Mathf.Min(totalLen,zlData.stMaxLayer+1)
return finalShowLayer
end

function UIHuanJingControl:getTypeLeftTime(type,weekday,sdg)
local todayLeftTime=timeHelper.getServerTodayPass()
local syt=timeHelper.getServerTodayLeft2()
local fiveHSec=18000
local oneDaySec=86400

weekday=weekday or timeHelper.getWeakDateEx()
local openList=cfgHelper.get3(cfg_houshanzhenlingbaseconfig_get,1,'dayOpenLimit',weekday)

if table.findValue(openList,type)then
if sdg then
return oneDaySec+UIHuanJingControl:getTypeLeftTime(type,(weekday+1)%7,true)
else
return syt+UIHuanJingControl:getTypeLeftTime(type,(weekday+1)%7,true)
end
else
if sdg then
return fiveHSec
else
if self:checkTypeOpen(type)then
local zlData=self:getZLData(type)
if zlData.buyFlag==1 then
if todayLeftTime>fiveHSec then
return syt+UIHuanJingControl:getTypeLeftTime(type,(weekday+1)%7,true)
else
return fiveHSec-todayLeftTime
end
else
if todayLeftTime>fiveHSec then
return 0
else
return fiveHSec-todayLeftTime
end
end
end
end
end
end

function UIHuanJingControl:getZlOpenList()
return self.data.zlServerData.openList or{}
end

function UIHuanJingControl:getZLAllStMaxLayer()
if not self.data or not self.data.zlServerData or not self.data.zlServerData.hszlLoopUp then
return 0
end

local list=self.data.zlServerData.hszlLoopUp
local count=0
for i,v in pairs(list)do
local stMaxLayer=v.stMaxLayer
count=count+stMaxLayer
end
return count
end

function UIHuanJingControl:getZLStMaxLayerByType(type)
local zlData=self:getZLData(type)
if zlData and zlData.stMaxLayer then
return zlData.stMaxLayer or 0
end

return 0
end

function UIHuanJingControl:isZhenlingFuncOpen()
local isOpen=true

isOpen=isOpen and systemModel.isOpen(SYSTEM_DEFINE.eHouShanZhenLing)and next(self.data.zlServerData)
return isOpen
end

function UIHuanJingControl:isZhengLingReddot()
if not self:isZhenlingFuncOpen()then return false end

local reddot=true
local openlist=self:getZlOpenList()


local checkSD=false
for type,state in pairs(openlist)do
if state then
local data=self:getZLData(type)
if data.stMaxLayer>0 then
local sdUse=cfgHelper.get3(cfg_houshanzhenlingjiecengconfig_get,1,1,'sdUse')
local moneyId=sdUse[1]
local needVal=sdUse[2]

checkSD=checkSD or itemsModel.getCount(moneyId)>=needVal
if checkSD then
break
end
end
end
end

reddot=reddot and checkSD

return reddot
end

function UIHuanJingControl:isCanChallengeZhengLing()
if not self:isZhenlingFuncOpen()then return false end

local openlist=self:getZlOpenList()


for type,state in pairs(openlist)do
if state then
local data=self:getZLData(type)
if UIHuanJingControl:getLayerState(type,data.stMaxLayer+1)==HouShanZhenLingLayerStateList.Challenge then
return true
end
end
end

return false
end

function UIHuanJingControl:checkTypeOpen(type)
return self.data.zlServerData.openList[type]
end

function UIHuanJingControl:getLayerState(type,layer)
local cfg=cfgHelper.get2(cfg_houshanzhenlingjiecengconfig_get,type,layer)
if not cfg then return HouShanZhenLingLayerStateList.FinishAll end

local typeData=self:getZLData(type)

local zmlv=zongmenModel:getLevel()

local stMaxLayer=typeData.stMaxLayer

local state=0
if zmlv>=cfg.zmLevel then
if cfg.layer==stMaxLayer then
state=HouShanZhenLingLayerStateList.QuickChallenge
elseif cfg.layer==stMaxLayer+1 then
state=HouShanZhenLingLayerStateList.Challenge
elseif cfg.layer>stMaxLayer+1 then
state=HouShanZhenLingLayerStateList.NoChallenge
elseif cfg.layer<stMaxLayer then
state=HouShanZhenLingLayerStateList.LayerFinish
end
else
state=HouShanZhenLingLayerStateList.Lock
end

return state
end







function UIHuanJingControl:checkSdCondition(type,layer)
local condition=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'daySaoDang')
local sdUse=cfgHelper.get3(cfg_houshanzhenlingjiecengconfig_get,type,layer,'sdUse')
local dayBuyCountMax=condition[1]
local costItemId=sdUse[1]
local costItemNum=sdUse[2]

local sdqCount=itemsModel.getCount(costItemId)


local todayBuyCount=self.data.zlServerData.sdcsDayBuy

if sdqCount>=costItemNum then
return 1,Mathf.Floor(sdqCount/costItemNum)
else

if dayBuyCountMax>todayBuyCount then
return 2,condition[2][todayBuyCount+1]
end
return 3,FMT.fmt("{0}数量不足",itemsModel.getName(sdUse[1]))
end
end

function UIHuanJingControl:getClearLeftCount(type,layer)
local condition=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'daySaoDang')
local sdUse=cfgHelper.get3(cfg_houshanzhenlingjiecengconfig_get,type,layer,'sdUse')
local dayBuyCountMax=condition[1]
local costItemId=sdUse[1]
local costItemNum=sdUse[2]

local sdqCount=itemsModel.getCount(costItemId)


local todayBuyCount=self.data.zlServerData.sdcsDayBuy
local itemUseLeftCount=Mathf.Floor(sdqCount/costItemNum)
local buyLeftCount=math.max(dayBuyCountMax-todayBuyCount,0)
return itemUseLeftCount,buyLeftCount
end


function UIHuanJingControl:showZLPrepareWin(type,layer)



if UIHuanJingControl:getLayerState(type,layer)~=HouShanZhenLingLayerStateList.Challenge then
return
end

local cfg=cfgHelper.get2(cfg_houshanzhenlingjiecengconfig_get,type,layer)

local name='后山阵灵'


local groupID=cfg.boos
local monsterList=cfgHelper.get2(cfg_monstergroup_get,groupID,'monList')

local extraWin='UIHouShanZhenLingPrepareTop'
local extraParams={type=type,layer=layer}


local winArgs=
{
enterTxt=name,
groupId=groupID,
monsterList=monsterList,
showZhenFa=false,
skipShouYuanCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
closeByCloud=true,
closeByCloudDelay=1,
extraWin=extraWin,
extraParams=extraParams,
cancelCallBack=function()
local temp={}
temp.selectType=type
temp.selectLayer=layer
UIHuanJingControl:showZhenLingWindow(temp)
end,
enterCallBack=function(teamList,zfId)

local mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
local fightKey=fightLaunchController:sendFight(eBattleLaunch.houshanzhenling,teamList,mapId or 0,zfId or 0,{type,layer})
self.fightKey=fightKey
end,
}
local fightType=fightPreSelectModel.fightType.houshanzhenling
fightController.showPrepareWin(fightType,winArgs,nil,true)
end

function UIHuanJingControl:doNextFight(type,layer)
local cfg=cfgHelper.get2(cfg_houshanzhenlingjiecengconfig_get,type,layer)
local groupID=cfg.boos

local fightType=fightPreSelectModel.fightType.houshanzhenling
local teamList=fightPreSelectModel:getTeamData(fightType)or{}
local temp={}



for i=1,fightPreSelectModel.maxPosNum do
if teamList[i]then
temp[i]={1,teamList[i]}
else
temp[i]={0,int64.zero}
end
end

local mapId=cfgHelper.get2(cfg_monstergroup_get,groupID,"mapId")
local fightKey=fightLaunchController:sendFight(eBattleLaunch.houshanzhenling,temp,mapId or 0,0,{type,layer},true)
self.fightKey=fightKey
end

function UIHuanJingControl:freshZLState()
self:refreshHud()
UIManager:invokeUIMethod('UIHuanJingZhenLingChallengeWin','refreshAll')
end


function UIHuanJingControl:doSaoDang(type,layer)

local state,other=self:checkSdCondition(type,layer)

if state==1 then
if other>1 then
self:showSdMultipleDialouge(type,layer,other)
else
self:req_Quick_Challenge_zhenling(type,layer,1)
end
elseif state==2 then
self:showBuyCountDialouge()
elseif state==3 then
UIManager.info(other)
end
end

function UIHuanJingControl:showSdMultipleDialouge(type,layer,other)

local refresh=function(num)
local content="请选择本次扫荡合并的次数"
return content
end
local sdUse=cfgHelper.get3(cfg_houshanzhenlingjiecengconfig_get,type,layer,'sdUse')
local hasCount=itemsModel.getCount(sdUse[1])
local max=hasCount

local showdata=
{
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,
oktext='确定',
canceltext='取消',
max=max,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
self:req_Quick_Challenge_zhenling(type,layer,num)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIHuanJingControl:showBuyCountDialouge()
local condition=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'daySaoDang')
local dayBuyCount=condition[1]
local todayBuyCount=self.data.zlServerData.sdcsDayBuy
local lerpBuyNum=dayBuyCount-todayBuyCount
local costItemID=condition[2][1][1]

local content="是否是花费{0}{1}购买{2}枚{3}"
local itemId=condition[2][1][1]
local getItemId=condition[2][1][3]
local itemIconName=iconHelper.getIconName(itemId)
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
local getItemName=itemsModel.getName(getItemId)

local getCostAndGetNum=function(num)
local needNum=0
local getNum=0
for index=todayBuyCount+1,todayBuyCount+num do
local cost=condition[2][index]
needNum=needNum+cost[2]
getNum=getNum+cost[4]
end
return needNum,getNum
end

local refresh=function(num)
local needNum,getNum=getCostAndGetNum(num)
local needNumStr=needNum
if itemsModel.getCount(itemId)<needNum then
needNumStr=toColorString(FONT_COLOR.eRedColor,needNum)
end
local content=FMT.fmt(content,iconStr,needNumStr,getNum,getItemName)
return content
end

local showdata=
{
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,
oktext='确定',
canceltext='取消',
max=lerpBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum),
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local needNum=getCostAndGetNum(num)
moneySystem:useMoney(itemId,needNum,function()
UIHuanJingControl:req_buy_sdcs(num)
end,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
moneytypes={{costItemID},},
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIHuanJingControl:checkSdCount()
local condition=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'daySaoDang')
local dayBuyCount=condition[1]
local todayBuyCount=self.data.zlServerData.sdcsDayBuy
return dayBuyCount>todayBuyCount
end


function UIHuanJingControl:refreshHud()
local data=zongmenModel:getBuildingDataByBdId(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eHouShanMiJing,false)
if data and next(data)then
hudControl:refreshBuildingStatusHUD(data[1].un_build_id)
end
end


function UIHuanJingControl:dealZlNewDay5Am()
if self:isZhenlingFuncOpen()then
self:resetZlTodaySdCount()
self:resetZlTodayBuySdCount()
self:resetZLMoneyUnlock()
self:freshOpenList()
self:freshZLState()
end
end

function UIHuanJingControl:onZLSaoDangCostChange(list)
if list==nil then return end
if not self:isZhenlingFuncOpen()then return end
local costItemid=cfgHelper.get(cfg_houshanzhenlingbaseconfig_get,1,'idSdq')
for index,data in ipairs(list)do
local itemid=data[3]
if itemid==costItemid then
UIManager:invokeUIMethod('UIHuanJingZhenLingChallengeWin','refreshAll')
UIManager:invokeUIMethod('UIHuanJingSimpleSelectWin','refresh')
UIManager:invokeUIMethod('UIHouShanZLChallengeFightResultWin','refresh')
UIHuanJingControl:refreshHud()
end
end
end
