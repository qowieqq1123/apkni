






local _MODULENAME="liandonController"

gameState.addListener(def_table(_MODULENAME))
liandonController.name=_MODULENAME
liandonController.data={}

function liandonController:onAppStart()

liandonModel:onAppStart()
socketManager:register_receiver(254,96,self.recv_254_96)








end


function liandonController:onEnterState(isReconnect)
liandonModel:onEnterState()

end


function liandonController:onProtocolReq()
liandonModel:onProtocolReq()
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)

end


function liandonController:onLeaveState(isReconnect)
liandonModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)

self.data={}
end


function liandonController:onLostConnection()

end


function liandonController:onReConnection(isInitPro)

end
function liandonController.on_item_list_changed(argsTable)
local flag=false
local flag2=false
local cardid=0
local list1={}
local list2={}
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldVal=v[4]
local newVal=v[5]
if changeType~=CHANGE_TYPE.eDelete then
if newVal>=1 then
local itemcfg=itemsConfig.getConfig(itemid)
local type1=itemcfg.type1
if type1==29 then
local xblist=xianbaoModel:CheckActiveItem()
for k,v in ipairs(xblist)do
list1[#list1+1]=v
end
else

local funcparam=itemcfg.funcparam
local discipleid=funcparam and funcparam.discipleid or nil
if discipleid then
local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(discipleid)
if isShuWuDZ then

local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,discipleid,'yuanpo')

local flag=liandonModel:CheckDiZiActive_Guanlian(discipleid)

local flag2=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(discipleid)
if flag or flag2 then

list2[#list2+1]={itemid,newVal,yuanpo[1],newVal*yuanpo[2]}
end
end

end
end
end
end
end
if next(list1)then
msgWinControl:addMsgWin(msgWinType.eLianDongZY,{list1,4})
end
if next(list2)then
msgWinControl:addMsgWin(msgWinType.eLianDongZY,{list2,1})
end
end


function liandonController:send_254_96(len,list)

if len<=0 then
return
end

if not liandonController.data.flag then
liandonController.data.flag=true
socketManager:send_254_96(len,list)
end

end


function liandonController.recv_254_96(len,list)
liandonController.data.flag=false
end






