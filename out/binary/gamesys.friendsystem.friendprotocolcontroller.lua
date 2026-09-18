







local _MODULENAME="friendProtocolController"
gameState.addListener(def_table(_MODULENAME))
friendProtocolController.name=_MODULENAME



function friendProtocolController:onAppStart()
socketManager:register_receiver(10,1,friendProtocolController.recv_10_1)
socketManager:register_receiver(10,2,friendProtocolController.recv_10_2)
socketManager:register_receiver(10,3,friendProtocolController.recv_10_3)
socketManager:register_receiver(10,4,friendProtocolController.recv_10_4)
socketManager:register_receiver(10,5,friendProtocolController.recv_10_5)
socketManager:register_receiver(10,6,friendProtocolController.recv_10_6)
socketManager:register_receiver(10,7,friendProtocolController.recv_10_7)
socketManager:register_receiver(10,8,friendProtocolController.recv_10_8)
socketManager:register_receiver(10,9,friendProtocolController.recv_10_9)
socketManager:register_receiver(10,10,friendProtocolController.recv_10_10)
socketManager:register_receiver(10,11,friendProtocolController.recv_10_11)
socketManager:register_receiver(10,14,friendProtocolController.recv_10_14)
socketManager:register_receiver(10,15,friendProtocolController.recv_10_15)
socketManager:register_receiver(10,16,friendProtocolController.recv_10_16)


end

function friendProtocolController:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)







end

function friendProtocolController:onProtocolReq()

end

function friendProtocolController:onLeaveState()

end













function friendProtocolController.req_friend_list(friendType,pageNum)

end






function friendProtocolController.req_find_friend(playerName)
if playerName==nil then
if friendModel:isLocalMax()and friendModel:isCrossMax()then
return
end
end
friendProtocolController.sendFindName=playerName
socketManager:send_10_2(playerName or"")
end


function friendProtocolController.req_add_friend(friendType,playerIdList)
if friendType==eFriendListType.eLocal then
if friendModel:isLocalMax()then
UIManager.error('仙友数量已满，暂无法添加')
return
end
elseif friendType==eFriendListType.eCross then
if friendModel:isCrossMax()then
UIManager.error('仙友数量已满，暂无法添加')
return
end
end

