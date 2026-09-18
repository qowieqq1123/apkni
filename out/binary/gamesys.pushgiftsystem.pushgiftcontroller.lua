






local _MODULENAME="pushGiftController"




gameState.addListener(def_table(_MODULENAME))
pushGiftController.name=_MODULENAME
pushGiftController.data={}

function pushGiftController:onAppStart()

pushGiftModel:onAppStart()


socketManager:register_receiver(15,22,pushGiftController.recv_15_22)
socketManager:register_receiver(15,21,pushGiftController.recv_15_21)
socketManager:register_receiver(15,23,pushGiftController.recv_15_23)




















end


function pushGiftController:onEnterState(isReconnect)
pushGiftModel:onEnterState()
self.isPushGift=false
end


function pushGiftController:onProtocolReq()
pushGiftModel:onProtocolReq()
end


function pushGiftController:onLeaveState(isReconnect)
pushGiftModel:onLeaveState(isReconnect)
self.isPushGift=false

self.data={}
end


function pushGiftController:onLostConnection()

end


function pushGiftController:onReConnection(isInitPro)

end






function pushGiftController.recv_15_22(id,starttime,pushtimes)
pushGiftModel:openGiftData(id,starttime,pushtimes)
pushGiftManager:freshEnter()
if not pushGiftController.isPushGift then
pushGiftController.isPushGift=true
msgWinControl:addMsgWin(msgWinType.ePushGift,{id=id})
end
end




function pushGiftController.recv_15_21(len,list)
pushGiftModel:initDatas(len,list)
pushGiftManager:freshEnter()
if not pushGiftController.isPushGift then
pushGiftController.isPushGift=true
msgWinControl:addMsgWin(msgWinType.ePushGift)
end
end





function pushGiftController.recv_15_23(id,idx,buytimes)
pushGiftModel:setAlreadyBuyTimes(id,idx,buytimes)
if not pushGiftController.moveNext(id)then
UIManager:callWindowFunc('UIPushGiftWin','onBuySuccess',id,idx)
end
end

function pushGiftController:clearPush()
self.isPushGift=false
end

function pushGiftController.moveNext(id)
if not pushGiftModel:hasLeftBuyTimes(id)then
local ids=pushGiftModel:getGiftIds()
local len=#ids
local isFinal=len<=1
if not isFinal then
pushGiftModel:removeGiftData(id)
pushGiftManager:freshEnter()
end
UIManager:callWindowFunc('UIPushGiftWin','moveNext',id)
return not isFinal
end
end

function pushGiftController.checkAllGift()
local ids=pushGiftModel:getGiftIds()
local len=#ids
local clen=len
for i=len,1,-1 do
local id=ids[i]
if not pushGiftModel:hasLeftBuyTimes(id)then
pushGiftModel:removeGiftData(id)
pushGiftManager:freshEnter()
clen=clen-1
end
end
end

function pushGiftController.openGift(id)
if platformIgnoreHelper.isIgnorePushGift(id)then
loggerUtil.log('已屏蔽礼包',id)
return
end
socketManager:send_15_22(id)
end