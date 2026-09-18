






local _MODULENAME="qqLobbyActController"

gameState.addListener(def_table(_MODULENAME))
qqLobbyActController.name=_MODULENAME
qqLobbyActController.data={}

function qqLobbyActController:onAppStart()

qqLobbyActModel:onAppStart()









end


function qqLobbyActController:onEnterState(isReconnect)
qqLobbyActModel:onEnterState()

notifySystem:listenNotify(notifyConfig.home_event,self.home_event)

end


function qqLobbyActController:onProtocolReq()
qqLobbyActModel:onProtocolReq()
end


function qqLobbyActController:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.home_event,self.home_event)

qqLobbyActModel:onLeaveState(isReconnect)

self.data={}
end


function qqLobbyActController:onLostConnection()

end


function qqLobbyActController:onReConnection(isInitPro)

end






function qqLobbyActController.home_event(eventType)
if eventType==homeEvent.eLeaveHome then
elseif eventType==homeEvent.eEnterHome then
qqLobbyActController:freshActEnter()
end
end



function qqLobbyActController:checkShowEnterCondition()
if not pfCommonHelper:isRunPC()then return false end

local qqPfid=cfgHelper.get2(cfg_globalconfig_get,1,'qqPfid')


local pfid=loginModel:getPfid()

return qqPfid==pfid
end

function qqLobbyActController:freshActEnter()
local isShow=qqLobbyActController:checkShowEnterCondition()
if not isShow then return end

if not self.data.enterGuid then
self.data.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eQQLobbyAct,getReddotFun=function()
return qqLobbyActController:getEnterReddot()
end})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eQQLobbyAct)
end
end




function qqLobbyActController:checkLoginRewardReddot()
local giftList=rechargeModel:getXianGouLiBaoConfig(shopLibaoType.eQQLobby_Login)
if giftList==nil or#giftList==0 then return false end
local giftCfg=giftList[1]
local giftId=giftCfg.id
local conditions=giftCfg.conditions
local isCanRecv=rechargeModel:checkXianGouLiBaoOpen(conditions)
local isRecved=rechargeModel:getXianGouLiBaoBuyNum(giftId)>0
return isCanRecv and(not isRecved)
end


function qqLobbyActController:checkDayActiveReddot()
local giftList=rechargeModel:getXianGouLiBaoConfig(shopLibaoType.eQQLobby_Active)
if giftList==nil or#giftList==0 then return false end
local giftCfg=giftList[1]
local giftId=giftCfg.id
local conditions=giftCfg.conditions
local isCanRecv=rechargeModel:checkXianGouLiBaoOpen(conditions)
local isRecved=rechargeModel:getXianGouLiBaoBuyNum(giftId)>0
return isCanRecv and(not isRecved)
end


function qqLobbyActController:checkLevelRewardReddot()
local giftList=rechargeModel:getXianGouLiBaoConfig(shopLibaoType.eQQLobby_Grown)
if giftList==nil or#giftList==0 then return false end

for index=1,#giftList do
local levelInfo=giftList[index]
local giftId=levelInfo.id
local conditions=levelInfo.conditions
local isCanRecv=rechargeModel:checkXianGouLiBaoOpen(conditions)
local isRecved=rechargeModel:getXianGouLiBaoBuyNum(giftId)>0

if isCanRecv and(not isRecved)then
return true
end
end

return false
end


function qqLobbyActController:getEnterReddot()
local loginRewardReddot=qqLobbyActController:checkLoginRewardReddot()
if loginRewardReddot then return true end

local dayActiveReddot=qqLobbyActController:checkDayActiveReddot()
if dayActiveReddot then return true end

local levelRewardReddot=qqLobbyActController:checkLevelRewardReddot()
if levelRewardReddot then return true end

return false
end