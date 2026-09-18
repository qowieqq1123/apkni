






local _MODULENAME="hongChenJieController"

local _this

gameState.addListener(def_table(_MODULENAME))
hongChenJieController.name=_MODULENAME
hongChenJieController.data={}

function hongChenJieController:onAppStart()

hongChenJieModel:onAppStart()

socketManager:register_receiver(34,11,self.recv_34_11)
socketManager:register_receiver(34,12,self.recv_34_12)
socketManager:register_receiver(34,13,self.recv_34_13)
socketManager:register_receiver(34,14,self.recv_34_14)
socketManager:register_receiver(34,16,self.recv_34_16)
socketManager:register_receiver(34,17,self.recv_34_17)
socketManager:register_receiver(34,18,self.recv_34_18)
socketManager:register_receiver(34,27,self.recv_34_27)



socketManager:register_receiver(34,19,self.recv_34_19)
socketManager:register_receiver(34,20,self.recv_34_12)
socketManager:register_receiver(34,21,self.recv_34_13)
socketManager:register_receiver(34,22,self.recv_34_14)
socketManager:register_receiver(34,24,self.recv_34_16)
socketManager:register_receiver(34,25,self.recv_34_17)
socketManager:register_receiver(34,26,self.recv_34_18)
socketManager:register_receiver(34,28,self.recv_34_27)

_this=self
end


function hongChenJieController:onEnterState(isReconnect)
hongChenJieModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onNewDay,function(...)self:onNewDay(...)end)

notifySystem:listenNotify(notifyConfig.on_money_changed,function(...)self:on_money_changed(...)end)

timeEventController.addNormalTimerHandler(1,_this.name,_this)
end


function hongChenJieController:onProtocolReq()
hongChenJieModel:onProtocolReq()
end


function hongChenJieController:onLeaveState(isReconnect)
hongChenJieModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.onNewDay,function(...)self:onNewDay(...)end)

notifySystem:removelistener(notifyConfig.on_money_changed,function(...)self:on_money_changed(...)end)

timeEventController.removeNormalTimerHandler(1,_this.name)
end


function hongChenJieController:onLostConnection()

end


function hongChenJieController:onReConnection(isInitPro)

end



function hongChenJieController:reqInit()
socketManager:send_34_11()
end

function hongChenJieController:reqRandIdentiy(id,disciple_guid,state)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_20(id,disciple_guid,state)
else
socketManager:send_34_12(id,disciple_guid,state)
end
end

function hongChenJieController:reqStartGame(id,identity)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_21(id,identity)
else
socketManager:send_34_13(id,identity)
end
end

function hongChenJieController:reqGameEventNext(id)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_22(id)
else
socketManager:send_34_14(id)
end
end

function hongChenJieController:reqGameDisicionEventResult(id,event_id,choice_idx)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_23(id,event_id,choice_idx)
else
socketManager:send_34_15(id,event_id,choice_idx)
end
end

function hongChenJieController:reqRankingData(id)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_24(id)
else
socketManager:send_34_16(id)
end
end

function hongChenJieController:reqReciveRankingReward(id,type,idx)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_25(id,type,idx)
else
socketManager:send_34_17(id,type,idx)
end
end

function hongChenJieController:reqBuyLLCount(id,num)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_26(id,num)
else
socketManager:send_34_18(id,num)
end
end

function hongChenJieController:reqReceiveTaskReward(id)
if hongChenJieModel:isCrossServer(id)then
socketManager:send_34_28(id)
else
socketManager:send_34_27(id)
end
end


function hongChenJieController.recv_34_11(id,data)
hongChenJieModel:unpackServerData(id,data,false)

hongChenJieController:postNotifyProgress(id)
end

function hongChenJieController.recv_34_12(args)
local id,identityList,refreshTimes,refreshFreeStamp,state,guid,times=unpack(args)

