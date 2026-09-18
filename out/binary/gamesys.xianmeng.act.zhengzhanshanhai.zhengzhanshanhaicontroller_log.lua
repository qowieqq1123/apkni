


function zhengzhanshanhaiController:onAppStart_log()
socketManager:register_receiver(20,225,self.recv_20_225)
socketManager:register_receiver(20,226,self.recv_20_226)
socketManager:register_receiver(20,239,self.recv_20_239)
socketManager:register_receiver(20,240,self.recv_20_240)
socketManager:register_receiver(20,241,self.recv_20_241)
socketManager:register_receiver(20,245,self.recv_20_245)


socketManager:register_receiver(44,225,self.recv_44_225)
socketManager:register_receiver(44,226,self.recv_44_226)
socketManager:register_receiver(44,239,self.recv_44_239)
socketManager:register_receiver(44,240,self.recv_44_240)
socketManager:register_receiver(44,241,self.recv_44_241)
socketManager:register_receiver(44,245,self.recv_44_245)
end

function zhengzhanshanhaiController:onEnterState_log(isReconnet)
zhengzhanshanhaiModel:initData_moulue()
end

function zhengzhanshanhaiController:onLeaveState_log(isReconnet)
zhengzhanshanhaiModel:clearData_moulue()
end

function zhengzhanshanhaiController:onProtocolReq_log()
local ret=false
if zhengzhanshanhaiModel:jude_isSend()then
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_225()
else
socketManager:send_20_225()
end
zhengzhanshanhaiModel:set_sendtime(timeHelper.getServerShortTime())
ret=true
end

return ret
end


function zhengzhanshanhaiController:Send_reward_req(len,tb,prizeType)
if bagControl.checkShowFullEquipBagTips("无法领取奖励")then
return
end

prizeType=prizeType or ePrizeType.eCommon
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_226(len,tb,prizeType)
else
socketManager:send_20_226(len,tb,prizeType)
end
end


