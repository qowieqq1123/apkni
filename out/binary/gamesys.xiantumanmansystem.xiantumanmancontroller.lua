






local _MODULENAME="XianTuManManController"

gameState.addListener(def_table(_MODULENAME))
XianTuManManController.name=_MODULENAME
XianTuManManController.data={}

function XianTuManManController:onAppStart()

XianTuManManModel:onAppStart()


socketManager:register_receiver(30,11,XianTuManManController.recv_30_11)
socketManager:register_receiver(30,12,XianTuManManController.recv_30_12)






end


function XianTuManManController:onEnterState(isReconnect)
XianTuManManModel:onEnterState()
if isReconnect then
return
end
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end


function XianTuManManController:onProtocolReq()
XianTuManManModel:onProtocolReq()
end


function XianTuManManController:onLeaveState(isReconnect)
XianTuManManModel:onLeaveState(isReconnect)
if isReconnect then
return
end
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)
if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end

self.data={}
end


function XianTuManManController:onLostConnection()

end


function XianTuManManController:onReConnection(isInitPro)

end






function XianTuManManController.recv_30_11(login_days,rewards_idx)
local data={}
data.login_days=login_days
data.rewards_idx=rewards_idx
XianTuManManModel:setData(data)
if XianTuManManController:getXTMMEnterReddot()then
msgWinControl:addMsgWin(msgWinType.eXianTuManMan)
end
XianTuManManController:freshEnter()
end


function XianTuManManController.recv_30_12()
local cfg=XianTuManManModel:getConfig()
local loginDay=XianTuManManModel:getData_loginDay()
local idx
for i,v in ipairs(cfg)do
if v.need_days<=loginDay then
idx=v.id
end
end
XianTuManManModel:setData_rewardsIdx(idx)
UIManager:invokeUIMethod("UIXianTuManManWin","refresh")
XianTuManManController:freshEnter()
end


function XianTuManManController.req_30_12()
socketManager:send_30_12()
end



function XianTuManManController:freshEnter()
local flag=self:checkEnter()
if flag then
if not self.enterGuid then
self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eXianTuManMan})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eXianTuManMan)
end
else
self:removeEnter()
end
end


function XianTuManManController:removeEnter()
if not self.enterGuid then return end
enterManager:freshFunc('onClose',ENTER_TYPE.eXianTuManMan)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then
UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end


function XianTuManManController:checkEnter()
if not self:checkSys()then
return false
end
if self:checkRecvAll()then
return false
end
return true
end


function XianTuManManController:checkSys()
return systemModel.isOpen(SYSTEM_DEFINE.eXianTuManMan)
end

function XianTuManManController:getXTMMEnterReddot()
if not self:checkEnter()then
return false
end
local rewardsIdx=XianTuManManModel:getData_rewardsIdx()
local cfg=XianTuManManModel:getConfig()
local nextRewardsIdx=rewardsIdx+1
local nextCfg=cfg[nextRewardsIdx]
if not nextCfg then
return false
end
local nextNeedDay=nextCfg.need_days
local loginDay=XianTuManManModel:getData_loginDay()
if nextNeedDay<=loginDay then
return true
end
return false
end


function XianTuManManController:checkRecvAll()
local cfg=XianTuManManModel:getConfig()
local rewardsIdx=XianTuManManModel:getData_rewardsIdx()
return rewardsIdx>=#cfg
end

function XianTuManManController.onNewDay()
local loginDay=XianTuManManModel:getData_loginDay()
XianTuManManModel:setData_loginDay(loginDay+1)
UIManager:invokeUIMethod("UIXianTuManManWin","onShow")
XianTuManManController:freshEnter()
end

function XianTuManManController.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXianTuManMan then
XianTuManManController:freshEnter()
if XianTuManManController:getXTMMEnterReddot()then
msgWinControl:addMsgWin(msgWinType.eXianTuManMan)
end
end
end