hongChenJieModel:setRefreshFreeStamp(id,refreshFreeStamp)
hongChenJieModel:setRefreshedTimes(id,refreshTimes)
hongChenJieModel:setIdentityList(id,identityList,state)
hongChenJieModel:refreshSelectGuid(id,guid)
hongChenJieModel:refreshTimes(id,times)
end

function hongChenJieController.recv_34_13(id,hcjData)
hongChenJieModel:setGameData(id,hcjData)
end

function hongChenJieController.recv_34_14(id,eventData)
hongChenJieModel:addNewEvent(id,eventData)
end

function hongChenJieController.recv_34_16(id,len1,rankList,len2,achieve_lsit)
hongChenJieModel:updateRankingList(id,len1,rankList,len2,achieve_lsit)

UIManager:invokeUIMethod('UIHongChenJieRankingWin','refreshList')
UIManager:invokeUIMethod('UIHongChenJieMainWin','refreshLeft')
end

function hongChenJieController.recv_34_17(id,type,idx)
hongChenJieModel:setRankingRewardFlag(id,type,idx)

UIManager:invokeUIMethod('UIHongChenJieRankingWin','refreshList')

UIManager:invokeUIMethod('UIHongChenJieMainWin','refreshLeft')
end

function hongChenJieController.recv_34_18(id,buy_times)
UIManager.info('购买成功')

hongChenJieModel:setBuyTimes(id,buy_times)

UIManager:invokeUIMethod('UIHongChenJieMainWin','refreshTimes')
end

function hongChenJieController.recv_34_27(id,idxFlag)
hongChenJieModel:setTaskRewardFlag(id,idxFlag)

UIManager:invokeUIMethod('UIHongChenJieGWRewardWin','refreshItems')

UIManager:invokeUIMethod('UIHongChenJieMainWin','refreshLeft')
end


function hongChenJieController.recv_34_19(id,data)

hongChenJieModel:unpackServerData(id,data,true)


hongChenJieController:postNotifyProgress(id)
end





function hongChenJieController:checkEndHongChenJieGame(id)
local info=hongChenJieModel:getGameHandle(id)
local isEnd=info:checkGameEnd()
if isEnd then

info:endGameData()

UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showMainWin({id=id})
end)
else

local tid=id
local okfunc=function()
UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showMainWin({id=tid})
end)
end
local showdata=
{
type='UIDialouge',
title='提示',
content='红尘劫进行中,是否确认退出？\n(下次进入可选择以当前进度继续体验)',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okfunc,
showclosebtn=true,
}
local quitDialog=UIDialogManager.newDialog(showdata)
quitDialog:show()
end
end


function hongChenJieController:getProgress(id)
return hongChenJieModel:getProgress(id)
end

function hongChenJieController:getReddot(id)
return hongChenJieModel:getReddot(id)
end

function hongChenJieController:getSystemFinishState(id)
return hongChenJieModel:getSystemFinishState(id)
end


function hongChenJieController:postNotifyProgress(id)
local postFuncs=hongChenJieConfig.getPostNotifyProgress(id)
if postFuncs and postFuncs.notifyFunc then
postFuncs.notifyFunc(id)
end
end


function hongChenJieController:onNewDay()
end

function hongChenJieController:on_money_changed(moneyType,lastVal,val,changeType)
hongChenJieModel:DoPostNotify(moneyType)
end


function hongChenJieController:onNormalUpdate(delay)
hongChenJieModel:updateFreeTimes()
end




function hongChenJieController:printRankingData(id)

local data=hongChenJieModel:getGameHandle(id)
local rankingDataList=data:getRankingDataList()

end

function hongChenJieController:printRankingStateData(id)

local data=hongChenJieModel:getGameHandle(id)

end


function hongChenJieController:printInfoData(id,isData,name)
local data=hongChenJieModel:getGameHandle(id)

if isData then
data=data.data
end

if type(data[name])=='table'then

else

end
end
