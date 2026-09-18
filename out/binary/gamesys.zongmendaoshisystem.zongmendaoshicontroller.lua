






local _MODULENAME="ZongMenDaoShiController"

gameState.addListener(def_table(_MODULENAME))
ZongMenDaoShiController.name=_MODULENAME
ZongMenDaoShiController.data={}
ZongMenDaoShiController.isOpenDaoShi=false

function ZongMenDaoShiController:onAppStart()

ZongMenDaoShiModel:onAppStart()


socketManager:register_receiver(34,91,ZongMenDaoShiController.recv_34_91)
socketManager:register_receiver(34,92,ZongMenDaoShiController.recv_34_92)














end


function ZongMenDaoShiController:onEnterState(isReconnect)
ZongMenDaoShiModel:onEnterState()
end


function ZongMenDaoShiController:onProtocolReq()
ZongMenDaoShiModel:onProtocolReq()
end


function ZongMenDaoShiController:onLeaveState(isReconnect)
ZongMenDaoShiModel:onLeaveState(isReconnect)

self.data={}
self.isOpenDaoShi=false
end


function ZongMenDaoShiController:onLostConnection()

end


function ZongMenDaoShiController:onReConnection(isInitPro)

end



function ZongMenDaoShiController.send_34_92(syssect_guid)
socketManager:send_34_92(syssect_guid)
end




function ZongMenDaoShiController.recv_34_91(len,list)
if len>0 then
ZongMenDaoShiModel:initZMDaoShiList(list)
ZongMenDaoShiController.isOpenDaoShi=true
UIManager:invokeUIMethod("UIZongMenDaoShiWin","onShow")

notifySystem:postNotify(notifyConfig.onZMDaoShiChange)
end
end



function ZongMenDaoShiController.recv_34_92(syssect_guid)
ZongMenDaoShiModel:addZMDaoShiList(syssect_guid)
UIManager:invokeUIMethod("UIZongMenDaoShiWin","onShow")

notifySystem:postNotify(notifyConfig.onZMDaoShiChange)
JiuChongTianJieEnterController:refreshReddot()
end




function ZongMenDaoShiController:isOpenZongMenDaoShi()
return self.isOpenDaoShi
end

function ZongMenDaoShiController:isZongMenDaoShiComplete()
local num=ZongMenDaoShiModel:getZMDaoShiNum()or 0
local max=cfgHelper.get2(cfg_zmdsbaseconfig_get,1,'max')
return num>=max
end

function ZongMenDaoShiController:showZongMenDaoShiWin()
if ZongMenDaoShiController:isOpenZongMenDaoShi()then
local func=function()
UIManager:showWindow("UIZongMenDaoShiWin")
end
loadingControl.openCloud(func,0.5)
end
end

function ZongMenDaoShiController:getZongMenDaoShiProgress()
local num=ZongMenDaoShiModel:getZMDaoShiNum()
local max=cfgHelper.get2(cfg_zmdsbaseconfig_get,1,'max')
return num,max
end

function ZongMenDaoShiController:getZongMenDaoShiReddot()
local list=ZongMenDaoShiModel:getZMDataList()
local swlv=cfgHelper.get2(cfg_zmdsbaseconfig_get,1,'swlv')
for i,v in ipairs(list)do
local serial=v
local data=systemZongMenModel:getInfoData(serial)
if data then
local isSub=data.flag==systemZongMenFightFlagType.eVassal
if isSub then
return true
end
local reputationValue=data.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(data.id,reputationValue)
local reputationCond=reputationIndex>=swlv
if reputationCond then
return true
end
end
end
return false
end

function ZongMenDaoShiController:getZongMenDaoShiReddotBySerial(serial)
local swlv=cfgHelper.get2(cfg_zmdsbaseconfig_get,1,'swlv')
local data=systemZongMenModel:getInfoData(serial)
if data then
local isSub=data.flag==systemZongMenFightFlagType.eVassal
if isSub then
return true
end
local reputationValue=data.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(data.id,reputationValue)
local reputationCond=reputationIndex>=swlv
if reputationCond then
return true
end
end
return false
end