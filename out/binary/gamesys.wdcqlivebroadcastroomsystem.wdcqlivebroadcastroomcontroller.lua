






local _MODULENAME="wdcqLiveBroadcastRoomController"

gameState.addListener(def_table(_MODULENAME))
wdcqLiveBroadcastRoomController.name=_MODULENAME
wdcqLiveBroadcastRoomController.data=nil

function wdcqLiveBroadcastRoomController:onAppStart()

wdcqLiveBroadcastRoomModel:onAppStart()

socketManager:register_receiver(38,21,self.recv_38_21)
socketManager:register_receiver(38,22,self.recv_38_22)
socketManager:register_receiver(38,23,self.recv_38_23)
socketManager:register_receiver(38,24,self.recv_38_24)
socketManager:register_receiver(38,25,self.recv_38_25)
socketManager:register_receiver(38,26,self.recv_38_26)
socketManager:register_receiver(38,27,self.recv_38_27)
socketManager:register_receiver(38,28,self.recv_38_28)
socketManager:register_receiver(38,29,self.recv_38_29)
socketManager:register_receiver(38,30,self.recv_38_30)
socketManager:register_receiver(38,31,self.recv_38_31)
socketManager:register_receiver(38,32,self.recv_38_32)
socketManager:register_receiver(38,33,self.recv_38_33)
end


function wdcqLiveBroadcastRoomController:onEnterState(isReconnect)
wdcqLiveBroadcastRoomModel:onEnterState()
end


function wdcqLiveBroadcastRoomController:onProtocolReq()
wdcqLiveBroadcastRoomModel:onProtocolReq()
end


function wdcqLiveBroadcastRoomController:onLeaveState(isReconnect)
wdcqLiveBroadcastRoomModel:onLeaveState(isReconnect)

self.data=nil
end


function wdcqLiveBroadcastRoomController:onLostConnection()

end


function wdcqLiveBroadcastRoomController:onReConnection(isInitPro)

end



function wdcqLiveBroadcastRoomController:send_38_21()
socketManager:send_38_21()
end




function wdcqLiveBroadcastRoomController:send_38_22(buyId,buyNum)
socketManager:send_38_22(buyId,buyNum)
end




function wdcqLiveBroadcastRoomController:send_38_23(buyId,buyNum)
socketManager:send_38_23(buyId,buyNum)
end


function wdcqLiveBroadcastRoomController:send_38_24()
socketManager:send_38_24()
end



function wdcqLiveBroadcastRoomController:send_38_25()
socketManager:send_38_25()
end



function wdcqLiveBroadcastRoomController:send_38_26(group,phase,order)
socketManager:send_38_26(group,phase,order)
end


function wdcqLiveBroadcastRoomController:send_38_27()
socketManager:send_38_27()
end



function wdcqLiveBroadcastRoomController:send_38_30()
socketManager:send_38_30()
end


function wdcqLiveBroadcastRoomController:send_38_32()
socketManager:send_38_32()
end


function wdcqLiveBroadcastRoomController:send_38_33()
socketManager:send_38_33()
end




function wdcqLiveBroadcastRoomController.recv_38_21(roomLen,roomList)

end







function wdcqLiveBroadcastRoomController.recv_38_22(group,phase,order,buyId,buyedNum)
wdcqLiveBroadcastRoomModel:setShopBuyed(phase,buyId,buyedNum)
end







function wdcqLiveBroadcastRoomController.recv_38_23(group,phase,order,buyId,buyNum)
if wdcqLiveBroadcastRoomModel:isSameRoom(group,phase,order)then
local hot=cfgHelper.get2(cfg_wendingcangqiongreduitemconfig_get,buyId,"redu")
local total=hot*buyNum
local old=wdcqLiveBroadcastRoomModel:getGiftBuyed(phase,buyId)
local cur=wdcqLiveBroadcastRoomModel:getRoomHot()
local info={
group=group,
phase=phase,
order=order,
}
wdcqLiveBroadcastRoomModel:setRoomHot(cur+total,info)
wdcqLiveBroadcastRoomModel:addTotalHot(total)
wdcqLiveBroadcastRoomModel:setGiftBuyed(phase,buyId,old+buyNum)

