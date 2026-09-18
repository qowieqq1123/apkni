






local _MODULENAME="jiuchongtianjieFirstAscentController"

gameState.addListener(def_table(_MODULENAME))
jiuchongtianjieFirstAscentController.name=_MODULENAME
jiuchongtianjieFirstAscentController.data={}

function jiuchongtianjieFirstAscentController:onAppStart()

jiuchongtianjieFirstAscentModel:onAppStart()

socketManager:register_receiver(34,160,self.recv_34_160)
socketManager:register_receiver(34,161,self.recv_34_161)
socketManager:register_receiver(34,162,self.recv_34_162)
end


function jiuchongtianjieFirstAscentController:onEnterState(isReconnect)
jiuchongtianjieFirstAscentModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function jiuchongtianjieFirstAscentController:onProtocolReq()
jiuchongtianjieFirstAscentModel:onProtocolReq()
end


function jiuchongtianjieFirstAscentController:onLeaveState(isReconnect)
jiuchongtianjieFirstAscentModel:onLeaveState(isReconnect)

self.data={}
self.actEnterId=nil

notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
end


function jiuchongtianjieFirstAscentController:onLostConnection()

end


function jiuchongtianjieFirstAscentController:onReConnection(isInitPro)

end





function jiuchongtianjieFirstAscentController:req_firstAscentInfoRecv()
socketManager:send_34_160()
end


function jiuchongtianjieFirstAscentController:req_firstAscentLike(likeNum,assistant)
socketManager:send_34_161(likeNum or 1,assistant or 0)
end


function jiuchongtianjieFirstAscentController.recv_34_160(args)
local serverId=args[1]
local actorId=args[2]
local name=args[3]
local iconInfo=args[4]
local fsTime=args[5]
local likeCount=args[6]
local likeTotal=args[7]

jiuchongtianjieFirstAscentModel:setInitData(serverId,actorId,name,iconInfo,fsTime,likeCount,likeTotal)

msgWinControl:addMsgWin(msgWinType.eFirstAscentTips,{})
jiuchongtianjieFirstAscentController:freshActEnter()
end


function jiuchongtianjieFirstAscentController.recv_34_161(likeCount,assistant,likeTotal)


jiuchongtianjieFirstAscentModel:setLikeCount(likeCount,likeTotal)
UIManager:invokeUIMethod("UIJiuChongTianJieFirstAscentWin",'refreshLike')

jiuchongtianjieFirstAscentController:freshActEnter()
end


function jiuchongtianjieFirstAscentController.recv_34_162(serverId,actorId,name,iconInfo,fsTime)
jiuchongtianjieFirstAscentModel:setInitData(serverId,actorId,name,iconInfo,fsTime,0)

msgWinControl:addMsgWin(msgWinType.eFirstAscentTips,{})
jiuchongtianjieFirstAscentController:freshActEnter()
end



function jiuchongtianjieFirstAscentController.onNewDay()
if not jiuchongtianjieFirstAscentController.isOpen()then
return
end
jiuchongtianjieFirstAscentModel:refreshFSDay()
UIManager:invokeUIMethod("UIJiuChongTianJieFirstAscentWin",'refreshLike')

jiuchongtianjieFirstAscentController:freshActEnter()
end


function jiuchongtianjieFirstAscentController:freshActEnd()
timeEventController.delayDo(1,function()
jiuchongtianjieFirstAscentModel:refreshFSDay()
jiuchongtianjieFirstAscentController:freshActEnter()
UIManager:invokeUIMethod("UIJiuChongTianJieFirstAscentWin",'closeSelf')
end)
end


function jiuchongtianjieFirstAscentController.isOpen()
local data=jiuchongtianjieFirstAscentModel:getData()
if not data or not next(data)then
return false
end
return true
end

function jiuchongtianjieFirstAscentController:freshActEnter()
if not jiuchongtianjieFirstAscentController.isOpen()then
return
end
local fsDay=jiuchongtianjieFirstAscentModel:getFSDay()
local days=cfgHelper.get2(cfg_shouweifeishengtishibaseconfig_get,1,"days")
if fsDay<=days then
if self.actEnterId==nil then
self.actEnterId=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eFirstAscent,getReddotFun=function()
return jiuchongtianjieFirstAscentModel:checkReddot()
end})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eFirstAscent)
end
else
if self.actEnterId then
enterManager:removeEnter(self.actEnterId)
self.actEnterId=nil
end
end
end

