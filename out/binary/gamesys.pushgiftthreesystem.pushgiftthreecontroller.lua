






local _MODULENAME="pushGiftThreeController"




gameState.addListener(def_table(_MODULENAME))
pushGiftThreeController.name=_MODULENAME
pushGiftThreeController.data={}

function pushGiftThreeController:onAppStart()

pushGiftThreeModel:onAppStart()


socketManager:register_receiver(15,61,pushGiftThreeController.recv_15_61)
socketManager:register_receiver(15,62,pushGiftThreeController.recv_15_62)
socketManager:register_receiver(15,63,pushGiftThreeController.recv_15_63)
end


function pushGiftThreeController:onEnterState(isReconnect)
pushGiftThreeModel:onEnterState()
self.advertIds=nil
end


function pushGiftThreeController:onProtocolReq()
pushGiftThreeModel:onProtocolReq()
pushGiftThreeManager:initalize()
end


function pushGiftThreeController:onProtocolReqKF()
pushGiftThreeManager:initalize()
end


function pushGiftThreeController:onLeaveState(isReconnect)
pushGiftThreeModel:onLeaveState(isReconnect)

self.data={}
self.advertIds=nil
end


function pushGiftThreeController:onLostConnection()

end


function pushGiftThreeController:onReConnection(isInitPro)

end





function pushGiftThreeController.recv_15_62(id,starttime,pushtimes)
pushGiftThreeModel:openGiftData(id,starttime,pushtimes)
pushGiftThreeController.openAdvertWin()
pushGiftThreeManager:freshEnter()
end




function pushGiftThreeController.recv_15_61(len,list)
pushGiftThreeModel:initDatas(len,list)
pushGiftThreeController.openAdvertWin()

end





function pushGiftThreeController.recv_15_63(id,idx,buytimes)
pushGiftThreeModel:setAlreadyBuyTimes(id,idx,buytimes)
UIManager:callWindowFunc('UIPushGiftAdvertThreeWin','onBuySuccess',id,idx)
UIManager:callWindowFunc('UIPushGiftBuyThreeWin','onBuySuccess',id,idx)
end

function pushGiftThreeController.openGift(id)
if platformIgnoreHelper.isIgnorePushGift(id)then
loggerUtil.log('已屏蔽礼包',id)
return false
end
socketManager:send_15_62(id)
return true
end

function pushGiftThreeController.buyGift(id,idx,optionLookup,defaultlookup)
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

socketManager:send_15_63(id,idx,1,len,temp)
end

function pushGiftThreeController.isOpenAdvert()
return pushGiftThreeController.data.openAdvert==true
end

function pushGiftThreeController.setOpenAdvert()
pushGiftThreeController.data.openAdvert=true
end

function pushGiftThreeController.onCloseAdvert()
pushGiftThreeController.data.openAdvert=false
pushGiftThreeController.openAdvertWin()
end

function pushGiftThreeController.openAdvertWin()
if not pushGiftThreeManager:isInitCfg()then return end
pushGiftThreeModel:initAllhideGift()
local ids=pushGiftThreeModel:getGiftAdvertIds()
if#ids<=0 then return end
if pushGiftThreeController.isOpenAdvert()then return end
pushGiftThreeModel:clearGiftAdvertIds()
pushGiftThreeController.setOpenAdvert()
pushGiftThreeController:setAdvertParams(ids)
msgWinControl:addMsgWin(msgWinType.ePushGiftThree)
end

function pushGiftThreeController.delayDo(delay,func)
if pushGiftThreeController.dealyTimer then
pushGiftThreeController.dealyTimer:cancel()
end
pushGiftThreeController.dealyTimer=timer.new()
pushGiftThreeController.dealyTimer:start(delay,function()
func()
pushGiftThreeController.dealyTimer=nil
end,1)
end



function pushGiftThreeController:removeAdvertParams(id)
if UIManager:isActive('UIPushGiftAdvertWin')then return end
if self.advertIds==nil then return end
for i,v in ipairs(self.advertIds)do
if v==id then
_remove(self.advertIds,i)
break
end
end
end

function pushGiftThreeController:setAdvertParams(ids)
self.advertIds=ids
end

function pushGiftThreeController:getAdvertParams()
return self.advertIds
end