socketManager:send_10_3(friendType,#playerIdList,playerIdList)
end


function friendProtocolController.req_apply_list()

end







function friendProtocolController.req_apply_confirm(opType,playerId)
socketManager:send_10_5(opType,playerId or int64.new('0'))
end







function friendProtocolController.req_point_oper(opType,playerId)
socketManager:send_10_6(opType,playerId or int64.new('0'))
end






function friendProtocolController.req_black_list(opType,playerId)
local content=""
if opType==eFriendBlackOper.eRemove then
content='是否将该玩家从黑名单移除？'
else

if friendModel:isBlackMax()then
UIManager.error('黑名单数量已满')
return
end

content='是否将该仙友移至黑名单？'
end
local showdata=
{
type='UIDialougeHighest',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
socketManager:send_10_7(opType,playerId)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function friendProtocolController.req_remove_friend(playerIdList,contentStr)
local len=#playerIdList
local content=contentStr or'是否删除仙友？'
local showdata=
{
type='UIDialougeHighest',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
socketManager:send_10_8(len,playerIdList)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function friendProtocolController.req_prized_point()
socketManager:send_10_9()
end



function friendProtocolController.req_black_kuafu_list(serverId,playerId,iconInfo,name,zmLevel,zmName)
if friendModel:isBlackMax()then
UIManager.error('黑名单数量已满')
return
end
local content='是否将该仙友移至黑名单？'
local showdata=
{
type='UIDialougeHighest',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
socketManager:send_10_16(serverId,playerId,{iconInfo.actoricon,iconInfo.pilistlen,iconInfo.piList,iconInfo.blueinfo or 0},name,zmLevel,zmName)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function friendProtocolController.recv_10_15(friendLen,friendArray,applyLen,applyArray)
friendModel:clearList()
if friendLen>0 then
for i=1,friendLen do
local info=friendArray[i]
local friendType=info.friendType
local friendListLen=info.friendListLen
local friendList=info.friendList
if friendListLen>0 then
friendModel:setList(eFriendListData[friendType],friendList)
if friendType==eFriendListType.eLocal or friendType==eFriendListType.eCross then
for i,v in ipairs(friendList)do
friendModel:removeFromList(eFriendDataType.eRequire,v.actorId)
end
end
end
end
end
UIManager:invokeUIMethod("UIFriendListWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eFriendPoint)

if applyLen>0 then

friendProtocolController.recv_10_4(applyLen,applyArray)
end
end










function friendProtocolController.recv_10_1(argstable)





























end


function friendProtocolController.recv_10_2(friendListLen,friendList)
if friendListLen==0 and friendProtocolController.sendFindName then
UIManager.error("未搜索到该仙友")
end


friendModel:setList(eFriendDataType.eAddable,friendList)

UIManager:invokeUIMethod("UIFriendAddWin","onShow")

friendProtocolController.sendFindName=nil
end


function friendProtocolController.recv_10_3(friendType,playerIdListLen,playerIdList,msg)






if playerIdListLen>0 then
if playerIdListLen>0 then
for i,v in ipairs(playerIdList)do
friendModel:addToListEx(eFriendDataType.eRequire,{actorId=v})
end
end
local checkNew=false
for i,v in ipairs(playerIdList)do
local data=friendModel:getFromList(eFriendDataType.eAddable,v)
if data then
if data.sqFlag~=1 and not checkNew then
checkNew=true
end
data.sqFlag=1
end
end
end


if msg==1 then
UIManager.info("已发送仙友申请")
elseif msg==2 then
UIManager.info("对方仙友已达上限")
end

UIManager:invokeUIMethod("UIFriendAddWin","onShow")
end


function friendProtocolController.recv_10_4(friendListLen,friendList)

friendModel:setList(eFriendDataType.eApply,friendList)


UIManager:invokeUIMethod("UIFriendApplyWin","onShow")



reddotControl.on_friend_changed()
end







function friendProtocolController.recv_10_5(result,opType,playerId)
if result==1 then
UIManager.error("发送申请成功")
return
end

if opType==eFriendApplyConfirm.eAgreeAll or opType==eFriendApplyConfirm.eRefuseAll then
friendModel:clearListByType(eFriendDataType.eApply)
friendModel:clearListByType(eFriendDataType.eAddable)
else
friendModel:removeFromList(eFriendDataType.eApply,playerId)
friendModel:removeFromList(eFriendDataType.eAddable,playerId)
end

UIManager:invokeUIMethod("UIFriendAddWin","onShow")
UIManager:invokeUIMethod("UIFriendApplyWin","onShow")


reddotControl.on_friend_changed()
end







function friendProtocolController.recv_10_6(result,opType,playerId)
if result==1 then
if opType==3 and playerId then
local data=friendModel:getFromList(eFriendDataType.eLocal,playerId)
if data then
if data.offline~=0 then
UIManager.error('对方不在线')
end
else
data=friendModel:getFromList(eFriendDataType.eCross,playerId)
if data then
if data.offline~=0 then
UIManager.error('对方不在线')
end
else
UIManager.error('赠送失败')
end
end
else
UIManager.error('赠送失败')
end

return
end

if opType==eFriendPointOper.eGiveAll or opType==eFriendPointOper.eGiveOne then
UIManager.info('赠送成功')
end


reddotControl.on_change_catch_type(CATCH_TYPE.eFriendPoint)


end








function friendProtocolController.recv_10_7(opType,playerId)
if playerId==0 then
return
end

if opType==eFriendBlackOper.eAdd then
UIManager.info("已加入黑名单")












friendProtocolController.req_friend_list(eFriendListType.eBlack,1)
friendProtocolController.req_apply_list()

elseif opType==eFriendBlackOper.eRemove then
UIManager.info("已移除黑名单")


friendModel:removeFromList(eFriendDataType.eBlack,playerId)

end


UIManager:invokeUIMethod('UIFriendListWin','onShow')
UIManager:invokeUIMethod('UIMain','releaseMainMesgPanel')
UIManager:invokeUIMethod('UIChatWin','freshMesgPanel')
UIManager:invokeUIMethod('UIOthePlayerInfoWin','rebuildBtns')
end






function friendProtocolController.recv_10_8(len,playerIdList)
if len==0 then
return
end


UIManager.info("已删除仙友")

friendModel:removeListFromList(eFriendDataType.eLocal,playerIdList)
friendModel:removeListFromList(eFriendDataType.eCross,playerIdList)

UIManager:invokeUIMethod("UIFriendListWin","onShow")
end


function friendProtocolController.recv_10_9(friendshipGetNum,friendshipGiveNum)
friendModel:setFriendPoint(friendshipGetNum)
friendModel:setGivePoint(friendshipGiveNum)

UIManager:invokeUIMethod("UIFriendListWin","onShow")
end

function friendProtocolController.onNewDay5am()
friendProtocolController.recv_10_9(0,0)
end


function friendProtocolController.recv_10_10(friendType,friendListLen,friendList)
for i,v in pairs(friendList)do
if friendType==eFriendListType.eLocal then
friendModel:addToList(eFriendDataType.eLocal,v)
elseif friendType==eFriendListType.eCross then
friendModel:addToList(eFriendDataType.eCross,v)
elseif friendType==eFriendListType.eBlack then
friendModel:addToList(eFriendDataType.eBlack,v)
end
end

UIManager:invokeUIMethod("UIFriendListWin","onShow")
end






function friendProtocolController.recv_10_11(playerId,onlineStatus)
local offline
if onlineStatus==eFriendOnlineStatus.eOn then
offline=0
elseif onlineStatus==eFriendOnlineStatus.eOff then
offline=gameUtilityModel.getServerShortTime()-1
else
return
end
friendModel:setOffline(playerId,offline)

UIManager:invokeUIMethod("UIFriendListWin","onShow")
end

function friendProtocolController.recv_10_14(dataListLen,dataList)
if dataListLen>0 then
for i,v in ipairs(dataList)do
local data=friendModel:getFromList(eFriendDataType.eLocal,v.param_1)
data.pointButton=v.param_2
end
UIManager:invokeUIMethod("UIFriendListWin","onShow")

reddotControl.on_change_catch_type(CATCH_TYPE.eFriendPoint)
end
end






function friendProtocolController.recv_10_16(result)
if result==1 then
return
end

UIManager.info("已加入黑名单")
friendProtocolController.req_friend_list(eFriendListType.eBlack,1)
friendProtocolController.req_apply_list()

UIManager:invokeUIMethod('UIFriendListWin','onShow')
UIManager:invokeUIMethod('UIMain','releaseMainMesgPanel')
UIManager:invokeUIMethod('UIChatWin','freshMesgPanel')
UIManager:invokeUIMethod('UIOthePlayerInfoWin','rebuildBtns')
end

