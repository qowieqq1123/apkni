function xianmengController:onAppStart_fenxiangziyuan()
socketManager:register_receiver(20,41,xianmengController.do_protocol_20_41)
socketManager:register_receiver(20,42,xianmengController.do_protocol_20_42)
socketManager:register_receiver(20,43,xianmengController.do_protocol_20_43)
socketManager:register_receiver(20,44,xianmengController.do_protocol_20_44)
socketManager:register_receiver(20,45,xianmengController.do_protocol_20_45)
socketManager:register_receiver(20,46,xianmengController.do_protocol_20_46)
socketManager:register_receiver(20,47,xianmengController.do_protocol_20_47)
end

function xianmengController:onEnterState_fenxiangziyuan()
xianmengModel:initData_fenxiangziyuan()
end

function xianmengController:onLeaveState_fenxiangziyuan()
xianmengModel:clearData_fenxiangziyuan()
end


function xianmengController:req_protocol_20_41()
socketManager:send_20_41()
end


function xianmengController:req_protocol_20_42(guid)
socketManager:send_20_42(guid)
end


function xianmengController:req_protocol_20_43(guid)
socketManager:send_20_43(guid)
end


function xianmengController:req_protocol_20_44(guid)
socketManager:send_20_44(guid)
end


function xianmengController:req_protocol_20_46()
socketManager:send_20_46()
end


function xianmengController:req_protocol_20_47()
socketManager:send_20_47()
end



function xianmengController.do_protocol_20_41(len1,list1,len2,list2)
xianmengModel:setData_fenxiangziyuan(list1,list2)

notifySystem:postNotify(notifyConfig.onXMFXZYInit)
end


function xianmengController.do_protocol_20_42(data)
if not xianmengModel:checkData_fenxiangziyuan()then return end

local temp=xianmengModel:addData_fenxiangziyuan(data)

notifySystem:postNotify(notifyConfig.onXMFXZYAdd,temp)
notifySystem:postNotify(notifyConfig.onXMFXZYSeek)
reddotControl.on_change_catch_type(CATCH_TYPE.eXMFXZYSeek)

UIManager.info("发布成功")
end


function xianmengController.do_protocol_20_43(guid,errorCode)
if not xianmengModel:checkData_fenxiangziyuan()then return end
if errorCode==0 then
local key=tostring(guid)
local isOwner=xianmengModel:isOwnerData_fenxiangziyuan(key)
local data=xianmengModel:getData_fenxiangziyuan(key)
if data then
xianmengModel:deleteData_fenxiangziyuan(key)

notifySystem:postNotify(notifyConfig.onXMFXZYDelete,data)
notifySystem:postNotify(notifyConfig.onXMFXZYSeek)

if isOwner then
UIManager.info("下架成功")
end
end
elseif errorCode==1 then
UIManager.error("求助信息不存在")
elseif errorCode==2 then
UIManager.error("已得到过分享")
end
end


function xianmengController.do_protocol_20_44(guid,errorCode)
if errorCode==0 then
xianmengModel:addShareTimes_fenxiangziyuan(guid)
local key=tostring(guid)
local complete=xianmengModel:addDataProgress_fenxiangziyuan(key)
if complete then
notifySystem:postNotify(notifyConfig.onXMFXZYComplete,key)
else
xianmengModel:clearOtherCache_fenxiangziyuan()
notifySystem:postNotify(notifyConfig.onXMFXZYProgress,key,true)
end
notifySystem:postNotify(notifyConfig.onXMFXZYShare)
elseif errorCode==1 then
UIManager.error("求助信息不存在")
elseif errorCode==2 then
UIManager.error("求助已完成")
end
end


function xianmengController.do_protocol_20_45(guid)
if not xianmengModel:checkData_fenxiangziyuan()then return end

local key=tostring(guid)
local complete=xianmengModel:addDataProgress_fenxiangziyuan(key)

if xianmengModel:isOwnerData_fenxiangziyuan(key)then
xianmengModel:setTipsFlag_fenxiangziyuan(true)
end

if xianmengModel:isOwnerData_fenxiangziyuan(key)then
notifySystem:postNotify(notifyConfig.onXMFXZYProgress,key,false)
else
if complete then
notifySystem:postNotify(notifyConfig.onXMFXZYComplete,key)
else
notifySystem:postNotify(notifyConfig.onXMFXZYProgress,key,false)
end
end
end


function xianmengController.do_protocol_20_46(len,list)
xianmengModel:setGainList_fenxiangziyuan(list)

if UIManager:isActive("UIXMFXZYGainDialog")then
UIManager:invokeUIMethod("UIXMFXZYGainDialog","onShow")
elseif len>0 then
msgWinControl:addMsgWin(msgWinType.eXMFXZYRewardMailTips,{},{},true)
else
xianmengController.do_protocol_20_47()
end
end


function xianmengController.do_protocol_20_47()
xianmengModel:clearGainList_fenxiangziyuan()
xianmengModel:setTipsFlag_fenxiangziyuan(false)
end