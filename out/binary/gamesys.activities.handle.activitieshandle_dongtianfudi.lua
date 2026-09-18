





activitiesHandle_dongtianfudi=new_activitiesHandle('activitiesHandle_dongtianfudi',activitiesHandle)

function activitiesHandle_dongtianfudi:onInit()

end

activitiesHandle_dongtianfudi.exchangeMoneyType=
{
eMoneyType.mtYuJian1,
eMoneyType.mtYuJian2,
eMoneyType.mtYuJian3,
eMoneyType.mtYuJian4,
}


local InfoPageWin=
{
{
panel="UISubAct_dongtianfudi_gailv_Win",
name="信息",
},
{
panel="UISubAct_dongtianfudi_SelectWin",
name="宝库",
reddot=function(actid,act2id,fudi_idx)
local flag=activitiesHandle_dongtianfudi:getCanBuyTimes(actid,act2id,fudi_idx)
return flag==1
end,
},
}


function activitiesHandle_dongtianfudi:showGaiLvWin(baseWin,fudiIndex,args)
baseWin:showWindow("UISubAct_dongtianfudi_info_Win",{pageWinList=InfoPageWin,winIndex=1,fudiIndex=fudiIndex,args=args})
end

function activitiesHandle_dongtianfudi:showSelectWin(baseWin,fudiIndex,args)
baseWin:showWindow("UISubAct_dongtianfudi_info_Win",{pageWinList=InfoPageWin,winIndex=2,fudiIndex=fudiIndex,args=args})
end

function activitiesHandle_dongtianfudi:unlockPos()


local pos=Vector3(-9991.8,2.4,100)
local id=helper.getSortingLayerID("UIWindow")
local render={id,0}
UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","setPosButtonActive",false)
UIManager:showWindow("UIFlyIconWin",{guid=10001,args={1,40,nil,"定位",finishCall=function()

UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","setPosButtonActive",true)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.DongTianFuDiPosFunc)
end},pos=pos,render=render})
end

function activitiesHandle_dongtianfudi.sendPos(actid,act2id,idx)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eDongTianFuDi,act2id,jsonHelper.encode({1,idx}))
end

function activitiesHandle_dongtianfudi.sendLottery(actid,act2id,idx,is_assistant)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eDongTianFuDi,act2id,jsonHelper.encode({2,idx,is_assistant or 0}))
end

function activitiesHandle_dongtianfudi.sendBuy(actid,act2id,fudiIndex,idx,times)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,SUB_ACTIVITY_TYPE.eDongTianFuDi,act2id,jsonHelper.encode({3,fudiIndex,idx,times}))
end


function activitiesHandle_dongtianfudi.recv_249_74(args)
local subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
local actid,act2id,lottery_num,total_num,use_free_num,lock_idx,limit_num,limitList=unpack(args)
local limitData={}
if limitList then
for i,v in ipairs(limitList)do
limitData[v.param_1]=limitData[v.param_1]or{}
limitData[v.param_1][v.param_2]=v.param_3
end
end

local data=
{
lottery_num=lottery_num,
total_num=total_num,
use_free_num=use_free_num,
lock_idx=lock_idx,
limit_num=limit_num,
limitList=limitData,
}

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","onRecv")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_dongtianfudi.recv_249_75(actid,act2id,lock_idx)
local subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.lock_idx=lock_idx
activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_dongtianfudi_pos_win","refreshList")
UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","refreshFuDiPos")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_dongtianfudi.recv_249_76(args)
local actid,act2id,lottery_num,total_num,use_free_num,fudi_num,fudiList=args[1],args[2],args[3],args[4],args[5],args[6],args[7]

local subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)

local oldTotal=data.total_num

data.lottery_num=lottery_num
data.total_num=total_num
data.use_free_num=use_free_num

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

local config=activitiesModel:getSubActivityConfig(subType,act2id)
local lotteryList=config.lotteryList
local newFudiPosList={}
for i,v in ipairs(lotteryList)do
local needPosLo=v[2]
local isUnlock1=total_num>=needPosLo
local isOldUnlock=oldTotal>=needPosLo
if not isOldUnlock and isUnlock1 then
newFudiPosList[i]=true
end
end

UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","doAnim",function(win)
win:onRecv()
end,fudi_num,fudiList,newFudiPosList)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_dongtianfudi.recv_249_77(actid,act2id,fudi_idx,exchange_idx,num)
local subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)

local limitList=data.limitList or{}
limitList[fudi_idx]=limitList[fudi_idx]or{}

local config=activitiesModel:getSubActivityConfig(subType,act2id)
local lotteryList=config.lotteryList
local lottery=lotteryList[fudi_idx][6][exchange_idx]
local itemId=lottery[2]
limitList[fudi_idx][itemId]=(limitList[fudi_idx][itemId]or 0)+num

data.limitList=limitList

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:callWindowFunc("UISubAct_dongtianfudi_SelectWin","refreshItemList")
UIManager:callWindowFunc("UISubAct_dongtianfudi_info_Win","onRecv")
UIManager:callWindowFunc("UISubAct_dongtianfudi_Win","refreshFuDiReddot")

local showReward={{itemid=itemId,num=lottery[3]*num}}
showPrizeControl.showWindow(showReward)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_dongtianfudi:getCanBuyTimes(actid,act2id,fudi_idx)
local subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
local moneyType=self.exchangeMoneyType[fudi_idx]
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
local limitList=data.limitList or{}
limitList[fudi_idx]=limitList[fudi_idx]or{}
local money=moneyModel.getMoney(moneyType)
local config=activitiesModel:getSubActivityConfig(subType,act2id)
local lotteryList=config.lotteryList
local lottery
data.sortLottery=data.sortLottery or{}
if not data.sortLottery[fudi_idx]then
lottery=table.deepCopy(lotteryList[fudi_idx][6])
table.sort(lottery,function(a,b)
return a[1]>b[1]
end)
local l={}
for i=1,3 do
table.insert(l,lottery[4-i])
end

data.sortLottery[fudi_idx]=l
lottery=l
activitiesModel:setSubActInfoData(actid,subType,act2id,data)
else
lottery=data.sortLottery[fudi_idx]
end

local remain=money
local count=0
for i,v in ipairs(lottery)do
local prize=v[1]




local limit=v[4]
if limit~=0 then
local itemId=v[2]
local buyTimes=limitList[fudi_idx][itemId]or 0
local haveTimes=limit-buyTimes
if haveTimes>0 then
if haveTimes*prize>=remain then
if count+math.floor(remain/prize)>0 then
return 1,count+math.floor(remain/prize)
else
return 0,0
end
else
count=count+haveTimes
remain=remain-haveTimes*prize
end
end
else
if math.floor(remain/prize)==0 then
return 0,prize-remain
else
return 1,count+math.floor(remain/prize)
end
end
end
if remain>0 and count>0 then
return 1,count
end
end


function activitiesHandle_dongtianfudi:autoReceiveFreeLottery(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
local data=sub_actInfo.data
local use_free_num=data.use_free_num or 0
local config=activitiesModel:getSubActivityConfig(subType,sub_act_id)
local freeTimes=config.free_num
if freeTimes>use_free_num then
if checkReddot then
return true
end
local idx=1
local is_assistant=1
local jsonStr=jsonHelper.encode({2,idx,is_assistant})
table.insert(protocolData,{act_id,sub_act_id,jsonStr})
end
end
end
if#protocolData>0 then
for i,v in ipairs(protocolData)do
local act_id=v[1]
local sub_act_id=v[2]
local jsonStr=v[3]
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,jsonStr)
end
end
end