UIManager.info(FMT.fmt("热度增加 {0}",total))

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomTotalHotChange,1)
notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,group,phase,order)
end
end







function wdcqLiveBroadcastRoomController.recv_38_24(args)
local group=args[1]
local phase=args[2]
local order=args[3]
local itemNum=args[4]
local draw=args[5]
local draw2=args[6]

local info={
group=group,
phase=phase,
order=order,
}
wdcqLiveBroadcastRoomModel:setRoomDraw(draw,info,draw2)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomDrawChange,group,phase,order)
end



function wdcqLiveBroadcastRoomController.recv_38_25(args)
local group=args[1]
local phase=args[2]
local order=args[3]
local len=args[4]
local rankList=args[5]
local ownHot=args[6]

if wdcqLiveBroadcastRoomModel:isSameRoom(group,phase,order)then
wdcqLiveBroadcastRoomModel:setHotRank(rankList)
wdcqLiveBroadcastRoomModel:setOwnHot(ownHot)
end
end



function wdcqLiveBroadcastRoomController.recv_38_26(args)











wdcqLiveBroadcastRoomModel:setRoomData(args)
wdcqLiveBroadcastRoomModel:setTotalHot(args[8],args[9])
wdcqLiveBroadcastRoomModel:setPoolNum(args[4])

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomPoolNumChange)
notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomTotalHotChange,3)
end





function wdcqLiveBroadcastRoomController.recv_38_27(group,phase,order)
local info={
group=group,
phase=phase,
order=order,
}
if wdcqLiveBroadcastRoomModel:clearRoomData(info)then
wdcqLiveBroadcastRoomModel:clearHotRank()
wdcqLiveBroadcastRoomModel:clearOwnHot()
wdcqLiveBroadcastRoomModel:clearGiftInfo()
end
end







function wdcqLiveBroadcastRoomController.recv_38_28(group,phase,order,hot,draw)
local info={
group=group,
phase=phase,
order=order,
}
wdcqLiveBroadcastRoomModel:setRoomDraw(draw,info)
wdcqLiveBroadcastRoomModel:setRoomHot(hot,info)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,group,phase,order)
notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomDrawChange,group,phase,order)
end






function wdcqLiveBroadcastRoomController.recv_38_29(group,phase,order,people)
local info={
group=group,
phase=phase,
order=order,
}
wdcqLiveBroadcastRoomModel:setRoomPeople(people,info)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomPeopleChange,group,phase,order)
end



function wdcqLiveBroadcastRoomController.recv_38_30(args)
local group=args[1]
local phase=args[2]
local order=args[3]
local num=args[4]
local draw=args[5]
local hot=args[6]

local info={
group=group,
phase=phase,
order=order,
}
wdcqLiveBroadcastRoomModel:setPoolNum(num)
wdcqLiveBroadcastRoomModel:setRoomDraw(draw,info)
wdcqLiveBroadcastRoomModel:setRoomHot(hot,info)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomPoolNumChange)
notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,group,phase,order)
notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomDrawChange,group,phase,order)
end



function wdcqLiveBroadcastRoomController.recv_38_31(args)
local group=args[1]
local phase=args[2]
local order=args[3]
local giftId=args[4]
local giftNum=args[5]
local actorName=args[6]
local actorIcon=args[7]
local serverId=args[8]
local hot=args[9]
local draw=args[10]

if wdcqLiveBroadcastRoomModel:isSameRoom(group,phase,order)then
local gift={
giftId=giftId,
giftNum=giftNum,
actorName=actorName,
actorIcon=actorIcon,
serverId=serverId,
}
wdcqLiveBroadcastRoomModel:pushGiftInfo(gift)
end
local info={
group=group,
phase=phase,
order=order,
}
wdcqLiveBroadcastRoomModel:setRoomDraw(draw,info)
wdcqLiveBroadcastRoomModel:setRoomHot(hot,info)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,group,phase,order)
notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomDrawChange,group,phase,order)
end



