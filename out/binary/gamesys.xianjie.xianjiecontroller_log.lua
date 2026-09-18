

local isfirstinitrz=false
local jbzbtemp=false
function xianjieController:onAppStart_log()
socketManager:register_receiver(35,37,self.recv_35_37)
socketManager:register_receiver(35,38,self.recv_35_38)
socketManager:register_receiver(35,39,self.recv_35_39)
socketManager:register_receiver(35,40,self.recv_35_40)
socketManager:register_receiver(35,6,self.recv_35_6)
socketManager:register_receiver(35,42,self.recv_35_42)

end

function xianjieController:onEnterState_log(isReconnet)
isfirstinitrz=false
jbzbtemp=false
xianjieModel:initData_moulue()

xianjieModel:set_sendtime(timeHelper.getServerShortTime())
end

function xianjieController:onLeaveState_log(isReconnet)
isfirstinitrz=false
jbzbtemp=false
xianjieModel:clearData_moulue()
end

function xianjieController:onProtocolReq_log()
if xianjieModel:jude_isSend()then
self:reqXianJieLog()
xianjieModel:set_sendtime(timeHelper.getServerShortTime())
end
end


function xianjieController:reqXianJieLog()
socketManager:send(35,37)
end

function xianjieController:reqXianJieLogReward(len,tb)
if bagControl.checkShowFullEquipBagTips("无法领取奖励")then
return
end

socketManager:send(35,38,len,tb)
end

function xianjieController:reqXianJieLogDelete(len,tb)
socketManager:send(35,39,len,tb)
end

function xianjieController:reqXianJieJiJieFightLog(guid)
socketManager:send(35,40,guid)
end

function xianjieController:send_35_42(guid)
socketManager:send(35,42,guid)
end


function xianjieController.recv_35_37(loglen,log_tb)
xianjieModel:SetXianJieLog(loglen,log_tb)
xianjieModel:clearJiJie_Data()




local win=UIManager:findActiveWindow("UIXianJie_noteMonsterWin")
if win then
xianjieModel:saveRecord_Monster()
win:RefreshWin()
end
local win2=UIManager:findActiveWindow("UIXianJie_noteResourceWin")
if win2 then
xianjieModel:saveRecord_Resource()
win2:RefreshWin()
end
local win_arena=UIManager:findActiveWindow("UIXianJie_noteArenaWin")
if win_arena then
xianjieModel:saveRecord_Arena()
win_arena:RefreshWin()
end
local win_mxslSingle=UIManager:findActiveWindow("UIXianJie_noteMXSLSingleWin")
if win_mxslSingle then
xianjieModel:saveRecord_MXSLSingle()
win_mxslSingle:RefreshWin()
end
local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end










UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianJieRiZhi')
end

function xianjieController.recv_35_38(loglen,log_tb)
xianjieModel:Set_yetrecv(loglen,log_tb)
xianjieModel:jude_haveReward()
reddotControl.on_change_catch_type(CATCH_TYPE.eXianJieLog)
local win=UIManager:findActiveWindow("UIXianJie_noteMonsterWin")
if win then
win:RefreshWin()
end
local win2=UIManager:findActiveWindow("UIXianJie_noteResourceWin")
if win2 then
win2:RefreshWin()
end
local win4=UIManager:findActiveWindow("UIXianJie_noteArenaWin")
if win4 then
win4:RefreshWin()
end
local win6=UIManager:findActiveWindow("UIXianJie_noteMXSLSingleWin")
if win6 then
win6:RefreshWin()
end
local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end

UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianJieRiZhi')
end

function xianjieController.recv_35_39(loglen,log_tb)
xianjieModel:Delete_log(loglen,log_tb)
local win=UIManager:findActiveWindow("UIXianJie_noteMonsterWin")
if win then
win:RefreshWin()
end
local win2=UIManager:findActiveWindow("UIXianJie_noteResourceWin")
if win2 then
win2:RefreshWin()
end
local win4=UIManager:findActiveWindow("UIXianJie_noteArenaWin")
if win4 then
win4:RefreshWin()
end
local win6=UIManager:findActiveWindow("UIXianJie_noteMXSLSingleWin")
if win6 then
win6:RefreshWin()
end
end

function xianjieController.recv_35_40(guid,len,log_tb)
xianjieModel:SetJiJie_Data(guid,len,log_tb)
if len>0 then
UIManager:showWindow("UIXianJie_noteJiJie",{guid})
else
UIManager.error("战报已过期，查看失败")
end
end