function zhengzhanshanhaiController:Send_Clear_req(len,tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_239(len,tb)
else
socketManager:send_20_239(len,tb)
end
end

function zhengzhanshanhaiController:Send_JiJie_Req(guid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_240(guid)
else
socketManager:send_20_240(guid)
end
end


function zhengzhanshanhaiController:Send_logZhanKuang_zhanBao_req(guid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_245(guid)
else
socketManager:send_20_245(guid)
end
end



function zhengzhanshanhaiController.recv_20_225(loglen,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getLogInfoList(loglen,log_tb)
end


function zhengzhanshanhaiController.recv_20_226(loglen,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getLogReward(loglen,log_tb)
end


function zhengzhanshanhaiController.recv_20_239(loglen,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_clearLog(loglen,log_tb)
end


function zhengzhanshanhaiController.recv_20_240(guid,len,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getJiJieLog(guid,len,log_tb)
end


function zhengzhanshanhaiController.recv_20_241(recordsec)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_updateLog(recordsec)
end


function zhengzhanshanhaiController.recv_20_245(args)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getLogZhanKuang_zhanBao(args)
end



function zhengzhanshanhaiController.recv_44_225(loglen,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getLogInfoList(loglen,log_tb)
end


function zhengzhanshanhaiController.recv_44_226(loglen,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getLogReward(loglen,log_tb)
end


function zhengzhanshanhaiController.recv_44_239(loglen,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_clearLog(loglen,log_tb)
end


function zhengzhanshanhaiController.recv_44_240(guid,len,log_tb)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getJiJieLog(guid,len,log_tb)
end


function zhengzhanshanhaiController.recv_44_241(recordsec)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_updateLog(recordsec)
end


function zhengzhanshanhaiController.recv_44_245(args)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getLogZhanKuang_zhanBao(args)
end




function zhengzhanshanhaiController.recv_getLogInfoList(loglen,log_tb)
zhengzhanshanhaiModel:SetShanHaiLog(loglen,log_tb)
local win1=UIManager:findActiveWindow("UIXM_ZZSH_noteFightWin")
if win1 then
win1:RefreshWin()
end
local win=UIManager:findActiveWindow("UIXM_ZZSH_noteMonsterWin")
if win then

zhengzhanshanhaiModel:saveRecord_Monster()
win:RefreshWin()
end
local win2=UIManager:findActiveWindow("UIXM_ZZSH_noteResourceWin")
if win2 then

zhengzhanshanhaiModel:saveRecord_Resource()
win2:RefreshWin()
end

UIManager:callWindowFunc('UILingShanNoteWin','RefreshWin')

if zhengzhanshanhaiModel:Get_tipsflag()then
zhengzhanshanhaiModel:Set_tipsflag(false)
if not newbieControl.isInNewbie()then
local logtipstable=zhengzhanshanhaiModel:Get_logtips()
if next(logtipstable)then
UIManager:showWindow("UIXM_ZZSH_noteTips")
else

UIManager:invokeUIMethod("UIXM_ZZSH_MapWin","checkSeasonPopup")
end
end
end

end


function zhengzhanshanhaiController.recv_getLogReward(loglen,log_tb)
zhengzhanshanhaiModel:Set_yetrecv(loglen,log_tb)

zhengzhanshanhaiModel:jude_haveReward()
reddotControl.on_change_catch_type(CATCH_TYPE.eZZSHLog)
local win=UIManager:findActiveWindow("UIXM_ZZSH_noteMonsterWin")
if win then
win:RefreshWin()
end
local win2=UIManager:findActiveWindow("UIXM_ZZSH_noteResourceWin")
if win2 then
win2:RefreshWin()
end

UIManager:callWindowFunc('UILingShanNoteWin','RefreshWin')

UIManager:invokeUIMethod("UIXM_ZZSH_endTipsWin","refresh")
end


function zhengzhanshanhaiController.recv_clearLog(loglen,log_tb)
zhengzhanshanhaiModel:Delete_log(loglen,log_tb)
local win=UIManager:findActiveWindow("UIXM_ZZSH_noteMonsterWin")
if win then
win:RefreshWin()
end
local win2=UIManager:findActiveWindow("UIXM_ZZSH_noteResourceWin")
if win2 then
win2:RefreshWin()
end
UIManager:callWindowFunc('UILingShanNoteWin','RefreshWin')
end



function zhengzhanshanhaiController.recv_getJiJieLog(guid,len,log_tb)
zhengzhanshanhaiModel:SetJiJie_Data(guid,len,log_tb)
if len>0 then
UIManager:showWindow("UIXM_ZZSH_noteJiJie")
else
UIManager.error("战报已过期，查看失败")
end
end


function zhengzhanshanhaiController.recv_updateLog(recordsec)
zhengzhanshanhaiModel:Set_241_timedata(recordsec)

if zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()~=zhengzhanshanhaiModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
zhengzhanshanhaiModel:Set_reddotchangeflag(not zhengzhanshanhaiModel:Get_reddotchangeflag())
end
end


function zhengzhanshanhaiController.recv_getLogZhanKuang_zhanBao(args)
local len=args[13]
if len>0 then
zhengzhanshanhaiModel:Set_recordLogData(args)
UIManager:showWindow("UIXM_ZZSH_noteFightReportWin",args)
else
UIManager.error("战报已过期，查看失败")
end
end

function zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog(record)
zhengzhanshanhaiController:onProtocolReq_log()
if record then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiFightLog,{record=record})
return
end
if zhengzhanshanhaiModel:get_monsterReddot()then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiMonsterLog,{nil})
elseif zhengzhanshanhaiModel:get_ResourceReddot()then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiResourceLog,{})
elseif zhengzhanshanhaiModel:get_LingShanReddot()then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiLingShanLog,{})
else
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPStandby or raceState==eZZSH_State.ePVPFight then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiFightLog,{record=record})
else
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiMonsterLog,{nil})
end
end
end

function zhengzhanshanhaiController:OpenZhengZhanShanHaiMonsterLog(is_jijie)
zhengzhanshanhaiController:onProtocolReq_log()

if not next(zhengzhanshanhaiModel:Get_monstertb())and next(zhengzhanshanhaiModel:Get_resourcetb())then
zhengzhanshanhaiController:OpenZhengZhanShanHaiResourceLog()
elseif next(zhengzhanshanhaiModel:Get_monstertb())and next(zhengzhanshanhaiModel:Get_resourcetb())and not zhengzhanshanhaiModel:get_monsterReddot()then
zhengzhanshanhaiController:OpenZhengZhanShanHaiResourceLog()
else
oneTabScreenController:openUI(SEC_FULL_TYPE.eZhengZhanShanHaiLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiMonsterLog,{is_jijie})
end
end

function zhengzhanshanhaiController:OpenZhengZhanShanHaiResourceLog()
zhengzhanshanhaiController:onProtocolReq_log()
oneTabScreenController:openUI(SEC_FULL_TYPE.eZhengZhanShanHaiLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiResourceLog,{})
end

function zhengzhanshanhaiController:OpenZhengZhanShanHaiLingShanLog()
zhengzhanshanhaiController:onProtocolReq_log()
oneTabScreenController:openUI(SEC_FULL_TYPE.eZhengZhanShanHaiLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eZhengZhanShanHaiLingShanLog,{})
end