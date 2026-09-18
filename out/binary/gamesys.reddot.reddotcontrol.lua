




reddotControl=gameState.addListener({})
















function reddotControl:onAppStart()
notifySystem:listenNotify(notifyConfig.on_mail_changed,self.on_mail_changed)

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.shilianta_change,self.shilianta_change)
notifySystem:listenNotify(notifyConfig.onActorHeadChange,self.onActorHeadChange)
notifySystem:listenNotify(notifyConfig.chatBgExperience,self.onChatBgExperience)
notifySystem:listenNotify(notifyConfig.onDiscipleFightChanged,self.onDiscipleFightChanged)
notifySystem:listenNotify(notifyConfig.on_money_init,self.onInitMoney)
notifySystem:listenNotify(notifyConfig.onDiscipleFaBaoChange,self.onDiscipleFaBaoChange)
notifySystem:listenNotify(notifyConfig.onDiscipleGongFaChange,self.onDiscipleGongFaChange)
notifySystem:listenNotify(notifyConfig.onSettingTypeExperience,self.onSettingTypeExperience)
notifySystem:listenNotify(notifyConfig.onXJCaravanEscortSelfShipFinish,self.onXJCaravanEscortSelfShipFinish)
notifySystem:listenNotify(notifyConfig.onXJCaravanEscortCanDispatchTimeEnd,self.onXJCaravanEscortCanDispatchTimeEnd)
notifySystem:listenNotify(notifyConfig.onXJCaravanEscortRobCountChange,self.onXJCaravanEscortRobCountChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
end


function reddotControl:onEnterState(...)
end

function reddotControl:onLeaveState(...)
end


function reddotControl.on_change_catch_type(catchType,...)
reddotClassManager.on_change_catch_type(catchType)

notifySystem:postNotify(notifyConfig.onReddotCatchTypeChange,catchType,...)
end



function reddotControl.on_player_attr_change(player,index,newvalue,oldvalue)



end


function reddotControl.on_money_change(moneytype,oldvalue,newvalue)

reddotControl.on_change_catch_type(CATCH_TYPE.eMoney,moneytype)
end


function reddotControl.on_item_changed(...)
reddotControl.on_change_catch_type(CATCH_TYPE.eItem,...)
end


function reddotControl.on_mail_changed(newvalue,oldvalue)
reddotControl.on_change_catch_type(CATCH_TYPE.eMail)
end

function reddotControl.onBuildEvent(eventType,param1,param2,param3)
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then

reddotControl.on_change_catch_type(CATCH_TYPE.eZongMenLevel,param1,param2,param3)
end
end

function reddotControl.onDiscipleStateChange(guid,stateType,...)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
reddotControl.on_change_catch_type(CATCH_TYPE.eDiziChuiWei,guid,...)
end
end


function reddotControl.on_friend_changed(newvalue,oldvalue)
reddotControl.on_change_catch_type(CATCH_TYPE.eFriend)
end


function reddotControl.on_dailytask_changed(newvalue,oldvalue)
reddotControl.on_change_catch_type(CATCH_TYPE.eDailyTask)
end

function reddotControl.on_fabao_create_changed(ubdId)
reddotControl.on_change_catch_type(CATCH_TYPE.eFaBaoCreate)
end

function reddotControl.on_zhenfa_studying_changed(zfId,ubdId,zfState)
reddotControl.on_change_catch_type(CATCH_TYPE.eZhenFa)
end


function reddotControl.on_xianmeng_application_changed()
reddotControl.on_change_catch_type(CATCH_TYPE.eXMApplication)
end


function reddotControl.on_xianmeng_collectrepair_changed()
reddotControl.on_change_catch_type(CATCH_TYPE.eXMRepairCollect)
end


function reddotControl.on_zongmen_mountain_changed()
reddotControl.on_change_catch_type(CATCH_TYPE.eMountainSwitch)
end



function reddotControl.onNewDay()
reddotControl.on_change_catch_type(CATCH_TYPE.eNewDay)
end


function reddotControl.shilianta_change(oldLayer,curLayer,isChallengeAll)
reddotControl.on_change_catch_type(CATCH_TYPE.eShiLianTaLayerChange)
end


function reddotControl.onActorHeadChange()
reddotControl.on_change_catch_type(CATCH_TYPE.eActorHeadChange)
end


function reddotControl.onChatBgExperience()
reddotControl.on_change_catch_type(CATCH_TYPE.eChatBgExperience)
end


function reddotControl.onBuildActive()
reddotControl.on_change_catch_type(CATCH_TYPE.eBuildActive)
end


function reddotControl.onRoadActive()
reddotControl.on_change_catch_type(CATCH_TYPE.eRoadActive)
end

function reddotControl.onDiscipleQiZhenChange(discipleguid,isclear)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleQiZhen,discipleguid)
end

function reddotControl.onDiscipleCuiTiChange(discipleguid,isclear)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleCuiTi,discipleguid)
end


function reddotControl.onBuildSuitActive(suit)
reddotControl.on_change_catch_type(CATCH_TYPE.eBuildSuitActive,suit)
end


function reddotControl.onBuildSuitReward(suit)
reddotControl.on_change_catch_type(CATCH_TYPE.eBuildSuitReward,suit)
end


function reddotControl.onFabaoLxExpChange()
reddotControl.on_change_catch_type(CATCH_TYPE.eFaBaoLxExp)
end


function reddotControl.onCangBaoTuShareChange(actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eCangBaoTuShareRecord,actId,subType,subId)
end


function reddotControl.onDaoBingCombine()
reddotControl.on_change_catch_type(CATCH_TYPE.eDaoBingCombine)
end


function reddotControl.onDiscipleFightChanged(diziguid,oldVal,newVal,optype)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleFightChanged,diziguid,oldVal,newVal,optype)
end


function reddotControl.onInitMoney()
reddotControl.on_change_catch_type(CATCH_TYPE.eMoneyInit)
end


function reddotControl.onDiscipleFaBaoChange(dis_guid,changeType)
if changeType==3 or changeType==4 then

reddotControl.on_change_catch_type(CATCH_TYPE.eFaBaoLvChange)
end
end


function reddotControl.onBenMingFabaoReddotChange(itemguid)
reddotControl.on_change_catch_type(CATCH_TYPE.eBenMingFaBaoReddotChange,itemguid)
end


function reddotControl.onDiscipleGongFaChange(dis_guid,pos,gfID)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleGongFaChange,dis_guid,pos,gfID)
end


function reddotControl.onGiftChange()
reddotControl.on_change_catch_type(CATCH_TYPE.efreshGift)
end


function reddotControl.on_task_changed(newvalue,oldvalue)
reddotControl.on_change_catch_type(CATCH_TYPE.eTaskreddot)
end


function reddotControl.onSettingTypeExperience()
reddotControl.on_change_catch_type(CATCH_TYPE.eSetingTypeChange)
end


function reddotControl.onXJCaravanEscortSelfShipFinish(posIdx,shipGuid)
reddotControl.on_change_catch_type(CATCH_TYPE.eXJCaravanEscortChange)
end


function reddotControl.onXJCaravanEscortCanDispatchTimeEnd()
reddotControl.on_change_catch_type(CATCH_TYPE.eXJCaravanEscortChange)
end


function reddotControl.onXJCaravanEscortRobCountChange()
reddotControl.on_change_catch_type(CATCH_TYPE.eXJCaravanEscortChange)
end


function reddotControl.onDiscipleLingShouChange()
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleLingShouChange)
end

