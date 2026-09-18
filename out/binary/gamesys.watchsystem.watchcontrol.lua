





watchControl=gameState.addListener({})



function watchControl:onAppStart()
socketManager:register_receiver(1,13,self.onWatchItemInfo)
end

function watchControl:onEnterState()
watchModel.init()
end

function watchControl:onLeaveState()
watchModel.init()
end


function watchControl.onWatchItemInfo(ret,item)
if ret==0 then
if item then
watchModel.setItem(item)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemid=item.itemid,itemguid=item.itemguid})
else
loggerUtil.logErrFMT('下发了成功，但没有数据下发')
end
elseif ret==1 then
UIManager.info('玩家已下线')
elseif ret==2 then
UIManager.info('该物品已销毁')
end
end

function watchControl.sendWatchItem(actorid,itemguid,discipleguid,serverid)
if serverid and not playerModel:checkServerId(serverid)then
socketManager:send_1_24(serverid,actorid,itemguid,discipleguid)
else
socketManager:send_1_13(actorid,itemguid,discipleguid)
end
end