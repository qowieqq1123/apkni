








function gameUtilityControl:onAppStart_counter()
socketManager:register_receiver(254,53,gameUtilityControl.do_protocol_254_53)
socketManager:register_receiver(254,54,gameUtilityControl.do_protocol_254_54)
end

function gameUtilityControl:onEnterState_counter(isReconnet)
notifySystem:listenNotify(notifyConfig.shilianta_change,self.shilianta_change)
notifySystem:listenNotify(notifyConfig.onGongFaActive,self.onGongFaActive)
notifySystem:listenNotify(notifyConfig.onHouShanShiLianLVChange,self.onHouShanShiLianLVChange)
notifySystem:listenNotify(notifyConfig.oneXunBaoShiLianLVChange,self.oneXunBaoShiLianLVChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewMonth5am,self.onNewMonth5am)
notifySystem:listenNotify(notifyConfig.onDiscipleXianMoCountChange,self.XianMoDz_change)


end

function gameUtilityControl:onLeaveState_counter(isReconnet)
if not isReconnet then
gameUtilityModel.clear_counter()
end
gameUtilityModel.clear_counter_client()
notifySystem:removelistener(notifyConfig.shilianta_change,self.shilianta_change)
notifySystem:removelistener(notifyConfig.onGongFaActive,self.onGongFaActive)
notifySystem:removelistener(notifyConfig.onHouShanShiLianLVChange,self.onHouShanShiLianLVChange)
notifySystem:removelistener(notifyConfig.oneXunBaoShiLianLVChange,self.oneXunBaoShiLianLVChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onDiscipleXianMoCountChange,self.XianMoDz_change)


end


function gameUtilityControl.shilianta_change(oldLayer,curLayer,isChallengeAll)
gameUtilityModel:disposeClientCounterTypeEvent(gameClientCounterChangeType.eSuoYaoTaFloorChange)
end


function gameUtilityControl.onGongFaActive(gfID)
gameUtilityModel:disposeClientCounterTypeEvent(gameClientCounterChangeType.eGongFaActive)
end

function gameUtilityControl.onHouShanShiLianLVChange(lv)
gameUtilityModel:disposeClientCounterTypeEvent(gameClientCounterChangeType.eHouShanShiLianChange)
end

function gameUtilityControl.oneXunBaoShiLianLVChange(lv)
gameUtilityModel:disposeClientCounterTypeEvent(gameClientCounterChangeType.eXunBaoShiLianChange)
end

function gameUtilityControl.onNewDay5am(islogin)
if not islogin then
gameUtilityModel:setData_counter(gameCounterType.eLingXuWenJianShareNum,0)
gameUtilityModel:setData_counter(gameCounterType.eShareDiscipleRoleInfoNum,0)
gameUtilityModel:setData_counter(gameCounterType.eShareLingShouRoleInfoNum,0)
gameUtilityModel:setData_counter(gameCounterType.eZuShiCoupleNum,0)
gameUtilityModel:setData_counter(gameCounterType.eDiscipleCoupleNum,0)
end
if not islogin then
gameUtilityModel:setData_counter(gameCounterType.eShareQieChuoInfoNum,0)
gameUtilityModel:setData_counter(gameCounterType.eXianjiePointShareNum,0)
DiZiDuelModel:resetDueltimesDayFive()
end
end

function gameUtilityControl.onNewMonth5am(islogin)
if not islogin then
gameUtilityModel:setData_counter(gameCounterType.eTianDaoShuResetNum,0)
gameUtilityModel:setData_counter(gameCounterType.eGongFaResetNum,0)
gameUtilityModel:setData_counter(gameCounterType.eGongFaResetNum,0)
gameUtilityModel:setData_counter(gameCounterType.eCuiTiReset,0)
end
end

function gameUtilityControl.onNewDay(islogin)

end







function gameUtilityControl.XianMoDz_change()
gameUtilityModel:disposeClientCounterTypeEvent(gameClientCounterChangeType.eXianMoDzChange)
end




function gameUtilityControl:reqCounterData()

end






function gameUtilityControl.do_protocol_254_53(len,list)





gameUtilityModel.initData_counter(list)
end



function gameUtilityControl.do_protocol_254_54(accutype,cnt)





















gameUtilityModel:setData_counter(accutype,cnt)
end

