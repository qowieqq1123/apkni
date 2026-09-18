






local _MODULENAME="blueDiamondController"

gameState.addListener(def_table(_MODULENAME))
blueDiamondController.name=_MODULENAME
blueDiamondController.data={}

function blueDiamondController:onAppStart()

blueDiamondModel:onAppStart()

socketManager:register_receiver(254,124,self.recv_254_124)
end


function blueDiamondController:onEnterState(isReconnect)
blueDiamondModel:onEnterState()

notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)
end


function blueDiamondController:onProtocolReq()
blueDiamondModel:onProtocolReq()
end


function blueDiamondController:onLeaveState(isReconnect)
blueDiamondModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)


self.data={}
self.actEnterId=nil
end


function blueDiamondController:onLostConnection()

end


function blueDiamondController:onReConnection(isInitPro)

end




function blueDiamondController:send_254_124()
socketManager:send_254_124()
end

function blueDiamondController.recv_254_124(blueinfo,blueexpire)
if pfwindowslController:checkIsGameVersion_guofu()then
blueDiamondModel:setBuleData(blueinfo,blueexpire)

notifySystem:postNotify(notifyConfig.onActorBlueDiamondChange)
notifySystem:postNotify(notifyConfig.onActorHeadChange,true)

blueDiamondController:freshActEnter()

reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end
end





function blueDiamondController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eBlueDiamond or sysId==0 then
blueDiamondController:freshActEnter()
end
end

function blueDiamondController.onReddotCatchTypeChange(catchType,...)
if catchType==CATCH_TYPE.eXianGouLiBao then
blueDiamondController:freshActEnterReddot()
end
end

function blueDiamondController:freshActEnterReddot()
if self.actEnterId then
enterManager:freshFunc('freshReddot',ENTER_TYPE.eBlueDiamond)
end
end

function blueDiamondController:freshActEnter()
local isOpen=blueDiamondModel:checkOpen()
if isOpen then
if self.actEnterId==nil then
self.actEnterId=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eBlueDiamond,getReddotFun=function()
return blueDiamondModel:checkReddot()
end})
end
else
if self.actEnterId then
enterManager:removeEnter(self.actEnterId)
self.actEnterId=nil
end
end
end
