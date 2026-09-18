






local _MODULENAME="xjFactionNPCController"

gameState.addListener(def_table(_MODULENAME))
xjFactionNPCController.name=_MODULENAME
xjFactionNPCController.data={}

function xjFactionNPCController:onAppStart()

xjFactionNPCModel:onAppStart()

socketManager:register_receiver(37,105,self.recv_37_105)
socketManager:register_receiver(37,106,self.recv_37_106)
socketManager:register_receiver(37,107,self.recv_37_107)
socketManager:register_receiver(37,108,self.recv_37_108)
socketManager:register_receiver(37,109,self.recv_37_109)
socketManager:register_receiver(37,110,self.recv_37_110)
socketManager:register_receiver(37,111,self.recv_37_111)
socketManager:register_receiver(37,112,self.recv_37_112)

notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function xjFactionNPCController:onEnterState(isReconnect)
xjFactionNPCModel:onEnterState()
end


function xjFactionNPCController:onProtocolReq()
xjFactionNPCModel:onProtocolReq()
end


function xjFactionNPCController:onLeaveState(isReconnect)
xjFactionNPCModel:onLeaveState(isReconnect)

self.data={}
end


function xjFactionNPCController:onLostConnection()

end


function xjFactionNPCController:onReConnection(isInitPro)

end







function xjFactionNPCController:send_37_105(npcId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_105(npcId)
end


function xjFactionNPCController:send_37_106(npcId,itemList)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_106(npcId,#itemList,itemList)
end


function xjFactionNPCController:send_37_107(npcId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_107(npcId)
end


function xjFactionNPCController:send_37_108(npcId,chatId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_108(npcId,chatId)
end


function xjFactionNPCController:send_37_109(factionId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_109(factionId)
end


function xjFactionNPCController:send_37_110(npcId,taskId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_110(npcId,taskId)
end

function xjFactionNPCController:send_37_111()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_111()
end


function xjFactionNPCController:send_37_112(npcId,taskId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

socketManager:send_37_112(npcId,taskId)
end


function xjFactionNPCController.recv_37_105(result,npcId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

if result==0 then
xjFactionNPCModel:addNPCData(npcId)

local faction=xjFactionNPCModel:findFactionByNpc(npcId)
notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,{faction})

if faction==xianjieForceType.eXianGong then
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFaction_XianGong)
end
end
end


function xjFactionNPCController.recv_37_106(args)
local npcId=args[1]
local level=args[2]
local relation=args[3]
local itemLen=args[4]
local itemList=args[5]
local addFree=args[6]
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end
local oldFree=xjFactionNPCModel:getNPCDailyFree(npcId)
xjFactionNPCModel:setNPCDailyFree(npcId,addFree)
xjFactionNPCModel:addNPCGiftCount(npcId,itemList)
local npcLvChange=xjFactionNPCModel:setNPCRelation(npcId,relation)
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local reputationLvChange=xjFactionNPCModel:refreshReputation(faction)
UIManager.info("赠礼成功")
notifySystem:postNotify(notifyConfig.onXianGongNPCRelationChange,npcId,npcLvChange,reputationLvChange,1)
notifySystem:postNotify(notifyConfig.onXianGongNPCDailyFreeChange,npcId,oldFree,addFree)


notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,xjFactionNPCModel.allFactionList)

if faction==xianjieForceType.eXianGong then
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFaction_XianGong)
end

end


function xjFactionNPCController.recv_37_107(result,npcId,flag,relation)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

if result==0 then
xjFactionNPCModel:setNPCFlag(npcId,flag)
end
end


function xjFactionNPCController.recv_37_108(result,message)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

if result==0 then
xjFactionNPCModel:setMessageRecved(message)
end
end


function xjFactionNPCController.recv_37_109(result,faction,flag)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

if result==0 then
xjFactionNPCModel:setFactionFlag(faction,flag)

notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,{faction})

if faction==xianjieForceType.eXianGong then
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFaction_XianGong)
end
end
end


function xjFactionNPCController.recv_37_110(result,npcId,taskId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

if result==0 then



local faction=xjFactionNPCModel:findFactionByNpc(npcId)
notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,{faction})

if faction==xianjieForceType.eXianGong then
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFaction_XianGong)
end
end
end


function xjFactionNPCController.recv_37_111(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

xjFactionNPCModel:initNPCData(args)
xjFactionNPCModel:initFactionData(args[10])
xjFactionNPCModel:initMessageData(args[6])

if initProControl:isDone()then
xjFactionNPCController:onProtocolReq()
end
end

function xjFactionNPCController.recv_37_112(result,npcId,taskId)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

if result==0 then
taskController.do_protocol_7_23(taskId,1,0)

xjFactionNPCModel:finishNPCTask(npcId,taskId)

local config=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,taskId)
if config then
local list={}
local haveXianGong=false
for i,v in pairs(config.feel_add)do
local npcId=v[1]
local value=v[2]
local relation=xjFactionNPCModel:getNPCRelation(npcId)
relation=relation+value
local npcLvChange=xjFactionNPCModel:setNPCRelation(npcId,relation)
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local reputationLvChange=xjFactionNPCModel:refreshReputation(faction)

notifySystem:postNotify(notifyConfig.onXianGongNPCRelationChange,npcId,npcLvChange,reputationLvChange,2)
if npcLvChange or reputationLvChange then
table.insert(list,faction)

haveXianGong=faction==xianjieForceType.eXianGong or haveXianGong
end
end
if#list>0 then

notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,xjFactionNPCModel.allFactionList)

if haveXianGong then
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFaction_XianGong)
end
end
end
end
end

function xjFactionNPCController.on_item_list_changed(array,guidLookup,idLookup)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end

local lookup={}
for itemId,_ in pairs(idLookup)do
local npcs=xjFactionNPCModel:findNPCByUnlockItemId(itemId)
if npcs then
for index,npcId in ipairs(npcs)do
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
lookup[faction]=true
end
end
end
local list={}
local haveXianGong=false
for faction,_ in pairs(lookup)do
table.insert(list,faction)
haveXianGong=faction==xianjieForceType.eXianGong or haveXianGong
end
if#list>0 then
notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,list)

if haveXianGong then
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFaction_XianGong)
end
end
end

function xjFactionNPCController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eXianJieShiLiJH then
xjFactionNPCController:send_37_111()
end
end

function xjFactionNPCController.onNewDay()
xjFactionNPCModel:clearNPCDailyFree()
notifySystem:postNotify(notifyConfig.onXianGongNPCDailyFreeChange)
notifySystem:postNotify(notifyConfig.onXianJieFactionReddotChange,xjFactionNPCModel.allFactionList)
end