function wdcqLiveBroadcastRoomController.recv_38_32(args)
local group=args[1]
local phase=args[2]
local order=args[3]
local shopLen=args[4]
local shopList=args[5]
local num=args[6]
local giftLen=args[7]
local giftList=args[8]

wdcqLiveBroadcastRoomModel:setShopData(phase,shopList)
wdcqLiveBroadcastRoomModel:setGiftData(phase,giftList)
wdcqLiveBroadcastRoomModel:setPoolNum(num)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomPoolNumChange)
end






function wdcqLiveBroadcastRoomController.recv_38_33(group,phase,order,flag)
wdcqLiveBroadcastRoomModel:setTotalHotFlag(flag)

notifySystem:postNotify(notifyConfig.onWDCQLiveBroadcastRoomTotalHotChange,2)
end























function wdcqLiveBroadcastRoomController:getLiveRoomData(group,phase,order)
local disciple=UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
if self.data==nil then
self.data={
stage=eWDCQLiveRoomMatchStageEnum.eFightFinish,
players={
[0]={
actorId=playerModel:getActorID(),
actorName=playerModel:getActorName(),
iconStruct=playerModel:getActorIconInfo(),
serverId=loginModel.server_id,
victory=2,
banList={
disciple,disciple
},
},
[1]={
actorId=playerModel:getActorID(),
actorName=playerModel:getActorName(),
iconStruct=playerModel:getActorIconInfo(),
serverId=loginModel.server_id,
victory=0,
banList={
disciple,disciple
},
},
}
}
end
return self.data
end

function wdcqLiveBroadcastRoomController:onSeasonBegin()

end

function wdcqLiveBroadcastRoomController:onSeasonEnd()
wdcqLiveBroadcastRoomModel:onLeaveState()
UIManager:invokeUIMethod("UIWDCQLiveBroadcastRoomMainWin","onBackButton")
end

function wdcqLiveBroadcastRoomController:enterLiveRoom(group,phase,order)
if not WDCQController.checkInTheGame2()then



return
end

local cPhase=WDCQController.getServerGroupStage(group)
if cPhase>WDCQCGameStageEnum.eNone and cPhase<phase then
return
end

local room_conf=cfgHelper.get3(cfg_wendingcangqiongmatchconfig_get,group,phase,"room_conf")
if room_conf~=1 then

return
end

local matchInfo=WDCQController.getMacthInfo(group,phase,order)
if matchInfo and mathHelper.validInt64(matchInfo.actor_id_1)and mathHelper.validInt64(matchInfo.actor_id_2)then
if not fullScreenUI.checkFull(UIFullWenDingCangQiongControl)then
UIFullWenDingCangQiongControl:showMainWin({
groupId=group,
stageId=phase,
subGoupId=math.ceil(order/4),
idx=order,
})
end

local args={
parentWin=UIFullWenDingCangQiongControl,
enterFunc=function()
local temp={
group=group,
phase=phase,
order=order,
parentWin=UIFullWenDingCangQiongControl,
}
UIFullWenDingCangQiongControl:showWindow("UIWDCQLiveBroadcastRoomMainWin",temp)

wdcqLiveBroadcastRoomController:send_38_26(group,phase,order)
end,
overTime=5,
overTips="进入房间超时",
overFunc=function()
UIFullWenDingCangQiongControl:closeWindow("UIWDCQLiveBroadcastRoomMainWin")
wdcqLiveBroadcastRoomController:send_38_27()
local channelId=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"chatChannel",group)
chatControl.clearChannelMesg(channelId)
WDCQController:removeBookWinWhenLiveRoomClose(group,phase,order)
end,
checkFunc=function()
return wdcqLiveBroadcastRoomModel:isSameRoom(group,phase,order)
end
}
UIFullWenDingCangQiongControl:showWindow("UIWDCQLiveBroadcastRoomTransitionWin",args)
else

end
end