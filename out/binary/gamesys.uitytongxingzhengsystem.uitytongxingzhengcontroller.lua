






local _MODULENAME="UITYTongXingZhengController"

gameState.addListener(def_table(_MODULENAME))
UITYTongXingZhengController.name=_MODULENAME
UITYTongXingZhengController.data={}

function UITYTongXingZhengController:onAppStart()

UITYTongXingZhengModel:onAppStart()


socketManager:register_receiver(29,15,UITYTongXingZhengController.recv_29_15)
socketManager:register_receiver(29,14,UITYTongXingZhengController.recv_29_14)
socketManager:register_receiver(29,13,UITYTongXingZhengController.recv_29_13)
socketManager:register_receiver(29,12,UITYTongXingZhengController.recv_29_12)
socketManager:register_receiver(29,11,UITYTongXingZhengController.recv_29_11)
socketManager:register_receiver(29,10,UITYTongXingZhengController.recv_29_10)

socketManager:register_receiver(29,17,UITYTongXingZhengController.recv_29_17)





















end


function UITYTongXingZhengController:onEnterState(isReconnect)
UITYTongXingZhengModel:onEnterState()
end


function UITYTongXingZhengController:onProtocolReq()
UITYTongXingZhengModel:onProtocolReq()
end


function UITYTongXingZhengController:onLeaveState(isReconnect)
UITYTongXingZhengModel:onLeaveState(isReconnect)

self.data={}
end


function UITYTongXingZhengController:onLostConnection()

end


function UITYTongXingZhengController:onReConnection(isInitPro)

end



function UITYTongXingZhengController.reqBuyExp(guid,upLevel)
socketManager:send_29_17(guid,upLevel)
end


function UITYTongXingZhengController.recv_29_17()

end





function UITYTongXingZhengController.recv_29_15(passport_guid,recv_times)
UITYTongXingZhengModel:setRecvTimes(passport_guid,recv_times)
UIManager:invokeUIMethod("UITYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIAct_TYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIXJYZTXZRewardsWin","refreshWin")

local actData=UITYTongXingZhengModel:getActIDByGuid(passport_guid)
if actData then
notifySystem:postNotify(notifyConfig.onSubActivityDontHandleReddotChange,actData[1],actData[2],actData[3])
end
end




function UITYTongXingZhengController.recv_29_14(len,passportItems)
local list
if len>0 then
list={}
local data=passportItems
for k,v in ipairs(data)do
local passport_guid=v.param_1
local score=v.param_3
local level=v.param_2
UITYTongXingZhengModel:setProgress(passport_guid,score,level)

local actData=UITYTongXingZhengModel:getActIDByGuid(passport_guid)
if actData then
notifySystem:postNotify(notifyConfig.onSubActivityDontHandleReddotChange,actData[1],actData[2],actData[3])
end
notifySystem:postNotify(notifyConfig.onTYTXZRewardChange,passport_guid)
end
end

UIManager:invokeUIMethod("UITYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIAct_TYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIXJYZTXZRewardsWin","refreshWin")
end









function UITYTongXingZhengController.recv_29_13(passport_guid,idx,invest_bits)
UITYTongXingZhengModel:setInvest_bits(passport_guid,invest_bits)
UIManager:invokeUIMethod("UITYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIAct_TYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIXJYZTXZRewardsWin","refreshWin")
notifySystem:postNotify(notifyConfig.onTYTXZRewardChange,passport_guid)

local actData=UITYTongXingZhengModel:getActIDByGuid(passport_guid)
if actData then
notifySystem:postNotify(notifyConfig.onSubActivityDontHandleReddotChange,actData[1],actData[2],actData[3])
end
end





function UITYTongXingZhengController.recv_29_12(passport_guid,len,recvList)
UITYTongXingZhengModel:setPrizeLayer(passport_guid,len,recvList)
UIManager:invokeUIMethod("UITYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIAct_TYTXZRewardsWin","refreshWin")
UIManager:invokeUIMethod("UIXJYZTXZRewardsWin","refreshWin")

notifySystem:postNotify(notifyConfig.onTYTXZRewardChange,passport_guid)

local actData=UITYTongXingZhengModel:getActIDByGuid(passport_guid)
if actData then
notifySystem:postNotify(notifyConfig.onSubActivityDontHandleReddotChange,actData[1],actData[2],actData[3])
end
end




function UITYTongXingZhengController.recv_29_11(len,passportItems)
for i=1,len do
local array=passportItems[i]
if array then
UITYTongXingZhengModel:addDatas(array)
end
end
end




function UITYTongXingZhengController.recv_29_10(len,passportItems)
local array=passportItems
UITYTongXingZhengModel:initDatas(len,array)

airGameEnterController:checkTXZOpen()
end





local _txzTypeUseWinList={
'UITYTXZRewardsWin',
'UITYTXZRewards_LevelWin',
}
function UITYTongXingZhengController:showTXZWin(guid,passportId)
if guid then
local txzId=UITYTongXingZhengModel:getTXZId(guid)
local type=cfgHelper.get2(cfg_passportconfig_get,txzId,'type')
local winName=_txzTypeUseWinList[type]
UIManager:showWindow(winName,{txzId=txzId,guid=guid,passportId=passportId})
end
end

function UITYTongXingZhengController:showXJYZTXZWin(guid,passportId)
if guid then
local txzId=UITYTongXingZhengModel:getTXZId(guid)
UIManager:showWindow("UIXJYZTXZRewardsWin",{txzId=txzId,guid=guid,passportId=passportId})
end
end

function UITYTongXingZhengController:checkReddot(guid)
return UITYTongXingZhengModel:getReddot(guid)
end

function UITYTongXingZhengController.getBaseInfo(id,name)
return cfgHelper.get2(cfg_passportmappedconfig_get,id,name)
end