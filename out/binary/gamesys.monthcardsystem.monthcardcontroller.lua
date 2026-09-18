






local _MODULENAME="MonthCardController"

gameState.addListener(def_table(_MODULENAME))
MonthCardController.name=_MODULENAME
MonthCardController.data={}


function MonthCardController:onAppStart()

MonthCardModel:onAppStart()









end


function MonthCardController:onEnterState(isReconnect)

MonthCardController.data.itemid={10633,10634,10631,10632}

MonthCardModel:onEnterState()
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end


function MonthCardController:onProtocolReq()
MonthCardModel:onProtocolReq()
end


function MonthCardController:onLeaveState(isReconnect)
MonthCardModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)


self.data={}
end


function MonthCardController:onLostConnection()

end


function MonthCardController:onReConnection(isInitPro)

end

function MonthCardController.on_item_list_changed(argsTable)

local flag=false

local flag2=false
local cardid=0
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldVal=v[4]
local newVal=v[5]
if changeType~=CHANGE_TYPE.eDelete then
if newVal>=1 then

if itemid and(itemid==MonthCardController.data.itemid[1]or itemid==MonthCardController.data.itemid[2])then
flag=true
end
if itemid and(itemid==MonthCardController.data.itemid[3]or itemid==MonthCardController.data.itemid[4])then
flag2=true
end

if itemid and(itemid==MonthCardController.data.itemid[1]or itemid==MonthCardController.data.itemid[3])then
cardid=1
end

if itemid and(itemid==MonthCardController.data.itemid[2]or itemid==MonthCardController.data.itemid[4])then
cardid=2
end
end
end
end
if flag then
msgWinControl:addMsgWin(msgWinType.eMonthCard,{1,cardid})
elseif flag2 then
msgWinControl:addMsgWin(msgWinType.eMonthCard,{2,cardid})
end

end


function MonthCardController:judeNotExpireItem(itemid)
local itemDict=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
if itemDict==nil then
return nil
end
for i,v in pairs(itemDict)do
if not bagUseControl.isItemExpire(v.itemguid)then
return v.itemguid
end
end
return nil
end





