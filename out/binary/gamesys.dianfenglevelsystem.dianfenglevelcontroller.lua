






local _MODULENAME="DianFengLevelController"

gameState.addListener(def_table(_MODULENAME))
DianFengLevelController.name=_MODULENAME
DianFengLevelController.data={}

function DianFengLevelController:onAppStart()
DianFengLevelModel:onAppStart()

socketManager:register_receiver(16,41,self.recv_16_41)
socketManager:register_receiver(16,42,self.recv_16_42)
socketManager:register_receiver(16,43,self.recv_16_43)
socketManager:register_receiver(16,44,self.recv_16_44)



notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
end


function DianFengLevelController:onEnterState(isReconnect)
DianFengLevelModel:onEnterState()
end


function DianFengLevelController:onProtocolReq()
DianFengLevelModel:onProtocolReq()
end


function DianFengLevelController:onLeaveState(isReconnect)
DianFengLevelModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)

self.data={}
end


function DianFengLevelController:onLostConnection()

end


function DianFengLevelController:onReConnection(isInitPro)

end



function DianFengLevelController:send_16_41()
socketManager:send_16_41()
end

function DianFengLevelController:send_16_42()
socketManager:send_16_42()
end

function DianFengLevelController:send_16_43(pointid)
socketManager:send_16_43(pointid)
end

function DianFengLevelController:send_16_44()
socketManager:send_16_44()
end


function DianFengLevelController.recv_16_41(args)

end

function DianFengLevelController.recv_16_42(level,exp)











end

function DianFengLevelController.recv_16_43(param_1,param_2)







end

function DianFengLevelController.recv_16_44(resetCount)
DianFengLevelModel:resetPoint(resetCount)
UIManager.info("重置成功")
UIManager:invokeUIMethod("UIDianFengZhiBaoWin","severfreshdh")
UIManager:invokeUIMethod("UIDianFengZhiBaoWin","Resetseverfreshdh")
UIManager:invokeUIMethod("UIZongmenInfoWin","DFSeverFresh")

DianFengLevelModel:freshXBTJWin()
end

function DianFengLevelController.onMoneyChanged(moneyType,oldVal,newVal)
if moneyType==eMoneyType.mtDianFengLevelExp then
DianFengLevelModel:freshlevelexp(newVal)
end
end

function DianFengLevelController.recv_16_45(exp)
DianFengLevelModel:freshlevelexp(exp)
end

function DianFengLevelController.recv_16_46(flag)

end


function DianFengLevelController:showDFWin(args)
if DianFengLevelController.isAlwaysOPenDF()then
UIManager:showWindow('UIDianFengZhiBaoWin',{flag=args.flag})
end
end

function DianFengLevelController.isAlwaysOPenDF()
return systemModel.isOpen(SYSTEM_DEFINE.eiDianFengLevel)
end

function DianFengLevelController.isShowDF(tips)
if systemModel.isOpen(SYSTEM_DEFINE.eiDianFengLevel)then
local isMax=zongmenModel:isMaxLv()
if not isMax and tips then
UIManager.info("宗门未满级")
end
return isMax
else
if tips then
UIManager.info("巅峰等级系统未开启")
end
end
return false
end

function DianFengLevelController:checkDFReddot()
return DianFengLevelController:checkShengJiReddot()or DianFengLevelController:checkDianHuaReddot()
end

function DianFengLevelController:checkShengJiReddot()
if not DianFengLevelController.isShowDF()then
return false
end
local reddot=false
local dflevel=DianFengLevelModel:getLevel()
local nextcfglvl=cfg_dianfenglevelconfig_get(dflevel+1)
if nextcfglvl then
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxexp=cfglvl.exp
local exp=DianFengLevelModel:getExp()
if exp>=maxexp then
reddot=true
else
reddot=false
end
else
reddot=false
end
return reddot
end

function DianFengLevelController:checkDianHuaReddot()
if not DianFengLevelController.isShowDF()then
return false
end
local reddot=false
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxpoint=cfglvl.point
local usepoint=DianFengLevelModel:getaddPointNum()
if usepoint<maxpoint then
reddot=true
end
return reddot
end
