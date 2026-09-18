








function FeiShengTaiController:onAppStart_jiuchongtianjie()
socketManager:register_receiver(34,41,self.recv_34_41)
socketManager:register_receiver(34,42,self.recv_34_42)
socketManager:register_receiver(34,43,self.recv_34_43)
socketManager:register_receiver(34,44,self.recv_34_44)
socketManager:register_receiver(34,45,self.recv_34_45)
socketManager:register_receiver(34,46,self.recv_34_46)
socketManager:register_receiver(34,47,self.recv_34_47)

end

function FeiShengTaiController:onEnterState_jiuchongtianjie(isReconnet)
FeiShengTaiModel:initData_jiuchongtianjie()
end

function FeiShengTaiController:onLeaveState_jiuchongtianjie(isReconnet)
FeiShengTaiModel:clearData_jiuchongtianjie()
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
FeiShengTaiController.isEnterHome=false
FeiShengTaiController.back34_41=false
end

function FeiShengTaiController:onProtocolReq_jiuchongtianjie()

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)

FeiShengTaiModel:recordReddotflag()
FeiShengTaiController:SendXMHelp_feisheng()
end

function FeiShengTaiController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
FeiShengTaiController.isEnterHome=true
if FeiShengTaiController.back34_41 then
FeiShengTaiModel:SetFeiShengTaiRepair()
FeiShengTaiModel:refreshFSTHUD()
end
elseif etype==homeEvent.eLeaveHome then

end
end

function FeiShengTaiController.on_building_event(etype,sfId,ubdId)
if etype==buildingEvent.levelUpComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eFeiShengTai2 then
if FeiShengTaiModel:GetFSTreddot()then

notifySystem:postNotify(notifyConfig.onJctjReddotChange,JIUCHONGTIANJIE_SUB_SYS_TYPE.eZhuXianTai)
FeiShengTaiModel:refreshFSTHUD()

taskController.eFeiShengTaiNumChange()
end
end
end
end


function activitiesController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eFeiShengTai then
if FeiShengTaiController.isEnterHome then
FeiShengTaiModel:refreshFSTHUD()
end
end
end



function FeiShengTaiController:SendFeiSheng_JiaSu(item_list_len,itemlist)
if item_list_len>0 then
socketManager:send_34_42(item_list_len,itemlist)
end
end


function FeiShengTaiController:SendXMHelpMe()
socketManager:send_34_43()
end

function FeiShengTaiController:SendHelpXMPeople(id)
socketManager:send_34_44(id)
end

function FeiShengTaiController:Send34_47()
socketManager:send_34_47()

end


function FeiShengTaiController:Send_FeiSheng(diziguid)
socketManager:send_34_45(diziguid)
end


function FeiShengTaiController:SendXMHelp_feisheng()
socketManager:send_34_46()
end





function FeiShengTaiController.recv_34_41(un_build_id,super_actor_cnt,send_help_cnt,yetid)
local un_build_id=un_build_id
local super_actor_cnt=super_actor_cnt


local send_help_cnt=send_help_cnt


local setdata={un_build_id=un_build_id,super_actor_cnt=super_actor_cnt,send_help_cnt=send_help_cnt,yetid=yetid}
FeiShengTaiModel:SetFeiSheng(setdata)


if un_build_id~=0 then

if FeiShengTaiController.isEnterHome then
FeiShengTaiModel:SetFeiShengTaiRepair()
end
end
FeiShengTaiController.back34_41=true
UIManager:invokeUIMethod("UISectionRepair_flyupward","refresh")
notifySystem:postNotify(notifyConfig.onJctjReddotChange,JIUCHONGTIANJIE_SUB_SYS_TYPE.eZhuXianTai)
end





function FeiShengTaiController.recv_34_42(reduce_times)
local data=FeiShengTaiModel:GetFeiSheng()
local un_build_id=data.un_build_id

if un_build_id~=0 then
zongmenModel:setUpgradeSpeedupTime(1,un_build_id,reduce_times)
buildingCDControl:setSpeedUp(un_build_id,speedUpType.eUpgradeBuilding)
local args={ignorePlayAudio=true}
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.speedUpComplete,1,un_build_id,args)
end
UIManager:invokeUIMethod("UIFlyupward_speed","refreshdata",reduce_times)
UIManager:invokeUIMethod("UIFlyupward_speed","showinfotext")
end


function FeiShengTaiController.recv_34_43(arg)
local data=arg
local lvl=data.lvl

FeiShengTaiModel:SetNowLvl(lvl)
UIManager:invokeUIMethod("UISectionRepair_flyupward","refresh")
end


function FeiShengTaiController.recv_34_44(id,list_len,list)

if not list then
list={}
end

if list_len>0 then

end
reddotControl.on_change_catch_type(CATCH_TYPE.eXWLfeisheng)
local bdData=xianmengController:getXianWuLouBuild()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end


function FeiShengTaiController.recv_34_45(diziguid)


UIManager:invokeUIMethod("UIFeiShengTaiWin","refreshWindow")
UIManager:invokeUIMethod("UIFeiShengTaiWin","duJieAnim",diziguid)
end


function FeiShengTaiController.recv_34_46(len,arg,help_rewardlen,rewardlist)

FeiShengTaiModel:SetXianMengHelpData(len,arg,help_rewardlen,rewardlist)
reddotControl.on_change_catch_type(CATCH_TYPE.eXWLfeisheng)

UIManager:invokeUIMethod("UIXMFXZYWin","RefreshFeiShengTaiWin")
local bdData=xianmengController:getXianWuLouBuild()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

UIManager:invokeUIMethod("UIXMFXZYWin","feishengtaiRefresh")
notifySystem:postNotify(notifyConfig.onFeiShengTaiHelpFinish)
end


function FeiShengTaiController.recv_34_47(yetid)
FeiShengTaiModel:Setyetid(yetid)
UIManager:invokeUIMethod("UIXMFXZYWin","RefreshFeiShengTaiWin")
UIManager:invokeUIMethod("UIFeiShengTaiWin","refreshWindow")
UIManager:invokeUIMethod("UISectionRepair_flyupward","refresh")
UIManager:invokeUIMethod("UIFST_repairRewardWin","refreshReward")
notifySystem:postNotify(notifyConfig.onJctjReddotChange,JIUCHONGTIANJIE_SUB_SYS_TYPE.eZhuXianTai)
end

function FeiShengTaiController.openFeiShengTaiRepairWin(args)

local repairData=args[2]
if cantClickAtNotOpenSystem[repairData.id]then
if not systemModel.isOpen(cantClickAtNotOpenSystem[repairData.id])then
return false
else
UIManager:showWindow('UISectionRepair_flyupward',args)
end
else
UIManager:showWindow('UISectionRepair_flyupward',args)
end
end