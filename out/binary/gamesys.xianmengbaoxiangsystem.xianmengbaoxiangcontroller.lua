






local _MODULENAME="xianMengBaoXiangController"

gameState.addListener(def_table(_MODULENAME))
xianMengBaoXiangController.name=_MODULENAME
xianMengBaoXiangController.data={}

function xianMengBaoXiangController:onAppStart()

xianMengBaoXiangModel:onAppStart()


socketManager:register_receiver(20,144,xianMengBaoXiangController.recv_20_144)
socketManager:register_receiver(20,143,xianMengBaoXiangController.recv_20_143)
socketManager:register_receiver(20,145,xianMengBaoXiangController.recv_20_145)
socketManager:register_receiver(20,146,xianMengBaoXiangController.recv_20_146)



















end


function xianMengBaoXiangController:onEnterState(isReconnect)
xianMengBaoXiangModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function xianMengBaoXiangController:onProtocolReq()
xianMengBaoXiangModel:onProtocolReq()
end


function xianMengBaoXiangController:onLeaveState(isReconnect)
xianMengBaoXiangModel:onLeaveState(isReconnect)

self.data={}
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function xianMengBaoXiangController:onLostConnection()

end


function xianMengBaoXiangController:onReConnection(isInitPro)

end

function xianMengBaoXiangController.onNewDay5am()
xianMengBaoXiangModel:setReceiveNum(0)
UIManager:invokeUIMethod('UIXMZengLiTabWin','refreshTab')
UIManager:invokeUIMethod('UIXMZengLiWin','refreshWin')
reddotControl.on_change_catch_type(CATCH_TYPE.eXMZengLi)
end








function xianMengBaoXiangController.recv_20_143(len,boxList,nmFlag,dayNum)
if len>0 then
xianMengBaoXiangModel:setBoxList(boxList)
else
xianMengBaoXiangModel:setBoxList({})
end
xianMengBaoXiangModel:setNMFlag(nmFlag)
xianMengBaoXiangModel:setReceiveNum(dayNum)

UIManager:invokeUIMethod('UIXMZengLiTabWin','refreshTab')
UIManager:invokeUIMethod('UIXMZengLiWin','refreshWin')
reddotControl.on_change_catch_type(CATCH_TYPE.eXMZengLi)
end





function xianMengBaoXiangController.recv_20_144(len,guidList,dayNum)
xianMengBaoXiangModel:setReceiveNum(dayNum)

if len>0 then
for k,v in ipairs(guidList)do
xianMengBaoXiangModel:setReceiveState(v)
end
end

UIManager:invokeUIMethod('UIXMZengLiTabWin','refreshTab')
reddotControl.on_change_catch_type(CATCH_TYPE.eXMZengLi)
end



function xianMengBaoXiangController.recv_20_145(nmFlag)
xianMengBaoXiangModel:setNMFlag(nmFlag)
end


function xianMengBaoXiangController.recv_20_146()
socketManager:send_20_143()
end





function xianMengBaoXiangController:check_item_not_use()
local list=itemsLookup:getItemsByBag(item_funtion_type.eXMZengLi)

if list and#list>0 then
for k,v in ipairs(list)do
local itemId=v.id
local count=itemsModel.getCount(itemId)
if count>0 then
bagProtocolControl.req_use_item(itemId,count)
end
end
end
end