function xianjieController.recv_35_42(guid,assistlistlen,assistlist)
if assistlistlen>0 then
for _,v in ipairs(assistlist)do
if v.disciplelistlen>0 then
for _,vv in ipairs(v.guidlist)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
xianjieModel:SetTQyuanjun_Data(guid,assistlistlen,assistlist)

UIManager:invokeUIMethod('UIXianJie_zmSearchLogTipsWin','TeQuanYJPanelfresh')
end
end



function xianjieController.recv_35_6(record)
if record.logtype==104 then
local logtb=jsonHelper.decode(record.params)
if logtb and logtb[2]~=nil then
local guildidStr=logtb[2]
xianjieModel:Set_searchLogLookup2(guildidStr,record)
end
end

xianjieModel:Set_timedata(timeHelper.getServerShortTime())

if xianjieModel:jude_xianjielog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end
local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end

UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianJieRiZhi')
end

function xianjieController:OpenZhengZhanShanHaiFightLog(record)














end


function xianjieController:initxjrzdata()
if not isfirstinitrz then
xianjieController:reqXianJieLog()
isfirstinitrz=true
end
end

function xianjieController:OpenZhengZhanShanHaiMonsterLog(is_jijie)
self:onProtocolReq_log()

if not next(xianjieModel:Get_monstertb())and next(xianjieModel:Get_resourcetb())then
xianjieController:OpenXianjieResourceLog()
elseif next(xianjieModel:Get_monstertb())and next(xianjieModel:Get_resourcetb())and not xianjieModel:get_monsterReddot()then
xianjieController:OpenXianjieResourceLog()
else
oneTabScreenController:openUI(SEC_FULL_TYPE.eXianJieLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eXianJieMonsterLog,{is_jijie})
end
end
function xianjieController:OpenXianjieResourceLog(onlyTab)
self:onProtocolReq_log()
oneTabScreenController:openUI(SEC_FULL_TYPE.eXianJieLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eXianJieResourceLog,{},onlyTab)
end
function xianjieController:OpenXianjieMonsterLog(is_jijie,weakGuid)
self:onProtocolReq_log()
oneTabScreenController:openUI(SEC_FULL_TYPE.eXianJieLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eXianJieMonsterLog,{is_jijie,weakGuid})
end
function xianjieController:OpenXianjieArenaLog(is_jijie,weakGuid)
self:onProtocolReq_log()
oneTabScreenController:openUI(SEC_FULL_TYPE.eXianJieLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eXianJieFightLog,{is_jijie,weakGuid})
end

function xianjieController:OpenXianjieMXSLSingleLog(is_jijie,weakGuid)
self:onProtocolReq_log()
oneTabScreenController:openUI(SEC_FULL_TYPE.eXianJieMXSLLog,{})
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eXianJieMXSLSingleLog,{is_jijie,weakGuid})
end


function xianjieController:setjbTozb(temp)
jbzbtemp=temp
end
function xianjieController:getjbTozb()
return jbzbtemp
end


function xianjieController:xjrzgetCfg_hj(entitytype,infoid)
local name=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entitytype,'configname')
local func=cfgHelper.getCofingGetFunction(name)
local cfg=cfgHelper.get1(func,infoid)
return cfg
end

function xianjieController:xjrzgetgwName_hj(cfg,hideStage)
local nameStr=""
local groupid=cfg.monster[1]
if groupid then
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local stage=cfg.stage or 1
nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶{1}",stage,groupcfg.name)
end
return nameStr
end

function xianjieController:xjrzgetCfg_zyd(entitytype,infoid)
return xianjieModel:getXJResPointClassifyCfg(entitytype,infoid)
end

function xianjieController:xjrzgetgwName_zyd(cfg,srctype)
local nameStr=""
local groupid=cfg.monster_id
if groupid then
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local stage=cfg.stage or 1
nameStr=FMT.fmt("{0}",groupcfg.name)

if srctype and srctype~=0 then
if srctype==xjResPointSourceType.eExploration or srctype==xjResPointSourceType.eXianBangTask then
nameStr=FMT.fmt("{0}阶{1}",stage,groupcfg.name)
end
end
end
return nameStr
end


function xianjieController:refreshUIReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eXianJieLog)
local win3=UIManager:findActiveWindow("UIXianJieFuncStorageWin")
if win3 then
win3:refreshFuncBtn_Log()
end

UIManager:invokeUIMethod('UIFuncStorageWin','refreshXianJieRiZhi')
end

function xianjieController:onNormalUpdate_log()
xianjieModel:checkCDLogAutoDelete()
end