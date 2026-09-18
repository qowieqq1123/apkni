






local _MODULENAME="mountController"

gameState.addListener(def_table(_MODULENAME))
mountController.name=_MODULENAME
mountController.data={}

function mountController:onAppStart()

mountModel:onAppStart()


socketManager:register_receiver(2,102,mountController.recv_2_102)
socketManager:register_receiver(2,101,mountController.recv_2_101)
socketManager:register_receiver(2,103,mountController.recv_2_103)




















notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDZJingJieChange)
socketManager:addNotify(2,8,function(...)self.onDZJobChange(...)end)
end


function mountController:onEnterState(isReconnect)
mountModel:onEnterState()
end


function mountController:onProtocolReq()
mountModel:onProtocolReq()
end


function mountController:onLeaveState(isReconnect)
mountModel:onLeaveState(isReconnect)

self.data={}
end


function mountController:onLostConnection()

end


function mountController:onReConnection(isInitPro)

end






function mountController.recv_2_102(dzguid)
local item=mountModel:getMountByDZ(dzguid)
mountModel:onTakeoff(dzguid)
UIManager:callWindowFunc('UIEquipWin','onChangeMount',dzguid)
UIManager:callWindowFunc('UIDZMountWin','onChangeMount',dzguid,item.itemguid,item.itemid)
notifySystem:postNotify(notifyConfig.onMountChanged,dzguid)
end




function mountController.recv_2_101(dzguid,itemguid)
local item=bagModel.getItem(itemguid)
mountModel:onDress(dzguid,itemguid)
UIManager:callWindowFunc('UIEquipWin','onChangeMount',dzguid)
UIManager:callWindowFunc('UIDZMountWin','onChangeMount',dzguid,itemguid,item.itemid)
notifySystem:postNotify(notifyConfig.onMountChanged,dzguid)

AudioManager.playAudio(632)
end




function mountController.recv_2_103(dzguid1,dzguid2)
local equip1=mountModel:getMountByDZ(dzguid1)
local equip2=mountModel:getMountByDZ(dzguid2)
if equip2 then
mountModel:changeMount(dzguid1,equip2,true)
UIManager:callWindowFunc('UIEquipWin','onChangeMount',dzguid1)
UIManager:callWindowFunc('UIDZMountWin','onChangeMount',dzguid1,equip2.itemguid,equip2.itemid)
else
mountController.recv_2_102(dzguid1)
end
if equip1 then
mountModel:changeMount(dzguid2,equip1,true)
UIManager:callWindowFunc('UIEquipWin','onChangeMount',dzguid2)
UIManager:callWindowFunc('UIDZMountWin','onChangeMount',dzguid2,equip1.itemguid,equip1.itemid)
else
mountController.recv_2_102(dzguid2)
end
notifySystem:postNotify(notifyConfig.onMountChanged,dzguid1)
notifySystem:postNotify(notifyConfig.onMountChanged,dzguid2)

AudioManager.playAudio(632)
end


function mountController.reqDress(dzguid,itemguid)
socketManager:send_2_101(dzguid,itemguid)
end

function mountController.reqTakeOff(dzguid)
socketManager:send_2_102(dzguid)
end

function mountController.reqExchange(dzguid1,dzguid2)
socketManager:send_2_103(dzguid1,dzguid2)
end


function mountController.onDZJingJieChange(dzguid,old_jjlv,jingjielv)
if old_jjlv==jingjielv then return end
mountHelper.freshRoleMoveMount(dzguid)
end

function mountController.onDZJobChange(dzguid)
mountHelper.freshRoleMoveMount(dzguid)
end