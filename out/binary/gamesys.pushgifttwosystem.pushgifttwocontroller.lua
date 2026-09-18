






local _MODULENAME="pushGiftTwoController"




gameState.addListener(def_table(_MODULENAME))
pushGiftTwoController.name=_MODULENAME
pushGiftTwoController.data={}

function pushGiftTwoController:onAppStart()

pushGiftTwoModel:onAppStart()


socketManager:register_receiver(15,31,pushGiftTwoController.recv_15_31)
socketManager:register_receiver(15,32,pushGiftTwoController.recv_15_32)
socketManager:register_receiver(15,33,pushGiftTwoController.recv_15_33)
end


function pushGiftTwoController:onEnterState(isReconnect)
pushGiftTwoModel:onEnterState()
self.advertIds=nil

end


function pushGiftTwoController:onProtocolReq()
pushGiftTwoModel:onProtocolReq()
pushGiftTwoManager:initalize()

end


function pushGiftTwoController:onProtocolReqKF()
pushGiftTwoManager:initalize()

end


function pushGiftTwoController:onLeaveState(isReconnect)
pushGiftTwoModel:onLeaveState(isReconnect)


self.data={}
self.advertIds=nil
end


function pushGiftTwoController:onLostConnection()

end


function pushGiftTwoController:onReConnection(isInitPro)

end





function pushGiftTwoController.recv_15_32(id,starttime,pushtimes)
pushGiftTwoModel:openGiftData(id,starttime,pushtimes)
pushGiftTwoController.openAdvertWin()
pushGiftTwoManager:freshEnter()
end




function pushGiftTwoController.recv_15_31(len,list)
pushGiftTwoModel:initDatas(len,list)
pushGiftTwoController.openAdvertWin()
end





function pushGiftTwoController.recv_15_33(id,idx,buytimes)
pushGiftTwoModel:setAlreadyBuyTimes(id,idx,buytimes)
UIManager:callWindowFunc('UIPushGiftAdvertWin','onBuySuccess',id,idx)
UIManager:callWindowFunc('UIPushGiftBuyWin','onBuySuccess',id,idx)
end

function pushGiftTwoController.openGift(id)
if platformIgnoreHelper.isIgnorePushGift(id)then
loggerUtil.log('已屏蔽礼包',id)
return
end
socketManager:send_15_32(id)
end

function pushGiftTwoController.buyGift(id,idx,optionLookup,defaultlookup)
local len=0
local temp={}
if optionLookup or defaultlookup then
local t={}
if optionLookup then
for hoidIdx,_idx in pairs(optionLookup)do
len=len+1
t[#t+1]={hoidIdx,_idx}
end
end

if defaultlookup then
for hoidIdx,_idx in pairs(defaultlookup)do
len=len+1
t[#t+1]={hoidIdx,_idx}
end
end

table.sort(t,function(a,b)
return a[1]<b[1]
end)

for _,v in ipairs(t)do
temp[#temp+1]=v[2]
end
end

socketManager:send_15_33(id,idx,1,len,temp)
end

function pushGiftTwoController.isOpenAdvert()
return pushGiftTwoController.data.openAdvert==true
end

function pushGiftTwoController.setOpenAdvert()
pushGiftTwoController.data.openAdvert=true
end

function pushGiftTwoController.onCloseAdvert()
pushGiftTwoController.data.openAdvert=false
pushGiftTwoController.openAdvertWin()
end

function pushGiftTwoController.openAdvertWin()
if not pushGiftTwoManager:isInitCfg()then return end
pushGiftTwoModel:initAllhideGift()
local ids=pushGiftTwoModel:getGiftAdvertIds()
if#ids<=0 then return end
if pushGiftTwoController.isOpenAdvert()then return end
pushGiftTwoModel:clearGiftAdvertIds()
pushGiftTwoController.setOpenAdvert()
pushGiftTwoController:setAdvertParams(ids)
msgWinControl:addMsgWin(msgWinType.ePushGiftTwo)
end

function pushGiftTwoController.delayDo(delay,func)
if pushGiftTwoController.dealyTimer then
pushGiftTwoController.dealyTimer:cancel()
end
pushGiftTwoController.dealyTimer=timer.new()
pushGiftTwoController.dealyTimer:start(delay,function()
func()
pushGiftTwoController.dealyTimer=nil
end,1)
end


function pushGiftTwoController:removeAdvertParams(id)
if UIManager:isActive('UIPushGiftAdvertWin')then return end
if self.advertIds==nil then return end
for i,v in ipairs(self.advertIds)do
if v==id then
_remove(self.advertIds,i)
break
end
end
end

function pushGiftTwoController:setAdvertParams(ids)
self.advertIds=ids
end

function pushGiftTwoController:getAdvertParams()
return self.advertIds
end