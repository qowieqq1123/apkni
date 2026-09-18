







UISectPalaceController=gameState.addListener({})

function UISectPalaceController:onAppStart()

socketManager:register_receiver(8,2,self.recv_8_2)
socketManager:register_receiver(8,3,self.recv_8_3)
socketManager:register_receiver(8,8,self.recv_8_8)
end

function UISectPalaceController:onEnterState()

notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.onDisciplePosChange)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function UISectPalaceController:onLeaveState()
UISectPalaceModel:clearData()
notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.onDisciplePosChange)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UISectPalaceController:onPlayerCreate(...)

end

function UISectPalaceController:onLostConnection()

end

function UISectPalaceController.onDisciplePosChange(dis_guid,old,pos)
UISectPalaceController:refreshBuildHud()
end

function UISectPalaceController.on_building_event(etype,sfId,ubdId,args)
if etype==buildingEvent.zongmenLevelUp then

UISectPalaceController:refreshBuildHud()
elseif etype==buildingEvent.levelUpComplete
or etype==buildingEvent.levelUpStart then

UISectPalaceController:refreshBuildHud()
end
end

function UISectPalaceController:getBuildData()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eZongMen)
if bdDatas then
return bdDatas[1]
end
return nil
end

function UISectPalaceController:refreshBuildHud()
local bdData=UISectPalaceController:getBuildData()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end




function UISectPalaceController:reqPost(dizi_id,pos)

socketManager:send_8_1(dizi_id,pos)
end


function UISectPalaceController:req_zongMenDaDian_data()
socketManager:send_8_2()
end









function UISectPalaceController.recv_8_2(shan_e_val)
UISectPalaceModel:setShanEValue(shan_e_val)
end

function UISectPalaceController.recv_8_3(shan_e_val)
local old=UISectPalaceModel:getShanEValue()
UISectPalaceModel:setShanEValue(shan_e_val)
notifySystem:postNotify(notifyConfig.onZongMenStandPointChange,old,shan_e_val)
end

function UISectPalaceController.recv_8_8(neednum,realnum,year)



local msg
local msgType
local msgKey
if year>1 then
if neednum==realnum then
msgKey='zongmen_fenglu_chat_3'
else
msgKey='zongmen_fenglu_chat_4'
end
local cur=gameUtilityModel.getGameYearPass()
msg=FMT.fmt(cfgHelper.getlang(msgKey),cur-year+1,cur,neednum)
else
if neednum==realnum then
msgKey='zongmen_fenglu_chat_1'
else
msgKey='zongmen_fenglu_chat_2'

end
msg=FMT.fmt(cfgHelper.getlang(msgKey),gameUtilityModel.getGameYearPass(),neednum)
end
msgType=chatConfig.getLangMsgType(msgKey)

chatControl.reqSystemMesg(msgType,{CHAT_CHANNNEL.eSystem},msg)
end
